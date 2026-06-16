import SwiftUI

struct GrainOverlayView: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let seconds = timeline.date.timeIntervalSinceReferenceDate
                let seed = Int(seconds * 2)

                for index in 0..<180 {
                    let x = CGFloat((index * 37 + seed * 11) % Int(max(size.width, 1)))
                    let y = CGFloat((index * 53 + seed * 7) % Int(max(size.height, 1)))
                    let rect = CGRect(x: x, y: y, width: 1.2, height: 1.2)

                    context.fill(
                        Path(ellipseIn: rect),
                        with: .color(Color("GrainOverlay").opacity(0.22))
                    )
                }
            }
        }
        .opacity(0.35)
        .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color("PaperCream")
        GrainOverlayView()
    }
}
