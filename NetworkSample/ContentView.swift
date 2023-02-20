//
//  ContentView.swift
//  NetworkSample
//
//  Created by Neetika Mittal on 18/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CatFactViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.catFacts) { catFact in
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(catFact.fact)
            }
            .refreshable {
                viewModel.refresh()
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
