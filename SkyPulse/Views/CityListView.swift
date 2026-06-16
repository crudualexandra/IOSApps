import SwiftUI

struct CityListView: View {
    @EnvironmentObject private var viewModel: WeatherViewModel
    @Environment(\.colorScheme) private var colorScheme

    let namespace: Namespace.ID

    var body: some View {
        ZStack {
            Image("sky_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    header

                    ForEach(viewModel.cities) { city in
                        NavigationLink(value: city) {
                            CityCardView(city: city, namespace: namespace)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                viewModel.selectCity(city)
                            }
                        )
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 64)
                .padding(.bottom, 28)
            }
        }
        .navigationBarHidden(true)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("SkyPulse")
                .font(.system(size: 40, weight: .semibold, design: .default))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            .white,
                            Color(hex: "#C8E7FF")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .tracking(-1.2)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            HStack(spacing: 8) {
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(hex: "#00C8FF"),
                                Color(hex: "#7B00D4")
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 48, height: 4)

                Text(" Weather ")
                    .font(.system(size: 13, weight: .medium, design: .default))
                    .foregroundStyle(.white.opacity(0.55))
                    .tracking(0.2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.vertical, 22)
        .background(
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(.black.opacity(0.28))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.16),
                            .white.opacity(0.04)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .padding(.bottom, 8)
    }
}

private struct CityCardView: View {
    @EnvironmentObject private var viewModel: WeatherViewModel
    @ScaledMetric(relativeTo: .largeTitle) private var temperatureSize: CGFloat = 68

    let city: City
    let namespace: Namespace.ID

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.black.opacity(0.34))

            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.12),
                            .white.opacity(0.03)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(spacing: 0) {
                topContent

                Spacer()

                centerTemperature

                Spacer()

                bottomMetrics
            }
            .padding(20)
        }
        .frame(height: 178)
        .overlay(alignment: .top) {
            accentLine
        }
        .overlay {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .stroke(
                    LinearGradient(
                        colors: [
                            .white.opacity(0.18),
                            .white.opacity(0.05)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: .black.opacity(0.32), radius: 18, x: 0, y: 12)
    }

    private var topContent: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 7) {
                Text(city.name)
                    .font(.system(size: 28, weight: .semibold, design: .default))
                    .tracking(-0.7)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Text(city.country.uppercased())
                    .font(.system(size: 12, weight: .semibold, design: .default))
                    .tracking(1.4)
                    .foregroundStyle(.white.opacity(0.50))
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 8) {
                Image(systemName: city.condition.icon)
                    .font(.system(size: 27, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            colors: city.condition.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                Text(city.condition.label)
                    .font(.system(size: 13, weight: .medium, design: .default))
                    .foregroundStyle(.white.opacity(0.66))
                    .multilineTextAlignment(.trailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }
        }
    }

    private var centerTemperature: some View {
        Text(viewModel.temperatureString(city.temperature))
            .font(.system(size: temperatureSize, weight: .thin, design: .default))
            .tracking(-3.5)
            .foregroundStyle(.white)
            .lineLimit(1)
            .minimumScaleFactor(0.65)
            .shadow(
                color: city.condition.gradientColors.first?.opacity(0.28) ?? .clear,
                radius: 18,
                x: 0,
                y: 8
            )
    }

    private var bottomMetrics: some View {
        HStack(spacing: 10) {
            bottomMetric(icon: "humidity.fill", text: "\(city.humidity)%")
            separator
            bottomMetric(icon: "wind", text: "\(city.windSpeed) km/h")
            separator
            bottomMetric(icon: "thermometer.medium", text: "Feels \(city.feelsLike)°")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.white.opacity(0.08), in: Capsule())
        .overlay {
            Capsule()
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
    }

    private var accentLine: some View {
        LinearGradient(
            colors: city.condition.gradientColors,
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(height: 3)
        .opacity(0.9)
        .clipShape(Capsule())
        .padding(.horizontal, 34)
    }

    private func bottomMetric(icon: String, text: String) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .medium))

            Text(text)
                .font(.system(size: 13, weight: .medium, design: .default))
                .tracking(-0.1)
        }
        .foregroundStyle(.white.opacity(0.74))
        .lineLimit(1)
        .minimumScaleFactor(0.72)
    }

    private var separator: some View {
        Circle()
            .fill(.white.opacity(0.30))
            .frame(width: 4, height: 4)
    }
}

#Preview {
    CityListView(namespace: Namespace().wrappedValue)
        .environmentObject(WeatherViewModel())
}
