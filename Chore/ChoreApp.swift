//
//  ChoreApp.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

@main
struct ChoreApp: App {
    
    @StateObject var choreStore = ChoreStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(choreStore)
        }
    }
}
