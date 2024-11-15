//
//  Date.swift
//  AlcoholHabits
//
//  Created by Karen Khachatryan on 15.11.24.
//

import Foundation

extension Date {
    func toString(format: String = "dd/MM/yy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func addWeeks(weeks: Int) -> Date? {
        var dateComponent = DateComponents()
        dateComponent.weekOfYear = weeks
        return Calendar.current.date(byAdding: dateComponent, to: self)
    }
    
    func calculateWeeks() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekOfYear], from: self, to: Date())
        return ((components.weekOfYear ?? 0) + 1)
    }
    
    func notifyDate() -> Date {
        if let date = Calendar.current.date(byAdding: .hour, value: -2, to: self), self < date {
            return date
        }
        return self
    }
    
    func setTime(time: Date) -> Date {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.hour, .minute, .second], from: time)
        let dateComponents2 = calendar.dateComponents([.year, .month, .day], from: self)
        if let newDate = calendar.date(from: dateComponents2)?.addingTimeInterval(TimeInterval(components1.hour! * 3600 + components1.minute! * 60 + components1.second!)) {
            return newDate
        }
        return Date()
    }
    
    func stripTime() -> Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
}
