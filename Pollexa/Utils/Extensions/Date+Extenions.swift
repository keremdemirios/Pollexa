//
//  Date+Extenions.swift
//  Pollexa
//
//  Created by Kerem Demir on 27.05.2024.
//

import Foundation

extension Date {
    
    static func currentDateTime() -> Date {
        return Date()
    }
    
    func timeAgoDisplay() -> String {
        let calendar = Calendar.current
        let now = Date()
        
        let components = calendar.dateComponents([.year, .month, .day], from: self, to: now)
        
        if let year = components.year, year > 0 {
            return year == 1 ? "\(year) year ago" : "\(year) years ago"
        }
        
        if let month = components.month, month > 0 {
            return month == 1 ? "\(month) month ago" : "\(month) months ago"
        }
        
        if let day = components.day, day > 0 {
            return day == 1 ? "\(day) day ago" : "\(day) days ago"
        }
        
        return "Today"
    }

}
