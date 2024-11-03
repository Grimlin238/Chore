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
    
    var body: some View {
        
        VStack {
            
            List {
                
                ForEach(optionList, id: \.self) { option in
                    
                    Text(option)
                    
                }
            }
            
            Text("Version 1.0")
            
        }
    }
}

struct MoreOptionsView_previews: PreviewProvider {
    
    static var previews: some View {
        
        MoreOptionsView()
            .environmentObject(ChoreStore())
        
    }
}
