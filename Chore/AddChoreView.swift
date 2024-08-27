//
//  AddChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct AddChoreView: View {
    @EnvironmentObject var choreStore: ChoreStore
    
    var body: some View {
        
        VStack {
            
            Text("Nothing yet. But there will be =>")
            
        }
    }
}

struct AddChoreView_preview: PreviewProvider {
    
    static var previews: some View {
        
        AddChoreView()
            .environmentObject(ChoreStore())
        
    }
}
