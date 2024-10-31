//
//  AddChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct AddChoreView: View {
    @EnvironmentObject var choreStore: ChoreStore
    @EnvironmentObject var notificationManager: NotificationManager
    
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var userInput: String = ""
    @State private var showSuccessConformation = false
    
    @State private var recurrsive: Repeating = .none
    private var textFieldView: some View {
        
        VStack {
            
            TextField("Enter Chore", text: $userInput)
            
        }
    }
    
    private var dateSelectionView: some View {
        
        VStack {
            
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
            
        }
    }
    
    private var timeSelectionView: some View {
        
        VStack {
            
            DatePicker("Choose a time", selection: $selectedTime, displayedComponents: .hourAndMinute)
            
        }
        
    }
    
    private var recurssionView: some View {
        
        VStack {
            
            Text("Recurring?")
                .accessibilityAddTraits(.isHeader)
            Picker("Repeating?", selection:  $recurrsive) {
                
                ForEach(Repeating.allCases, id: \.self) { recurrance in
                    
                    Text(recurrance.rawValue)
                    
                }
            }
            
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var addButtonView: some View {
        VStack {
            
            Button("Add to Chores") {
                
                saveChore(chore: userInput)
                
                showSuccessConformation = true
                
            }
            
            .disabled(userInput.isEmpty || userInput == " ")
            
            .alert(isPresented: $showSuccessConformation) {
                
                Alert(title: Text("Success =>"), message: Text("Your chore has been successfully saved."), dismissButton: .default(Text("Ok! Got it!")))
                
            }
            
        }
        
    }
    
    var body: some View {
        
        VStack {
            
            textFieldView
            
            dateSelectionView
            
            timeSelectionView
            
            recurssionView
            
            addButtonView
            
        }
        
    }
    
    func saveChore(chore: String) {
        
        let savedChore = userInput
        let date = choreStore.toString_Date(date: selectedDate)
        
        let time = choreStore.toString_Time(date: selectedTime)
        
        var eventRepeating: String = ""
        
        if recurrsive == .daily {
            
            eventRepeating = "(Repeating daily)"
            
        }
        
        if recurrsive == .weekly {
            
            eventRepeating = "(Repeating Weekly)"
            
        }
        
        
        if let combinedDate = choreStore.combine_Date(date: selectedDate, time: selectedTime) {
            
            let notificationIds = notificationManager.scheduleNotification(title: "Chore Reminder!", body: "Hey There! Don't forget your scheduled chore: \(userInput) on \(date) at \(time)", eventDate: combinedDate, recurring: recurrsive)
            
            choreStore.addToChoreList(chore: savedChore, due: date + " " + eventRepeating, at: time, notificationIds: notificationIds)
            
        }
    }
}

struct AddChoreView_preview: PreviewProvider {
    
    static var previews: some View {
        
    AddChoreView()
            .environmentObject(ChoreStore())
            .environmentObject(NotificationManager())
        
        
    }
}
