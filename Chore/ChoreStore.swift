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
    
    @Published var helpItems: [Help] = [
        Help(header: "Help", body: "Press next to move to the next help item. Press previous to go back.Tap done to leave healp."),
        Help(header: "Deleting a chore", body: "On the My Chores tab, swipe left on a chore, then tap delete."),
        Help(header: "Adding a chore", body: "Tap the create a chore tab, then type something you want to be reminded about. select when you want to be reminded and if it's recurring. When you're finished, tap save to chores."),
        Help(header: "Need Support? Gott a question or suggestion?", body: "Need a little help, or have questions/suggestions, tap done, then tap Get Support. You'll then be able to write an email to me.")
    ]
    
    let notificationManager = NotificationManager()
    
    init() {
        
        loadChores()
        
        
    }
    
    func addToChoreList(chore: String, due: String, at: String, recurring: Repeating, notificationIds: [String]) {
        
        choreList.append(Chore(chore: chore, due: due, at: at, recurring: recurring, notificationIds: notificationIds))
        
        saveChores()
        
    }
    
    func removeFromChoreList(chore: String, due: String, at: String, recurring: Repeating) {
        
        if let index = choreList.firstIndex(where: {
            
            $0.chore == chore && $0.due == due && $0.at == at && $0.recurring == recurring
            
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
    
    func isToday(day: String) -> Bool {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM dd, yyyy h:mm a"
        
        guard let date = formatter.date(from: day) else {
            
            return false
            
        }
        
        let calendar = Calendar.current
        
        return calendar.isDateInToday(date)
        
    }
    
    func sortChoreList() {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM dd, yyyy h:mm a"
        
        choreList.sort { item1, item2 in
            
            let dateString1 = "\(item1.due) \(item1.at)"
            
            let dateString2 = "\(item2.due) \(item2.at)"
            
            let date1 = formatter.date(from: dateString1)
            
            let date2 = formatter.date(from: dateString2)
            
            return date1 ?? Date() < date2 ?? Date()
            
        }
        
    }
    
    
    func dueToday_Chores(list: [Chore]) -> Bool {
    
        for each in list {
            
            let combinedDate = "\(each.due) \(each.at)"
            
            if isToday(day: combinedDate) {
                
                return true
                
            }
        }
        
        return false
        
    }
    
    private func getCurrentMonth() -> String {
            
        let date = Date()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM"
        
        let currentMonth = dateFormatter.string(from: date)
        
        return currentMonth
        
    }
    
    func isOccupiedMonth() -> Bool {
        
        for each in choreList {
            
            if each.due.contains(getCurrentMonth()) && !isToday(day: "\(each.due) \(each.at)") {
                
                return true
                
            }
        }
        
        return false
        
    }
    
    func hasDailyChores() -> Bool {
        
        for each in choreList {
            
            if each.recurring == .daily {
                
                return true
                
            }
        }
        
        return false
        
    }
    
}
