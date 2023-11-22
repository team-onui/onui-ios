import Foundation

struct FetchMonthlyAnalysisResponseDTO: Decodable {
    let list: [ShortDiaryResponseDTO]?
    let message: String
}

extension FetchMonthlyAnalysisResponseDTO {
    func toDomain() -> MonthlyAnalysisEntity {
        var shortDiaryList: [ShortDiaryEntity] {
            guard let l = list else { return [] }
            return l.map { ShortDiaryEntity(id: $0.id, mood: $0.mood.toDomain(), createdAt: $0.createdAt.toDate()) }
        }
        return MonthlyAnalysisEntity(
            list: shortDiaryList,
            message: message
        )
    }
}
