import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject private var viewModel: RatingsViewModel
    @Environment(\.dismiss) private var dismiss

    let movie: Movie

    @State private var showRatingSheet = false

    private var rating: UserRating? {
        viewModel.rating(for: movie)
    }

    var body: some View {
        ZStack {
            Color("PaperCream")
                .ignoresSafeArea()

            GrainOverlayView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    posterHero

                    VStack(alignment: .leading, spacing: 24) {
                        titleBlock
                        criticScoreSection
                        synopsisSection
                        userRatingSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, -38)
                    .padding(.bottom, 140)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showRatingSheet) {
            RatingSheetView(movie: movie)
                .environmentObject(viewModel)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
    }

    private var posterHero: some View {
        ZStack(alignment: .top) {
            Image(movie.posterAsset)
                .resizable()
                .scaledToFill()
                .frame(height: 420)
                .frame(maxWidth: .infinity)
                .clipped()

            VStack {
                Spacer()

                LinearGradient(
                    colors: [
                        Color.clear,
                        Color("PaperCream")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 180)
            }

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.white)
                        .frame(width: 42, height: 42)
                        .background(Color.black.opacity(0.35))
                        .clipShape(Capsule())
                }

                Spacer()

                Image(systemName: "bookmark")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(width: 42, height: 42)
                    .background(Color.black.opacity(0.35))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 18)
            .padding(.top, 54)
        }
        .frame(height: 420)
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(movie.title)
                .font(.system(size: 30, weight: .black, design: .serif))
                .foregroundStyle(Color("InkBrown"))
                .fixedSize(horizontal: false, vertical: true)

            Text("\(movie.director.uppercased()) • \(movie.year) • \(movie.runtime) MIN")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("DimInk"))

            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 72), spacing: 8)],
                alignment: .leading,
                spacing: 8
            ) {
                ForEach(movie.genres, id: \.self) { genre in
                    Text(genre)
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color("TagSurface"))
                        .foregroundStyle(Color("InkBrown"))
                        .clipShape(Capsule())
                }
            }
        }
    }

    private var criticScoreSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("CRITIC SCORE")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(Color("DimInk"))

                Spacer()

                Text(String(format: "%.1f / 10", movie.criticScore))
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(Color("InkBrown"))
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color("TagSurface"))

                    Capsule()
                        .fill(Color("RustAccent"))
                        .frame(width: proxy.size.width * CGFloat(movie.criticScore / 10.0))
                }
            }
            .frame(height: 10)
        }
        .padding(16)
        .background(Color("PaperDark"))
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }

    private var synopsisSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SYNOPSIS")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("DimInk"))

            Text(movie.synopsis)
                .font(.system(size: 15, weight: .regular, design: .serif))
                .foregroundStyle(Color("InkBrown"))
                .lineSpacing(6)
        }
    }

    private var userRatingSection: some View {
        
        VStack(alignment: .leading, spacing: 14) {

            Text("YOUR RATING")

                .font(.system(size: 11, weight: .medium, design: .monospaced))

                .foregroundStyle(Color("DimInk"))

            if let rating {
                
                VStack(alignment: .leading, spacing: 16) {

                    HStack(alignment: .lastTextBaseline, spacing: 8) {

                        Text("\(rating.score)")

                            .font(.system(size: 64, weight: .black, design: .serif))

                            .foregroundStyle(Color.reelRust)

                        Text("/ 10")

                            .font(.system(size: 24, weight: .black, design: .serif))

                            .foregroundStyle(Color.reelInk)

                    }

                    LazyVGrid(

                        columns: [GridItem(.adaptive(minimum: 110), spacing: 8)],

                        alignment: .leading,

                        spacing: 8

                    ) {

                        ForEach(rating.tags) { tag in

                            TagBadgeView(tag: tag, isSelected: true)

                        }

                    }

                    Button {

                        showRatingSheet = true

                    } label: {

                        Text("Edit Rating")

                            .font(.system(size: 15, weight: .bold, design: .rounded))

                            .foregroundStyle(Color.reelRust)

                    }

                    .buttonStyle(.plain)

                }

                .padding(22)

                .frame(maxWidth: .infinity, alignment: .leading)

                .background(Color.reelPaperDark)

                .overlay(

                    RoundedRectangle(cornerRadius: 22, style: .continuous)

                        .stroke(Color.reelRust.opacity(0.55), lineWidth: 1.5)

                )

                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))

                .shadow(color: Color.reelInk.opacity(0.12), radius: 10, x: 0, y: 5)

            } else {

                Button {

                    showRatingSheet = true

                } label: {

                    HStack(spacing: 10) {

                        Image(systemName: "film")

                            .font(.system(size: 17, weight: .bold))

                        Text("Rate This Film")

                            .font(.system(size: 16, weight: .bold, design: .rounded))

                    }

                    .foregroundStyle(Color.white)

                    .frame(maxWidth: .infinity)

                    .padding(.vertical, 17)

                    .background(Color("RustAccent"))

                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                    .shadow(color: Color("RustAccent").opacity(0.25), radius: 10, x: 0, y: 5)

                }

                .buttonStyle(.plain)

            }

        }

    }
}

#Preview {
    NavigationStack {
        MovieDetailView(movie: MovieData.all[1])
            .environmentObject(RatingsViewModel())
    }
}
