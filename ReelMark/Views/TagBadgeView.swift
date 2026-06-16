import SwiftUI

struct TagBadgeView: View {
    let tag: MoodTag
    var isSelected: Bool = false

    var body: some View {
        Text(tag.rawValue)
            .font(.system(size: 11, weight: .bold, design: .rounded))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(isSelected ? Color.reelRust : Color.reelTagSurface)
            .foregroundStyle(isSelected ? Color.white : Color.reelInk)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.reelInk.opacity(0.18) : Color.reelDimInk.opacity(0.18), lineWidth: 1)
            )
    }
}

#Preview {
    VStack(spacing: 12) {
        TagBadgeView(tag: .intense)
        TagBadgeView(tag: .intense, isSelected: true)
    }
    .padding()
    .background(Color.reelPaperCream)
}
