//
//  CalendarHelper.swift
//  FlipClock
//
//  Created by teenloong on 2022/1/27.
//

import Foundation

extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
    
    func generateTimerDate(date: Date) -> Date {
        let now = date
        let dateComponets = self.dateComponents(in: .current, from: now)
        let hours = dateComponets.hour ?? 0
        let minutes = dateComponets.minute ?? 0
        let seconds = dateComponets.second ?? 0
        let components = DateComponents(hour: -hours, minute: -minutes, second: -seconds)
        let timerDate = self.date(byAdding: components, to: now)!
        return timerDate
    }
    
    func nextDay(for date: Date) -> Date {
        dateInterval(of: .day, for: date)!.end
    }
    
    func nextHour(for date: Date) -> Date {
        dateInterval(of: .hour, for: date)!.end
    }
    
    func nextMinute(for date: Date) -> Date {
        dateInterval(of: .minute, for: date)!.end
    }
    
    func weekDates(date: Date) -> [Date] {
        guard let interval = dateInterval(of: .weekOfYear, for: date) else { return [] }

        return generateDates(inside: interval , matching: DateComponents(hour: 0, minute: 0, second: 0))
    }
}
