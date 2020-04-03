//
//  NotificationSettingViewModel.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import Combine
import UIKit

protocol SettingProtocol {
    /// 保存当前设置
    func saveSettings()
}

class NotificationSettingViewModel: ObservableObject {
    
    private var cancellable = [Cancellable]()
    private var settingModel = NotificationSetting()
    
    init() {
        cancellable.append(contentsOf: [notifactionChange, foregroundChange])
        syncNotificationStatus()
        decodeSettings()
    }
    
    /// 通知是否开启(跟随系统设置)
    @Published var isOn: Bool = false {
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
    
    /// 通知推送日期
    @Published var pushDate = Date()
    
    /// 已选重复周期
    @Published var periodSelection = [NotificationSetting.period.RawValue]()
    
    /// 重复周期选择列表
    @Published var periodList = NotificationSetting.period.allCases
}

//MARK: - SettingProtocol
extension NotificationSettingViewModel: SettingProtocol {
    func saveSettings() {
        settingModel.currentPeriod = periodSelection
        settingModel.pushingDate = pushDate
        persistSettings()
    }
    
    func persistSettings() {
        let data = try! JSONEncoder().encode(settingModel)
        UserDefaults.standard.set(data, forKey: NotificationSetting.persistenceKey)
    }
    
    func decodeSettings() {
        if let data = UserDefaults.standard.value(forKey: NotificationSetting.persistenceKey) as? Data,
            let model = try? JSONDecoder().decode(NotificationSetting.self, from: data) {
            periodSelection = model.currentPeriod
            pushDate = model.pushingDate
        }
    }
}

//MARK: - Notification
extension NotificationSettingViewModel {
    /// 查询通知权限状态并同步
    private var notifactionChange: AnyCancellable {
        NotificationService.shared.notificationChange
            .receive(on: DispatchQueue.main)
            .sink {
                self.isOn = $0
            }
    }

    /// 从后台进入时同步通知权限状态
    private var foregroundChange: AnyCancellable {
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.syncNotificationStatus()
            }
    }
    
    /// 同步通知权限状态
    private func syncNotificationStatus() {
        NotificationService.shared.getAuthorizationStatus { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .provisional: self.isOn = true
                default: self.isOn = false
                }
            }
        }
    }
        
    /// 聚合Toggle开关状态和系统通知权限
    enum NotificationToggleStatus: RawRepresentable {

        case notDetermined
        case denied
        case authorized

        init?(rawValue: (UNAuthorizationStatus, Bool)) {
            switch rawValue {
            case (.notDetermined, true): self = .notDetermined  //系统未授权
            case (.denied, true): self = .denied    //被拒绝
            case (.authorized, false), (.provisional, false): self = .authorized    //已授权
            default: return nil
            }
        }

        var rawValue: (UNAuthorizationStatus, Bool) {
            switch self {
            case .notDetermined: return (.notDetermined, true)
            case .denied: return (.denied, true)
            case .authorized: return (.authorized, false)
            }
        }
    }
    
    /// 根据NotificationToggleStatus状态同步Toggle状态并是否展示引导弹窗
    private func modifyNotificationStatus(_ status: UNAuthorizationStatus, newValue: Bool) {
        let type = NotificationToggleStatus(rawValue: (status, newValue))
        switch type {
        case .notDetermined:
            NotificationService.shared.requestAuthorization()
        case .denied:
            self.isOn = false
            self.showBootAlert = true
        case .authorized:
            self.showBootAlert = true
            self.isOn = true
        default: break
        }
    }
}
