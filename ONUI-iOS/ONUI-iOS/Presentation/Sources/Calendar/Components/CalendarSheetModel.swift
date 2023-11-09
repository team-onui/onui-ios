import Foundation

struct CalendarSheetModel: Equatable, Identifiable {
    let id: String
    let date: Date
    let day: Int
    let mood: Mood?

    init(id: String, date: Date, day: Int, mood: Mood?) {
        self.id = id
        self.date = date
        self.day = day
        self.mood = mood
    }
}
