import Foundation

enum MissionType: String, Decodable {
    case essential = "ESSENTIAL"
    case random = "RANDOM"
    case assign = "ASSIGN"
}
