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
            
            if !choreStore.dueToday_Chores(list: choreStore.choreList) {
                
                Text("Nothing due")
                
            } else {
                
                
                List{
                    
                    ForEach(choreStore.choreList.filter { choreStore.isToday(day: "\($0.due) \($0.at)")}) { chore in
                        
                        Text("\(chore.chore). due \(chore.due) at \(chore.at)")
                        
                    }
                    
                    .onDelete {
                        indexSet in
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at, recurring: chore.recurring)
                            
                        }
                    }
                }
            }
        }
    }
    
    private var upComingChoresView: some View {
        
        VStack {
            
            Text("Upcoming Chores")
            
            if choreStore.isOccupiedMonth() {
                
                List {
                    
                    ForEach(choreStore.choreList.filter { !choreStore.isToday(day: "\($0.due) \($0.at)")}) { chore in
                        Text("\(chore.chore) due \(chore.due) at \(chore.at)")
                    }
                    
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at, recurring: chore.recurring)
                            
                        }
                    }
                }
            } else {
                
                Text("Nothing due this month.")
                
            }
        }
    }
    
    private var dailyChoreView: some View {
        
        VStack {
            
            Text("Daily Chores")
            
            if !choreStore.choreList.isEmpty && choreStore.hasDailyChores() {
                
                List {
                    
                    ForEach(choreStore.choreList.filter { $0.recurring == .daily}) { chore in
                        
                        Text("\(chore.chore) -- Repeating daily at \(chore.at)")
                    }
                    
                    .onDelete { indexSet in
                        
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at, recurring: chore.recurring)
                            
                        }
                        
                    }
                    
                }
                
            }else {
                
                Text("No daily Chores")
                
            }
        }
    }
    
    var body: some View {
        
        VStack {
            
            dueTodayView
            
            upComingChoresView
            
            dailyChoreView
            
        }
        .onAppear {
            
            choreStore.sortChoreList()
            
        }
    }
}

struct MyChoreView_preview: PreviewProvider {
    
    static var previews: some View {
        
        MyChoreView()
        
            .environmentObject(ChoreStore())
    }
}
