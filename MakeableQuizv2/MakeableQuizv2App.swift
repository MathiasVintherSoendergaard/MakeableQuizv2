//
//  MakeableQuizv2App.swift
//  MakeableQuizv2
//
//  Created by Mathias Vinther Søndergaard on 14/11/2022.
//

import SwiftUI

@main
struct MakeableQuizv2App: App {
    
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
