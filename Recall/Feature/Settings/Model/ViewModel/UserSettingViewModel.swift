//
//  UserSettingViewModel.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import Combine
import UIKit

class UserSettingViewModel: ObservableObject {
    
    private var cancellable = [Cancellable]()
    
    init() {
        cancellable.append(contentsOf: [notifactionChange, foregroundChange])
        
        NotificationService.shared.getAuthorizationStatus {
            switch $0 {
            case .authorized, .provisional: self.isNotificationOn = true
            default: self.isNotificationOn = false
            }
        }
    }
    
    //MARK: 查询通知权限状态并同步
    var notifactionChange: AnyCancellable {
        NotificationService.shared.notificationChange
            .receive(on: DispatchQueue.main)
            .sink {
                self.isNotificationOn = $0
            }
    }

    //MARK: 从后台进入时同步通知权限状态
    var foregroundChange: AnyCancellable {
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                NotificationService.shared.requestAuthorization()
            }
    }
    
    // 通知是否开启(跟随系统设置)
    @Published var isNotificationOn: Bool = false {
        willSet {
            if (newValue && !self.isNotificationOn) || (!newValue && self.isNotificationOn) {
                NotificationService.shared.requestAuthorization()
            }
        }
    }
}
