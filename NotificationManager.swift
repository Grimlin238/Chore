//
//  NotificationManager.swift
//  Chore
//
//  Created by Tyion Lashley on 8/31/24.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager: ObservableObject {
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting permission: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotification(title: String, body: String, eventDate: Date) -> [String] {
        
        var notificationIds = [String]()
        
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
        
        return notificationIds
        
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
    
}
