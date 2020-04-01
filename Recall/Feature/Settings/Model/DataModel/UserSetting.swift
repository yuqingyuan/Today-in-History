//
//  UserSetting.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

enum UserSettingList: String, CaseIterable, Hashable, Identifiable {
    case notification = "消息通知"
    
    var name: String {
        return self.rawValue
    }
    
    var id: UserSettingList { self }
}

enum UserSettingKeys {
    static let isNotificationOn = "is_Notification_On"
}
