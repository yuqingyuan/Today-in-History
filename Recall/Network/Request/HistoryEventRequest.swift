//
//  EventRequest.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import Combine

struct HistoryEventRequest {
    
    var publisher: AnyPublisher<[EventViewModel], Error> {
        eventPublisher()
            .map { $0.enumerated().map { EventViewModel($0.offset, event: $0.element) } }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private var eventRequest: URLRequest {
        var request = URLRequest(url: URL(string: OpenAPI.eventApi)!)
        request.allHTTPHeaderFields = ["app_id": OpenAPI.appID, "app_secret": OpenAPI.appSecret]
        return request
    }
    
    private struct HistoryEventResponse: Codable {
        let code: Int
        let msg: String
        let data: [HistoryEvent]
    }
    
    private func eventPublisher() -> AnyPublisher<[HistoryEvent], Error> {
        URLSession.shared
            .dataTaskPublisher(for: eventRequest)
            .map { $0.data }
            .decode(type: HistoryEventResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
    
}
