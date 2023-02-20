//
//  NetworkService.swift
//  NetworkSample
//
//  Created by Neetika Mittal on 18/02/2023.
//

import Foundation
import Combine

enum ResponseError: Error {
    case urlMalformed
    case responseUnsuccessful
}

protocol NetworkServicing {
    var session: URLSession { get }
    func execute<T>(for urlRequest: URLRequest, decodingType: T.Type, queue: DispatchQueue, retryCount: Int) -> AnyPublisher<T, Error> where T:Decodable
}

extension NetworkServicing {
    
    func execute<T>(for urlRequest: URLRequest, decodingType: T.Type, queue: DispatchQueue, retryCount: Int) -> AnyPublisher<T, Error> where T:Decodable {
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
                    throw ResponseError.responseUnsuccessful
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .retry(retryCount)
            .eraseToAnyPublisher()
    }
    
}

