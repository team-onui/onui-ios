import Foundation

struct CalendarSheetModel: Equatable, Identifiable {
    let id: String = UUID().uuidString
    let date: Date
    let day: Int
    let mood: Mood?

    init(date: Date, day: Int, mood: Mood? = nil) {
        self.date = date
        self.day = day
        self.mood = mood
    }
}
