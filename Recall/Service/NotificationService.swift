//
//  NotificationService.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import UserNotifications
import Combine

class NotificationService {
    
    static let shared = NotificationService()
    
    let notificationChange = PassthroughSubject<Bool, Never>()
    var activationChange = PassthroughSubject<Bool, Error>()
    
    /// 请求通知授权
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            self.notificationChange.send(granted)
        }
    }
    
    /// 获取通知权限状态
    func getAuthorizationStatus(_ completionHandler: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            completionHandler(settings.authorizationStatus)
        }
    }
}

extension NotificationService {
    
    func activateLocalNotification(_ identifier: String, repeats: Bool, at dateComponents: DateComponents) {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = "历史上的今天"
        content.body = "快来看看今天历史上发生了什么吧～"
        content.subtitle = Date().dateFormatter("YYYY年M月d日")
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                self.activationChange.send(completion: .failure(error))
            } else {
                self.activationChange.send(true)
            }
        }
    }
    
    func removeAlllocalNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
