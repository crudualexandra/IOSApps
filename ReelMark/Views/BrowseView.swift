import SwiftUI

struct BrowseView: View {
    @EnvironmentObject private var viewModel: RatingsViewModel

    @State private var selectedGenre = "All"
    @State private var didAppear = false

    private let genres = ["All", "Drama", "Sci-Fi", "Thriller", "Romance", "Crime", "Comedy"]

    private var filteredMovies: [Movie] {
        if selectedGenre == "All" {
            return MovieData.all
        }

        return MovieData.all.filter { movie in
            movie.genres.contains(selectedGenre)
        }
    }

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        ZStack {
            Color("PaperCream")
                .ignoresSafeArea()

            GrainOverlayView()
                .ignoresSafeArea()
                .allowsHitTesting(false)

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    header
                        .zIndex(20)

                    genreStrip
                        .zIndex(30)

                    posterGrid
                        .zIndex(1)
                }
                .padding(.top, 20)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            didAppear = true
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("ReelMark")
                .font(.system(size: 38, weight: .black, design: .serif))
                .foregroundStyle(Color("InkBrown"))

            Text("your personal film journal")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("DimInk"))
        }
        .padding(.horizontal, 16)
    }

    private var genreStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(genres, id: \.self) { genre in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedGenre = genre
                        }
                    } label: {
                        Text(genre)
                            .font(.system(size: 12, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .background(
                                Capsule()
                                    .fill(
                                        selectedGenre == genre
                                        ? Color("RustAccent")
                                        : Color("TagSurface")
                                    )
                            )
                            .foregroundStyle(
                                selectedGenre == genre
                                ? Color.white
                                : Color("InkBrown")
                            )
                            .contentShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
        }
        .frame(height: 56)
        .background(Color("PaperCream").opacity(0.98))
        .contentShape(Rectangle())
    }

    private var posterGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(Array(filteredMovies.enumerated()), id: \.element.id) { index, movie in
                NavigationLink {
                    MovieDetailView(movie: movie)
                } label: {
                    PosterCardView(
                        movie: movie,
                        rating: viewModel.rating(for: movie)
                    )
                }
                .buttonStyle(.plain)
                .opacity(didAppear ? 1 : 0)
                .scaleEffect(didAppear ? 1 : 0.94)
                .animation(
                    .easeOut(duration: 0.35).delay(Double(index) * 0.05),
                    value: didAppear
                )
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 4)
        .padding(.bottom, 24)
    }
}

#Preview {
    BrowseView()
        .environmentObject(RatingsViewModel())
}
