import Foundation

struct FetchMissionListResponseDTO: Decodable {
    let missions: [MissionResponseDTO]?
}

struct MissionResponseDTO: Decodable {
    let id: String
    let name: String
    let goal: String
    let message: String
    let missionType: MissionType
    let coast: Int?
    let isFinished: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case goal
        case message
        case missionType = "mission_type"
        case coast
        case isFinished = "is_finished"
    }
}

extension FetchMissionListResponseDTO {
    func toDomain() -> [MissionEntity] {
        guard let missions else { return [] }
        return missions.map { $0.toDomain() }
    }
}

extension MissionResponseDTO {
    func toDomain() -> MissionEntity {
        MissionEntity(
            id: id,
            name: name,
            goal: goal,
            message: message,
            missionType: missionType,
            coast: coast,
            isFinished: isFinished
        )
    }
}
