//
//  ChoreView.swift
//  Chore
//
//  Created by Tyion Lashley on 8/27/24.
//

import SwiftUI

struct ChoreView: View {
    
    var chore: String
    var due: String
    var at: String
    
    var body: some View {
        
        VStack {
            
            Text("\(chore), due \(due) at \(at)")
            
        }
    }
}
