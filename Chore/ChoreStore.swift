//
//  ChoreStore.swift
//  Chore
//
//  Created by Tyion Lashley on 8/27/24.
//

import Foundation

class ChoreStore: ObservableObject {
    
    @Published var choreList: [Chore] = []
    
    func addToChoreList(chore: String, due: String, at: String) {
        
        choreList.append(Chore(chore: chore, due: due, at: at))
        
    }
    
    func removeFromChoreList(chore: String, due: String, at: String) {
        
        if let index = choreList.firstIndex(of: Chore(chore: chore, due: due, at: at)) {
            
            choreList.remove(at: index)
            
        }
    }
    
}
