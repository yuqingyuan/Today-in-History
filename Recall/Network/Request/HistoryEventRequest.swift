//
//  EventRequest.swift
//  Recall
//
//  Created by 俞清源 on 2020/3/2.
//  Copyright © 2020 俞清源. All rights reserved.
//

import Foundation
import Combine

fileprivate struct HistoryEventResponse: Codable {
    let code: Int
    let msg: String
    let data: [HistoryEvent]
}

struct HistoryEventRequest {
    var publisher: AnyPublisher<[HistoryEvent], Error> {
        var request = URLRequest(url: URL(string: OpenAPI.eventApi)!)
        request.addValue(OpenAPI.appID, forHTTPHeaderField: "app_id")
        request.addValue(OpenAPI.appSecret, forHTTPHeaderField: "app_secret")
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: HistoryEventResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
