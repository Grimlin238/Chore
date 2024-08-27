//
//  MoreOptionsView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/26/24.
//

import SwiftUI

struct MoreOptionsView: View {
    @EnvironmentObject var choreStore: ChoreStore
    
    var body: some View {
        
        VStack {
            
            Text("Nothing yet. But there will be =>")
            
        }
    }
}

struct MoreOptionsView_previews: PreviewProvider {
    
    static var previews: some View {
        
        MoreOptionsView()
            .environmentObject(ChoreStore())
        
    }
}
