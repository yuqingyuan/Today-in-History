//
//  HistoryEvent.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

struct HistoryEvent: Codable {
    let picUrl: String?
    let title: String
    let year: String
    let month: Int
    let day: Int
    let details: String
}
