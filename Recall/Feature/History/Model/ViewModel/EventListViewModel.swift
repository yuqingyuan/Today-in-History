//
//  EventListViewModel.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

class EventListViewModel: ObservableObject {
    
    @Published var events: [EventViewModel] = [EventViewModel(0, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg", title: "", year: "", month: "", day: "", details: "")),
                                               EventViewModel(1, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg", title: "", year: "", month: "", day: "", details: "")),
                                               EventViewModel(2, event: HistoryEvent(picUrl: "http://www.todayonhistory.com/upic/201002/18/791933708.jpg", title: "", year: "", month: "", day: "", details: ""))]
    
    init() {
        
    }
}
