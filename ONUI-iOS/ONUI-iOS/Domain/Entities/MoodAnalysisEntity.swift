import Foundation
import SwiftUI

struct MoodAnalysisEntity: Equatable {
    let veryBad: Int
    let bad: Int
    let normal: Int
    let good: Int
    let veryGood: Int
}

struct MoodAnalysisGraphStorage: Equatable, Hashable {
    var mood: Mood
    var count: Int
    var color: Color {
        mood.foregroundColor
    }
}


extension MoodAnalysisEntity {
    var allMood: [MoodAnalysisGraphStorage] {
        [
            .init(mood: .veryGood, count: veryGood),
            .init(mood: .good, count: good),
            .init(mood: .normal, count: normal),
            .init(mood: .bad, count: bad),
            .init(mood: .veryBad, count: veryBad)
        ]
    }
}
