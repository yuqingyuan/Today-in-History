//
//  EventViewModel.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

#if DEBUG
let debugViewModel = EventViewModel(0, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg", title: "标题", year: "2020", month: 2, day: 3, details: "内容"))
#endif

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
    var title: String { event.title.trimmingCharacters(in: .whitespaces) }
    var detail: String {
        var str = event.details
        //使用的数据源有问题,有新的数据源后替换
        if let range = str.range(of: "if(isMobile()){cambrian.render(\'body\')}") {
            str.removeSubrange(range)
        }
        return str.trimmingCharacters(in: .whitespaces)
    }
    
    init(_ id: Int, event: HistoryEvent) {
        self.id = id
        self.event = event
    }
}
