//
//  AddChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct AddChoreView: View {
    @EnvironmentObject var choreStore: ChoreStore
    
    @State private var selectedDate = Date()
    @State private var selectedTime = Date()
    @State private var userInput: String = ""
    @State private var showSuccessConformation = false
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
            
            addButtonView
            
        }
    }
    
    func toString_Date(date: Date) -> String {
        
        let formattedDate = DateFormatter()
        
        formattedDate.dateStyle = .medium
        
        formattedDate.timeStyle = .none
        
        return formattedDate.string(from: selectedDate)
        
    }
    
    func toString_Time(date: Date) -> String {
        
        let formattedTime = DateFormatter()
        
        formattedTime.dateStyle = .none
        
        formattedTime.timeStyle = .short
        
        return formattedTime.string(from: selectedTime)
        
    }
    
    func saveChore(chore: String) {
        
        let savedChore = userInput
        let date = toString_Date(date: selectedDate)
        
        let time = toString_Time(date: selectedTime)
        
        choreStore.addToChoreList(chore: savedChore, due: date, at: time)
        
    }
}

struct AddChoreView_preview: PreviewProvider {
    
    static var previews: some View {
        
    AddChoreView()
            .environmentObject(ChoreStore())
        
    }
}
