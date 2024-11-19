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
            
            if choreStore.hasChoresDueToday() {
                
                List{
                    
                    ForEach(choreStore.choreList.filter { choreStore.isToday(day: "\($0.due)")}) { chore in

                            Text("\(chore.chore). Due today at \(chore.at)")
                    
                    }
                    
                    .onDelete {
                        indexSet in
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at, recurring: chore.recurring)
                            
                        }
                    }
                }
            } else {
                
                Text("Nothing due today")
                
            }
        }
    }
    
    private var upComingChoresView: some View {
        
        VStack {
            
            Text("Upcoming this Month")
            
            if choreStore.isOccupiedMonth() {
                
                List {
                    
                    ForEach(choreStore.choreList.filter { !choreStore.isToday(day: "\($0.due)") && $0.due.contains(choreStore.getCurrentMonth()) } .prefix(10) ) { chore in
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
    
    private var weeklyChoreView: some View {
        
        VStack {
            
            Text("Weekly chores")
            
            if choreStore.hasWeeklyChores() {
                
                List {
                    
                    ForEach(choreStore.choreList.filter { $0.recurring == .weekly }) { chore in
                        Text("\(chore.chore) - repeating every \(choreStore.getWeekDayFor(date: chore.due)) at \(chore.at)")
                    }
                    
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at, recurring: chore.recurring)
                        }
                    }
                }
            }
            
            else {
                
                Text("No weekly chores")
                
            }
        }
    }
    
    private var MonthlyChoreView: some View {
        
        VStack {
            
            Text("Monthly Chores")
            
            if choreStore.hasMonthlyChores() {
                
                List {
                    
                    ForEach(choreStore.choreList.filter { $0.recurring == .monthly }){ chore in
                        
                        Text("\(chore.chore) - repeating every month on the \(choreStore.getMonthSuffix(date: chore.due)) at \(chore.at)")
                        
                    }
                    
                    .onDelete { indexSet in
                        
                        indexSet.forEach { index in
                            
                            let chore = choreStore.choreList[index]
                            
                            choreStore.removeFromChoreList(chore: chore.chore, due: chore.due, at: chore.at, recurring: chore.recurring)
                            
                        }
                    }
                }
            } else {
                
                Text("No monthly chores")
                
            }
        }
    }
    
    var body: some View {
        
            VStack {
                
                dueTodayView
                
                upComingChoresView
                
                dailyChoreView
                
                weeklyChoreView
                
                MonthlyChoreView
                
            }
        
        .onAppear {
            
            choreStore.removePastChores()
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
