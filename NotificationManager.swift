//
//  NotificationManager.swift
//  Chore
//
//  Created by Tyion Lashley on 8/31/24.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, eventDate: Date, recurring: Repeating) -> [String] {
        
        var notificationIds = [String]()
        
        switch(recurring) {
            
        case .none:
            
            let intervals: [TimeInterval] = [
                -14 * 24 * 60 * 60,
                 -7 * 24 * 60 * 60,
                 -5 * 24 * 60 * 60,
                 -24 * 60 * 60,
                 -60 * 60,
                 -30 * 60,
                 -15 * 60,
                 0]
            
            for interval in intervals {
                if let reminderDate = Calendar.current.date(byAdding: .second, value: Int(interval), to: eventDate) {
                    let id = scheduleNotificationAtDate(title: title, body: body, date: reminderDate)
                    
                    notificationIds.append(id)
                    
                }
            }
            
        case .daily:
            
            let id = scheduleRepeatingNotification(title: title, body: body, eventDate: eventDate, accurring: .day)
            
            notificationIds.append(id)
            
        case .weekly:
            
            let id = scheduleRepeatingNotification(title: title, body: body, eventDate: eventDate, accurring: .weekOfYear)
            
            notificationIds.append(id)
            
        case .monthly:
            let id = scheduleMonthlyNotification(title: title, body: body, eventDate: eventDate)
            
            notificationIds.append(id)
            
        }
        
        return notificationIds
        
    }
    
    private func adjustDate(eventDate: Date) -> Date {
    
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: eventDate)
        
        if let _ = dateComponents.month, let _ = dateComponents.year {
            let lastDayOfMonth = Calendar.current.range(of: .day, in: .month, for: eventDate)?.last ?? 28
            
            if (dateComponents.day ?? 1) > lastDayOfMonth {
                dateComponents.day = lastDayOfMonth
            }
        }
        
        return Calendar.current.date(from: dateComponents) ?? eventDate
    }

    private func scheduleMonthlyNotification(title: String, body: String, eventDate: Date) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let adjustedDate = adjustDate(eventDate: eventDate)
        let triggerDateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: adjustedDate)

        print("Monthly notification set for day \(triggerDateComponents.day ?? -1) at \(triggerDateComponents.hour ?? -1):\(triggerDateComponents.minute ?? -1)")

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: true)
        let identifier = UUID().uuidString

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling monthly notification: \(error.localizedDescription)")
            } else {
                print("Monthly notification scheduled successfully.")
            }
        }

        return identifier
    }
    
    private func scheduleRepeatingNotification(title: String, body: String, eventDate: Date, accurring: NSCalendar.Unit) -> String {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let timeInterval = eventDate.timeIntervalSinceNow
                
        guard timeInterval > 0 else {
            print("Cannot schedule notifications for a past event date.")
            return ""
        }
        
        var triggerDateComponents = Calendar.current.dateComponents([.hour, .minute], from: eventDate)
        
        switch accurring {
        case .day:
            break
        case .weekOfYear:
            triggerDateComponents.weekday = Calendar.current.component(.weekday, from: eventDate)
            
        default:
            break
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: true)
        let identifier = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling repeating notification: \(error.localizedDescription)")
            } else {
                print("Repeating notification scheduled with interval \(accurring)")
            }
        }
        
        return identifier
    }
    
    private func scheduleNotificationAtDate(title: String, body: String, date: Date) -> String {
        let timeInterval = date.timeIntervalSinceNow
        guard timeInterval > 0 else {
            print("Notification not scheduled because the time interval is not greater than 0.")
            return ""
        
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let identifier = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for: \(date)")
            }
        }
        
        return identifier
        
    }
    
    func cancelNotification(identifier: [String]) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifier)
        
    }
    
}
