//
//  MoreOptionsView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct MoreOptionsView: View {
    @EnvironmentObject var choreStore: ChoreStore
    
    let optionList = ["Help", "Get Support"]
    
    @State private var index = 0
    
    @State private var showHelpView = false
    
    private var helpTextView: some View {
        
        VStack {
            
            Button("Done") {
                
                showHelpView = false
                
            }
            
            Text(choreStore.helpItems[index].header)
            
            Text(choreStore.helpItems[index].body)
        }
    }
    
    private var helpNavButtonsView: some View {
        
        HStack {
            
            Button("Previous") {
                
                index = index - 1
                
            }
            
            Button("Next") {
                
                index = index + 1
                
            }
        }
    }
    
    private var helpView: some View {
        
        VStack {
            
            helpTextView
            helpNavButtonsView
            
        }
    }
    
    var body: some View {
        
        VStack {
            
            List {
                
                ForEach(optionList, id: \.self) { option in
                    
                    Text(option)
                    
                        .onTapGesture {
                                if option == "Help" {
                                    
                                    showHelpView = true
                                }
                            }
                    
                }
            }
            
            Text("Version 1.0")
            
        }
        
        .sheet(isPresented: $showHelpView) {
            
            helpView
            
        }
        .interactiveDismissDisabled(false)
    }
}

struct MoreOptionsView_previews: PreviewProvider {
    
    static var previews: some View {
        
        MoreOptionsView()
            .environmentObject(ChoreStore())
        
    }
}
