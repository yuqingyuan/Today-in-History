//
//  EventListViewModel.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation

class EventListViewModel: ObservableObject {
    
    @Published var events: [EventViewModel] = []
    @Published var isLoading: Bool = false
    
    let request = HistoryEventRequest()
    
    init() {
        
    }
    
    func fetch() {
        
    }
}
