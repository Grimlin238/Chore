//
//  Chore.swift
//  Chore
//
//  Created by Tyion Lashley on 8/27/24.
//

import SwiftUI

struct Chore: Identifiable {
    let id: UUID
    let chore: String
    let due: String
    let at: String
    
    init(chore: String, due: String, at: String) {
        id = UUID()
        self.chore = chore
        self.due = due
        self.at = at
    }
}
