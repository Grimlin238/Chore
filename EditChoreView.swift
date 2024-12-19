//
//  EditChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 11/13/24.
//

import SwiftUI

struct EditChoreView: View {
    
    @EnvironmentObject var choreStore: ChoreStore
    
    @State var enjectedChore: String
    var enjectedDate: String
    var enjectedTime: String
    @State var enjectedRecursiveValue: Repeating
    
    @State var selectedDate: Date
    
    @State var selectedTime: Date

    init(enjectedChore: String = "Default", enjectedDate: String = "", enjectedTime: String = "", enjectedRecursiveValue: Repeating = .none) {
    
        _enjectedChore = State(initialValue: enjectedChore)
        
        self.enjectedDate = enjectedDate
        self.enjectedTime = enjectedTime
        _enjectedRecursiveValue = State(initialValue: enjectedRecursiveValue)
        _selectedDate = State(initialValue: Date())
        _selectedTime = State(initialValue: Date())
        
    }
    
    private var textFieldView: some View {
        
        VStack {
            
            TextField("Enter Chore", text: $enjectedChore)
            
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
            Picker("Repeating?", selection:  $enjectedRecursiveValue) {
                
                ForEach(Repeating.allCases, id: \.self) { recurrance in
                    
                    Text(recurrance.rawValue)
                    
                }
            }
            
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    var body: some View {
        
        VStack {
            
            textFieldView
            
            dateSelectionView
            
            timeSelectionView
            
            recurssionView
            
        }
        
    }
    
}
