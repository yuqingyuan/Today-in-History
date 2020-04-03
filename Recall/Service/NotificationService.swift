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
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            self.notificationChange.send(granted)
        }
    }
    
    func getAuthorizationStatus(_ completionHandler: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            completionHandler(settings.authorizationStatus)
        }
    }
}

extension NotificationService {
    func prepareLocalNotification() {
        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = "历史上的今天"
        content.body = "快来看看今天历史上发生了什么吧～"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY年MM月dd日"
        content.subtitle = formatter.string(from: Date())

        var dateComponents = DateComponents()
        dateComponents.hour = 8;
        dateComponents.minute = 30;
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "local", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error?.localizedDescription ?? "本地通知创建成功")
        }
    }
}
