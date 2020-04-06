//
//  NotificationSetting.swift
//  Recall
//
//  Created by yuqingyuan on 2020/3/31.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

struct NotificationSetting {

    enum period: Int, CaseIterable, CustomStringConvertible, Identifiable, Codable {
        case sun = 1, mon, tues, wed, thur, fri, sat

        var id: Int { self.rawValue }
        
        var description: String {
            switch self {
            case .sun:   return "每周日"
            case .mon:   return "每周一"
            case .tues:  return "每周二"
            case .wed:   return "每周三"
            case .thur:  return "每周四"
            case .fri:   return "每周五"
            case .sat:   return "每周六"
            }
        }
    }
    
    /// 当前重复周期
    var currentPeriod = [NotificationSetting.period]()
    
    /// 通知推送时间
    var pushingDate = Date()
}

extension NotificationSetting: Codable {
    
    static let persistenceKey = "Notification_Setting"
    
    enum CodingKeys: String, CodingKey {
        case currentPeriod
        case pushingDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentPeriod = try container.decode([NotificationSetting.period].self, forKey: .currentPeriod)
        pushingDate = try container.decode(Date.self, forKey: .pushingDate)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(currentPeriod, forKey: .currentPeriod)
        try container.encode(pushingDate, forKey: .pushingDate)
    }
}
