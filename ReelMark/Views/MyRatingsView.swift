import SwiftUI

struct MyRatingsView: View {
    @EnvironmentObject private var viewModel: RatingsViewModel

    private var ratedMovies: [Movie] {
        viewModel.ratedMovies(from: MovieData.all)
    }

    var body: some View {
        ZStack {
            Color("PaperCream")
                .ignoresSafeArea()

            GrainOverlayView()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 18) {
                header

                if ratedMovies.isEmpty {
                    emptyState
                } else {
                    ratingsList
                }
            }
            .padding(.top, 20)
        }
        .navigationBarHidden(true)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Journal")
                .font(.system(size: 38, weight: .black, design: .serif))
                .foregroundStyle(Color("InkBrown"))

            Text("films you've marked")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("DimInk"))
        }
        .padding(.horizontal, 16)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()

            Image(systemName: "film.stack")
                .font(.system(size: 64, weight: .regular))
                .foregroundStyle(Color("AmberWarm"))

            Text("No films rated yet.\nStart exploring.")
                .font(.system(size: 20, weight: .bold, design: .serif))
                .italic()
                .foregroundStyle(Color("InkBrown"))
                .multilineTextAlignment(.center)

            Spacer()
        }
        .frame(maxWidth: .infinity)
    }

    private var ratingsList: some View {
        List {
            ForEach(ratedMovies) { movie in
                NavigationLink {
                    MovieDetailView(movie: movie)
                } label: {
                    RatingRowView(
                        movie: movie,
                        rating: viewModel.rating(for: movie)
                    )
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.removeRating(for: movie)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

private struct RatingRowView: View {
    let movie: Movie
    let rating: UserRating?

    private var visibleTags: [MoodTag] {
        Array((rating?.tags ?? []).prefix(2))
    }

    private var extraTagCount: Int {
        max((rating?.tags.count ?? 0) - 2, 0)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(movie.posterAsset)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.system(size: 16, weight: .bold, design: .serif))
                    .foregroundStyle(Color("InkBrown"))
                    .lineLimit(2)

                Text("\(movie.year) • \(movie.director)")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(Color("DimInk"))
                    .lineLimit(1)

                HStack(spacing: 6) {
                    ForEach(visibleTags) { tag in
                        TagBadgeView(tag: tag, isSelected: false)
                    }

                    if extraTagCount > 0 {
                        Text("+\(extraTagCount) more")
                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                            .foregroundStyle(Color("DimInk"))
                    }
                }

                if let rating {
                    Text(rating.dateRated, format: .dateTime.day().month().year())
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundStyle(Color("DimInk"))
                }
            }

            Spacer()

            if let rating {
                Text("\(rating.score)")

                    .font(.system(size: 20, weight: .black, design: .serif))

                    .foregroundStyle(Color.white)

                    .frame(width: 44, height: 44)

                    .background(Color.reelRust)

                    .clipShape(Circle())

                    .shadow(color: Color.reelRust.opacity(0.25), radius: 6, x: 0, y: 3)
            }
        }
        .padding(12)
        .background(Color("PaperDark"))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: Color("InkBrown").opacity(0.08), radius: 6, x: 0, y: 3)
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        MyRatingsView()
            .environmentObject(RatingsViewModel())
    }
}
