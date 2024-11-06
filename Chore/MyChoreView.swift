//
//  MyChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct MyChoreView: View {
    
    @EnvironmentObject var choreStore: ChoreStore
    
    
    private var dueTodayView: some View {
        
        VStack {
            
            Text("Due Today")
            
            if choreStore.choreList.isEmpty || !choreStore.dueToday_Chores(list: choreStore.choreList) {
                
                Text("Nothing due")
                
            } else {
                
                
                List{
                    
                    ForEach(choreStore.choreList) { chore in
                        
                        Text("\(chore.chore). due \(chore.due) at \(chore.at)")
                        
                    }
                    
                    .onDelete {
                        indexSet in
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at)
                            
                        }
                    }
                }
            }
        }
        
    }
 
    var body: some View {
        
        VStack {
            
            dueTodayView
            
        }
        .onAppear {
            
            choreStore.sortChoreList()
            
        }
    }
}
