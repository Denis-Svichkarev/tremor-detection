//
//  DateExtensions.swift
//  TremorDetection
//
//  Created by Denis Svichkarev on 25.11.2020.
//

import Foundation

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
    
    func string() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: self)
    }
    
    static func daysBetweenDates(date1: Date, date2: Date) -> Int {
        let calendar = Calendar.current
        if let date1 = calendar.date(bySettingHour: 12, minute: 00, second: 00, of: calendar.startOfDay(for: date1)),
            let date2 = calendar.date(bySettingHour: 12, minute: 00, second: 00, of: calendar.startOfDay(for: date2)) {
                     
            let diffComponents = Calendar.current.dateComponents([.day], from: date1, to: date2)
            if let days = diffComponents.day {
                return abs(days)
            }
        }
        return 0
    }
    
    static func hoursBetweenDates(date1: Date, date2: Date) -> Int {
        let diffComponents = Calendar.current.dateComponents([.hour], from: date1, to: date2)
        if let hours = diffComponents.hour {
            return abs(hours)
        }
        return 0
    }
    
    static func minutesBetweenDates(date1: Date, date2: Date) -> Int {
        let diffComponents = Calendar.current.dateComponents([.minute], from: date1, to: date2)
        if let minutes = diffComponents.minute {
            return abs(minutes)
        }
        return 0
    }
}
