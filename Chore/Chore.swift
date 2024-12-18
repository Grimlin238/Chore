//
//  Chore.swift
//  Chore
//
//  Created by Tyion Lashley on 8/27/24.
//

import SwiftUI

struct Chore: Identifiable, Equatable, Codable {
    let id: UUID
    let chore: String
    let due: String
    let at: String
    let recurring: Repeating
    var notificationIds: [String]
    
    init(chore: String, due: String, at: String, recurring: Repeating, notificationIds: [String]) {
        id = UUID()
        self.chore = chore
        self.due = due
        self.at = at
        self.recurring = recurring
        self.notificationIds = notificationIds
    }
    
    static func == (lhs: Chore, rhs: Chore) -> Bool {
        
        return lhs.chore == rhs.chore && lhs.due == rhs.due && lhs.at == rhs.at
        
    }
}
