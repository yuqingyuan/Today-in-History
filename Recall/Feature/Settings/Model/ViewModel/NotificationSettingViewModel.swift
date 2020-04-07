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
    
    enum AlertIdentifier: Int, Identifiable {
        case boot       //引导
        case success    //保存设置成功
        case failure    //保存设置失败
        
        var id: Int { self.rawValue }
    }
    
    private var cancellable = [AnyCancellable]()
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
    
    /// 控制弹窗
    @Published var alertIdentifier = AlertIdentifier(rawValue: -1)
    
    /// 通知推送日期
    @Published var pushDate = Date()
    
    /// 已选重复周期
    @Published var periodSelection = [NotificationSetting.period]()
    
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
    
    /// 保存通知设置
    func persistSettings() {
        if let data = try? JSONEncoder().encode(settingModel) {
            UserDefaults.standard.set(data, forKey: NotificationSetting.persistenceKey)
            // 移除所有本地通知
            NotificationService.shared.removeAlllocalNotification()
            // 监听保存设置是否成功错误
            NotificationService.shared.activationChange
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { error in
                    self.alertIdentifier = .failure
                }) { value in
                    self.alertIdentifier = .success
                }.store(in: &cancellable)
            // 启用本地通知
            var components = Calendar(identifier: .chinese).dateComponents([.hour, .minute], from: pushDate)
            let dateFormat = pushDate.dateFormatter("YYYY-MM-dd")
            for day in periodSelection {
                components.weekday = day.rawValue
                let identifier = String(day.rawValue) + "-" + dateFormat
                NotificationService.shared.activateLocalNotification(identifier, repeats: true, at: components)
            }
            if periodSelection.isEmpty {
                NotificationService.shared.activateLocalNotification(dateFormat, repeats: false, at: components)
            }
        }
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
            self.alertIdentifier = .boot
        case .authorized:
            self.alertIdentifier = .boot
            self.isOn = true
        default: break
        }
    }
}
