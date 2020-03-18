//
//  EventListViewModel.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import Combine

class EventListViewModel: ObservableObject {
    
    @Published var events: [EventViewModel] = []
    @Published var isLoading: Bool = false
    
    private let publisher = HistoryEventRequest().publisher
    private var cancellable: Cancellable? = nil
    
    func fetch() {
        self.isLoading.toggle()
        self.cancellable = publisher
            .sink(receiveCompletion: { complete in
                self.isLoading.toggle()
            }, receiveValue: { value in
                self.events = value
            })
    }
}
