import Foundation

struct MonthlyAnalysisEntity: Equatable, Hashable {
    let list: [ShortDiaryEntity]
    let message: String
}
