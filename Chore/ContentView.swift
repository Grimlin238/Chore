//
//  ContentView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var notificationManager: NotificationManager
    
    var body: some View {
        TabView {
            MyChoreView()
                .tabItem {
                    
                    Text("My Chores")
                    
                }
            
            AddChoreView()
                .tabItem {
                    
                    Text("Create a Chore")
                    
                }
            
            MoreOptionsView()
                .tabItem {
                    
                    Text("More")
                    
                }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
            .environmentObject(NotificationManager())
        
    }
}
