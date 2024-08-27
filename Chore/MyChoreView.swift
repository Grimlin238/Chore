//
//  MyChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct MyChoreView: View {
    @EnvironmentObject var choreStore: ChoreStore
    
    var body: some View {
        
        if choreStore.choreList.isEmpty {
            
            VStack {
                    
                Text("You don't have any chores.")
                
            }
                
            } else {

                VStack {
                    
                    List {
                        
                        ForEach(choreStore.choreList) {
                            
                            chore in
                            ChoreView(chore: chore.chore, due: chore.due, at: chore.at)
                            
                        }
                    }
                }
            }
        }
    }
        
struct MyChoreView_preview: PreviewProvider {
    
    static var previews: some View {
        
        MyChoreView()
            .environmentObject(ChoreStore())
        
    }
}
