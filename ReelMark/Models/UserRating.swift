import Foundation

struct UserRating: Codable, Identifiable {
    let id: UUID
    var movieId: UUID
    var score: Int
    var tags: [MoodTag]
    var dateRated: Date
}

enum MoodTag: String, CaseIterable, Codable, Identifiable {
    case mustWatch = "Must Watch"
    case overhyped = "Overhyped"
    case hiddenGem = "Hidden Gem"
    case rewatch = "Rewatch"
    case disappointing = "Disappointing"
    case emotional = "Emotional"
    case mindBending = "Mind-Bending"
    case cozyWatch = "Cozy Watch"
    case intense = "Intense"
    case classic = "Classic"

    var id: String {
        rawValue
    }
}
