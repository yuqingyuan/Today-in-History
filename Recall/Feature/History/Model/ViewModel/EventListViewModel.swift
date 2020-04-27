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
    @Published var loading: Bool = false
    @Published var error: Bool = false
    
    private let publisher = HistoryEventRequest().publisher
    private var cancellable = [AnyCancellable]()
    
    func fetch() {
        self.loading.toggle()
        
        publisher
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print(error)
                    self.error.toggle()
                    fallthrough
                default:
                    self.loading.toggle()
                }
            }, receiveValue: { value in
                self.events = value
            }).store(in: &cancellable)
    }
}
