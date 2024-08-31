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
    
    @StateObject var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(choreStore)
            
                .environmentObject(notificationManager)
            
                .onAppear {
                    
                    notificationManager.requestPermission()
                    
                }
        }
    }
}
