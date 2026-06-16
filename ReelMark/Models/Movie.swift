import Foundation

struct Movie: Identifiable, Hashable {
    let id: UUID
    let title: String
    let year: Int
    let director: String
    let runtime: Int
    let genres: [String]
    let synopsis: String
    let posterAsset: String
    let criticScore: Double
}
