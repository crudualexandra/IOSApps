import Foundation
import Combine

@MainActor
final class RatingsViewModel: ObservableObject {
    @Published var ratings: [UUID: UserRating] = [:]

    private let storageKey = "reelmark_user_ratings_v1"

    init() {
        load()
    }

    func rate(movie: Movie, score: Int, tags: [MoodTag]) {
        let clampedScore = min(max(score, 1), 10)

        let rating = UserRating(
            id: ratings[movie.id]?.id ?? UUID(),
            movieId: movie.id,
            score: clampedScore,
            tags: tags,
            dateRated: Date()
        )

        ratings[movie.id] = rating
        save()
    }

    func removeRating(for movie: Movie) {
        ratings.removeValue(forKey: movie.id)
        save()
    }

    func rating(for movie: Movie) -> UserRating? {
        ratings[movie.id]
    }

    func hasRated(_ movie: Movie) -> Bool {
        ratings[movie.id] != nil
    }

    func ratedMovies(from list: [Movie]) -> [Movie] {
        list
            .filter { ratings[$0.id] != nil }
            .sorted {
                let firstDate = ratings[$0.id]?.dateRated ?? .distantPast
                let secondDate = ratings[$1.id]?.dateRated ?? .distantPast
                return firstDate > secondDate
            }
    }

    private func save() {
        do {
            let encoded = try JSONEncoder().encode(Array(ratings.values))
            UserDefaults.standard.set(encoded, forKey: storageKey)
        } catch {
            print("Failed to save ratings: \(error.localizedDescription)")
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            ratings = [:]
            return
        }

        do {
            let decoded = try JSONDecoder().decode([UserRating].self, from: data)
            ratings = Dictionary(uniqueKeysWithValues: decoded.map { ($0.movieId, $0) })
        } catch {
            ratings = [:]
            print("Failed to load ratings: \(error.localizedDescription)")
        }
    }
}

