import SwiftUI

struct PosterCardView: View {
    let movie: Movie
    let rating: UserRating?

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 0) {
                Image(movie.posterAsset)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .clipped()

                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.system(size: 13, weight: .bold, design: .serif))
                        .foregroundStyle(Color("InkBrown"))
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(String(movie.year))
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundStyle(Color("DimInk"))
                }
                .padding(10)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color("PaperDark"))
            }
            .frame(height: 220)
            .background(Color("PaperDark"))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color("InkBrown").opacity(0.18), radius: 8, x: 0, y: 4)

            if let rating {
                Text("\(rating.score)/10")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color("RustAccent").opacity(0.95))
                    .clipShape(Capsule())
                    .padding(10)
            }
        }
    }
}

#Preview {
    PosterCardView(
        movie: MovieData.all[0],
        rating: UserRating(
            id: UUID(),
            movieId: MovieData.all[0].id,
            score: 9,
            tags: [.classic, .mustWatch],
            dateRated: Date()
        )
    )
    .padding()
    .background(Color("PaperCream"))
}
