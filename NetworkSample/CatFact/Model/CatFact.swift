//
//  CatFact.swift
//  NetworkSample
//
//  Created by Neetika Mittal on 18/02/2023.
//

import Foundation

struct CatFact: Decodable, Identifiable {
    var id = UUID()
        
    let fact: String
    let length: Int
    
    enum CodingKeys: CodingKey {
        case fact
        case length
    }
}
