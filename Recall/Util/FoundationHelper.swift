//
//  FoundationHelper.swift
//  Recall
//
//  Created by yuqingyuan on 2020/4/6.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

extension Date {
    func dateFormatter(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
