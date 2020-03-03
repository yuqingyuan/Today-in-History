//
//  EventViewModel.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

class EventViewModel: Identifiable {
    
    var id: Int
    
    private var event: HistoryEvent
    
    var picURL: URL? {
        if let url = event.picUrl {
            return URL(string: url)
        }
        return nil
    }
    var dateStr: String { "\(event.year)年\(event.month)月\(event.day)日" }
    var title: String { event.title }
    var detail: String { event.details }
    
    init(_ id: Int, event: HistoryEvent) {
        self.id = id
        self.event = event
    }
}
