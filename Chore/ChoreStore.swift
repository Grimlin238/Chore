//
//  ChoreStore.swift
//  Chore
//
//  Created by Tyion Lashley on 8/27/24.
//

import Foundation

class ChoreStore: ObservableObject {
    
    private var fileUrl: URL {
        
        let fileManager = FileManager.default
        
        let documentDirectories = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        let myDocumentDirectory = documentDirectories.first!
        
        let choreFileUrl = myDocumentDirectory.appendingPathComponent("chores.json")
        
        return choreFileUrl
        
    }
        
    @Published var choreList: [Chore] = []
    
    let notificationManager = NotificationManager()
    
    init() {
        
        loadChores()
        
        
    }
    
    func addToChoreList(chore: String, due: String, at: String, notificationIds: [String]) {
        
        choreList.append(Chore(chore: chore, due: due, at: at, notificationIds: notificationIds))
        
        saveChores()
        
    }
    
    func removeFromChoreList(chore: String, due: String, at: String) {
        
        if let index = choreList.firstIndex(where: {
            
            $0.chore == chore && $0.due == due && $0.at == at
            
        }) {
            
            let notificationIds = choreList[index].notificationIds
            
            notificationManager.cancelNotification(identifier: notificationIds)
            
            
            choreList.remove(at: index)
            
        }
        
        saveChores()
        
    }
    
    private func saveChores() {
        
        do {
            
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(choreList)
            
            try data.write(to: fileUrl)
            
        }
        
        catch {
            
            print("There was an issue detected in ChoreStore class. Issue: \(error)")
            
        }
               
    }
    
    private func loadChores() {
        
        do {
            
            let data = try Data(contentsOf: fileUrl)
            
            let decoder = JSONDecoder()
            
            choreList = try decoder.decode([Chore].self, from: data)
            
            
        }
        
        catch {
            
            print("Error loading tasks. issue: \(error)")
        }
    }
    
    func combine_Date(date: Date, time: Date) -> Date? {
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)
        
        var combinedComponents = DateComponents()
        
        combinedComponents.year = dateComponents.year
        
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        
        combinedComponents.hour = timeComponents.hour
        
        combinedComponents.minute = timeComponents.minute
        
        combinedComponents.second = timeComponents.second
        
        return calendar.date(from: combinedComponents)
        
    }
    
    func toString_Date(date: Date) -> String {
        
        let formattedDate = DateFormatter()
        
        formattedDate.dateStyle = .medium
        
        formattedDate.timeStyle = .none
        
        return formattedDate.string(from: date)
        
    }
    
    func toString_Time(date: Date) -> String {
        
        let formattedTime = DateFormatter()
        
        formattedTime.dateStyle = .none
        
        formattedTime.timeStyle = .short
        
        return formattedTime.string(from: date)
        
    }
    
}
