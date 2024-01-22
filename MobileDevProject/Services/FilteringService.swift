import Foundation

class FilteringService {
    static func filterSchedules(_ schedules: [Schedule], by filter: Filter) -> [Schedule] {
        let schedulesFilteredByDay = filterByDay(schedules, day: filter.eventDay)
        let schedulesFilteredByType = filterByType(schedulesFilteredByDay, type: filter.eventType)
        return schedulesFilteredByType
    }
    
    private static func filterByDay(_ schedules: [Schedule], day: EventDay) -> [Schedule] {
        switch day {
        case .all:
            return schedules
        case .firstDay:
            return schedules.filter { schedule in
                // Implement logic to check if the schedule is on the first day
                return isOnFirstDay(schedule.start)
            }
        case .secondDay:
            return schedules.filter { schedule in
                // Implement logic to check if the schedule is on the second day
                return isOnSecondDay(schedule.start)
            }
        }
    }
    
    private static func filterByType(_ schedules: [Schedule], type: Schedule.EventType) -> [Schedule] {
        guard type != .all else {
            return schedules
        }
        return schedules.filter { schedule in
            return schedule.type == type
        }
    }
    
    private static func isOnFirstDay(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let firstDayStart = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dateFormatter.date(from: "2024-02-08")!) // Midnight of the first day
        return Calendar.current.isDate(date, inSameDayAs: firstDayStart!)
    }
    
    private static func isOnSecondDay(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let secondDayStartDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: dateFormatter.date(from: "2024-02-09")!) // Midnight of the first day
        return Calendar.current.isDate(date, inSameDayAs: secondDayStartDate!)
    }
    
    
}
