//
//  CatFactViewModel.swift
//  NetworkSample
//
//  Created by Neetika Mittal on 18/02/2023.
//

import Foundation
import Combine

class CatFactViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    private let service = CatService()
    @Published var catFacts = [CatFact]()
        
    init() {
        fetchCatFact()
    }
    
    private func fetchCatFact() {
        cancellable = service
            .fetchCatNinjaFact()
            .sink { _ in } receiveValue: { catFact in
                self.catFacts.insert(catFact, at: 0)
            }
    }
    
    func refresh() {
        cancellable?.cancel()
        fetchCatFact()
    }
}
