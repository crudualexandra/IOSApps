import SwiftUI

struct WeatherStatCard: View {
    let icon: String
    let label: String
    let value: String
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(.white.opacity(0.9))

                Spacer()
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(label.uppercased())
                    .font(.system(size: 11, weight: .semibold, design: .default))
                    .tracking(1.1)
                    .foregroundStyle(.white.opacity(0.45))
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text(value)
                        .font(.system(size: 36, weight: .semibold, design: .default))
                        .tracking(-1.1)
                        .foregroundStyle(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)

                    Text(unit)
                        .font(.system(size: 13, weight: .medium, design: .default))
                        .foregroundStyle(.white.opacity(0.58))
                        .lineLimit(1)
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, minHeight: 142, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(.black.opacity(0.24))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.14),
                            .white.opacity(0.04)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .shadow(color: .black.opacity(0.20), radius: 16, x: 0, y: 10)
    }
}

#Preview {
    ZStack {
        Image("sky_background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        WeatherStatCard(
            icon: "humidity.fill",
            label: "Humidity",
            value: "55",
            unit: "%"
        )
        .padding()
    }
}
