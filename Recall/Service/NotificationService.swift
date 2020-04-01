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
