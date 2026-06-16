import Foundation

enum MovieData {
    static let all: [Movie] = [
        Movie(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            title: "The Godfather",
            year: 1972,
            director: "Francis Ford Coppola",
            runtime: 175,
            genres: ["Crime", "Drama"],
            synopsis: "The aging patriarch of an organized crime dynasty transfers control to his reluctant son.",
            posterAsset: "poster_godfather",
            criticScore: 9.2
        ),
        Movie(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            title: "Interstellar",
            year: 2014,
            director: "Christopher Nolan",
            runtime: 169,
            genres: ["Sci-Fi", "Drama"],
            synopsis: "A team of explorers travel through a wormhole in space in an attempt to ensure humanity's survival.",
            posterAsset: "poster_interstellar",
            criticScore: 8.6
        ),
        Movie(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            title: "Parasite",
            year: 2019,
            director: "Bong Joon-ho",
            runtime: 132,
            genres: ["Thriller", "Drama"],
            synopsis: "Greed and class discrimination threaten the newly formed symbiotic relationship between two families.",
            posterAsset: "poster_parasite",
            criticScore: 9.0
        ),
        Movie(
            id: UUID(uuidString: "44444444-4444-4444-4444-444444444444")!,
            title: "La La Land",
            year: 2016,
            director: "Damien Chazelle",
            runtime: 128,
            genres: ["Romance", "Musical"],
            synopsis: "A jazz musician and an aspiring actress fall in love while pursuing their Hollywood dreams.",
            posterAsset: "poster_lalaland",
            criticScore: 8.1
        ),
        Movie(
            id: UUID(uuidString: "55555555-5555-5555-5555-555555555555")!,
            title: "The Dark Knight",
            year: 2008,
            director: "Christopher Nolan",
            runtime: 152,
            genres: ["Action", "Crime"],
            synopsis: "Batman faces the Joker, a criminal mastermind who plunges Gotham into anarchy.",
            posterAsset: "poster_darkknight",
            criticScore: 9.0
        ),
        Movie(
            id: UUID(uuidString: "66666666-6666-6666-6666-666666666666")!,
            title: "Amélie",
            year: 2001,
            director: "Jean-Pierre Jeunet",
            runtime: 122,
            genres: ["Romance", "Comedy"],
            synopsis: "A shy Parisian woman decides to change the lives of those around her for the better.",
            posterAsset: "poster_amelie",
            criticScore: 8.3
        ),
        Movie(
            id: UUID(uuidString: "77777777-7777-7777-7777-777777777777")!,
            title: "Dune: Part One",
            year: 2021,
            director: "Denis Villeneuve",
            runtime: 155,
            genres: ["Sci-Fi", "Adventure"],
            synopsis: "A noble family becomes embroiled in a war for a desert planet's exclusive resources.",
            posterAsset: "poster_dune",
            criticScore: 8.0
        ),
        Movie(
            id: UUID(uuidString: "88888888-8888-8888-8888-888888888888")!,
            title: "Whiplash",
            year: 2014,
            director: "Damien Chazelle",
            runtime: 107,
            genres: ["Drama", "Music"],
            synopsis: "A young drummer enrolls at a cutthroat music conservatory where his teacher will stop at nothing.",
            posterAsset: "poster_whiplash",
            criticScore: 8.5
        ),
        Movie(
            id: UUID(uuidString: "99999999-9999-9999-9999-999999999999")!,
            title: "Everything Everywhere All at Once",
            year: 2022,
            director: "Daniel Kwan, Daniel Scheinert",
            runtime: 139,
            genres: ["Sci-Fi", "Comedy", "Drama"],
            synopsis: "A middle-aged Chinese immigrant is swept up in an insane adventure across the multiverse.",
            posterAsset: "poster_eeaao",
            criticScore: 8.8
        ),
        Movie(
            id: UUID(uuidString: "AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA")!,
            title: "Portrait of a Lady on Fire",
            year: 2019,
            director: "Céline Sciamma",
            runtime: 122,
            genres: ["Romance", "Drama"],
            synopsis: "On an isolated island in Brittany at the end of the eighteenth century, a female painter falls in love with the woman she is commissioned to paint.",
            posterAsset: "poster_portrait",
            criticScore: 8.7
        )
    ]
}
