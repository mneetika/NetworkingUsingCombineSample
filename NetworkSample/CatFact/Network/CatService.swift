//
//  CatService.swift
//  NetworkSample
//
//  Created by Neetika Mittal on 18/02/2023.
//

import Foundation
import Combine

class CatService: NetworkServicing {
    var session: URLSession
    
    private let url = "https://catfact.ninja/fact"
    
    init(with session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchCatNinjaFact() -> AnyPublisher<CatFact, Error> {
        
        guard let url = URL(string: url) else {
            print("assert here, cannot create url")
            return Fail(error: ResponseError.urlMalformed).eraseToAnyPublisher()
        }
        
        let request = URLRequest(url: url)
        return execute(for: request,
                decodingType: CatFact.self,
                queue: DispatchQueue.main,
                retryCount: 0)
    }
    
    
}
