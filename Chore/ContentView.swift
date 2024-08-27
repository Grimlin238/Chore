//
//  ContentView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var choreStore: ChoreStore
    var body: some View {
        TabView {
            MyChoreView()
                .tabItem {
                    
                    Text("My Chores")
                    
                }
            
            AddChoreView()
                .tabItem {
                    
                    Text("Add Chore")
                    
                }
            
            MoreOptionsView()
                .tabItem {
                    
                    Text("More options")
                    
                }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ContentView()
            .environmentObject(ChoreStore())
        
    }
}
