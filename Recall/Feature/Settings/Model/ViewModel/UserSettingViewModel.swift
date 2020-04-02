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
        syncNotificationStatus()
    }
    
    /// 查询通知权限状态并同步
    var notifactionChange: AnyCancellable {
        NotificationService.shared.notificationChange
            .receive(on: DispatchQueue.main)
            .sink {
                self.isNotificationOn = $0
            }
    }

    /// 从后台进入时同步通知权限状态
    var foregroundChange: AnyCancellable {
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.syncNotificationStatus()
            }
    }
    
    /// 同步通知权限状态
    func syncNotificationStatus() {
        NotificationService.shared.getAuthorizationStatus { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .provisional: self.isNotificationOn = true
                default: self.isNotificationOn = false
                }
            }
        }
    }
    
    /// 通知是否开启(跟随系统设置)
    @Published var isNotificationOn: Bool = false {
        willSet {
            NotificationService.shared.getAuthorizationStatus { status in
                DispatchQueue.main.async {
                    self.modifyNotificationStatus(status, newValue: newValue)
                }
            }
        }
    }
    
    /// 是否展示开启通知权限引导弹窗
    @Published var showBootAlert = false
    
    private func modifyNotificationStatus(_ status: UNAuthorizationStatus, newValue: Bool) {
        if status == .notDetermined && newValue {
            NotificationService.shared.requestAuthorization()
        } else if status == .denied && newValue {
            self.isNotificationOn = false
            self.showBootAlert = true
        } else if (status == .authorized || status == .provisional) && !newValue {
            self.showBootAlert = true
            self.isNotificationOn = true
        }
    }
}
