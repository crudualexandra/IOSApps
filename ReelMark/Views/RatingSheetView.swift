import SwiftUI

struct RatingSheetView: View {
    @EnvironmentObject private var viewModel: RatingsViewModel
    @Environment(\.dismiss) private var dismiss

    let movie: Movie

    @State private var score: Double = 7
    @State private var selectedTags: Set<MoodTag> = []
    @State private var pulseScore = false

    private let tagColumns = [
        GridItem(.adaptive(minimum: 112), spacing: 10)
    ]

    var body: some View {
        ZStack {
            Color("PaperDark")
                .ignoresSafeArea()

            GrainOverlayView()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    header
                    scoreSection
                    tagSection
                    saveButton
                }
                .padding(22)
                .padding(.top, 10)
            }
        }
        .onAppear {
            if let existing = viewModel.rating(for: movie) {
                score = Double(existing.score)
                selectedTags = Set(existing.tags)
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Your Take")
                .font(.system(size: 30, weight: .black, design: .serif))
                .foregroundStyle(Color("InkBrown"))

            Text(movie.title.uppercased())
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("DimInk"))
        }
    }

    private var scoreSection: some View {
        VStack(spacing: 18) {
            Text("\(Int(score))")
                .font(.system(size: 72, weight: .black, design: .serif))
                .foregroundStyle(Color("RustAccent"))
                .contentTransition(.numericText())
                .scaleEffect(pulseScore ? 1.15 : 1.0)
                .animation(.spring(response: 0.25, dampingFraction: 0.45), value: pulseScore)
                .animation(.spring(response: 0.25, dampingFraction: 0.75), value: score)

            Slider(value: $score, in: 1...10, step: 1) {
                Text("Score")
            }
            .tint(Color("RustAccent"))
            .onChange(of: score) {
                pulseScore = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                    pulseScore = false
                }
            }

            HStack {
                Text("1")
                Spacer()
                Text("10")
            }
            .font(.system(size: 11, weight: .medium, design: .monospaced))
            .foregroundStyle(Color("DimInk"))
        }
        .padding(18)
        .background(Color("PaperCream"))
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
    }

    private var tagSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("HOW WAS IT?")
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("DimInk"))

            LazyVGrid(columns: tagColumns, alignment: .leading, spacing: 10) {
                ForEach(MoodTag.allCases) { tag in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            toggle(tag)
                        }
                    } label: {
                        TagBadgeView(tag: tag, isSelected: selectedTags.contains(tag))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var saveButton: some View {
        Button {
            viewModel.rate(
                movie: movie,
                score: Int(score),
                tags: Array(selectedTags)
            )
            dismiss()
        } label: {
            Text("Save Rating")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(selectedTags.isEmpty ? Color.gray.opacity(0.5) : Color("RustAccent"))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .disabled(selectedTags.isEmpty)
        .buttonStyle(.plain)
    }

    private func toggle(_ tag: MoodTag) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
}

#Preview {
    RatingSheetView(movie: MovieData.all[0])
        .environmentObject(RatingsViewModel())
}
