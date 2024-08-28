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
                showSuccessConformation = true
                
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
}

struct AddChoreView_preview: PreviewProvider {
    
    static var previews: some View {
        
    AddChoreView()
            .environmentObject(ChoreStore())
        
    }
}
