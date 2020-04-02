//
//  UserSetting.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

enum UserSettingList: String {
    
    case notification = "消息通知"
    
    enum Frequency: String {
        case mon  = "周一"
        case tues = "周二"
        case wed  = "周三"
        case thur = "周四"
        case fri  = "周五"
        case sat  = "周六"
        case sun  = "周日"
    }
}
