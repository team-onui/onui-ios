import Foundation

struct MissionEntity: Equatable {
    let id: String
    let name: String
    let goal: String
    let message: String
    let missionType: MissionType
    let coast: Int?
    let isFinished: Bool
}
