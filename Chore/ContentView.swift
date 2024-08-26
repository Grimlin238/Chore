//
//  ContentView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MyCHoreView()
                .tabItem {
                    
                    Text("My Chores")
                    
                }
            
            AddChoreView()
                .tabItem {
                    
                    Text("Add CHore")
                    
                }
            
            MoreOptionsView()
                .tabItem {
                    
                    Text("More options")
                    
                }
        }
    }
}

#Preview {
    ContentView()
}

