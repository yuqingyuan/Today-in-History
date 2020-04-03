//
//  NotificationSetting.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

struct NotificationSetting {

    enum period: Int, CaseIterable, CustomStringConvertible, Identifiable {
        case mon, tues, wed, thur, fri, sat, sun

        var id: Int { self.rawValue }
        
        var description: String {
            switch self {
            case .mon:   return "每周一"
            case .tues:  return "每周二"
            case .wed:   return "每周三"
            case .thur:  return "每周四"
            case .fri:   return "每周五"
            case .sat:   return "每周六"
            case .sun:   return "每周日"
            }
        }
    }
    
    /// 当前重复周期
    var currentPeriod = [NotificationSetting.period]()
    
    /// 通知推送时间
    var pushingDate = Date()
}
