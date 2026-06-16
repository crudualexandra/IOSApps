import SwiftUI

struct CityDetailView: View {
    @EnvironmentObject private var viewModel: WeatherViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var animatedTemperature = 0
    @State private var showHourly = false
    @State private var showStats = false
    @State private var pulseIcon = false

    @ScaledMetric(relativeTo: .largeTitle) private var heroTempSize: CGFloat = 104

    let city: City
    let namespace: Namespace.ID

    var body: some View {
        ZStack {
            Image(city.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            LinearGradient(
                colors: [
                    .black.opacity(0.50),
                    .black.opacity(0.62),
                    .black.opacity(0.78),
                    .black.opacity(0.90)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    heroSection

                    HourlyForecastRow(city: city)
                        .offset(x: showHourly ? 0 : 80)
                        .opacity(showHourly ? 1 : 0)
                        .animation(.spring(response: 0.65, dampingFraction: 0.78), value: showHourly)

                    WeeklyForecastView(city: city)

                    statsGrid
                        .padding(.horizontal, 18)

                    Spacer()
                        .frame(height: 38)
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarBackButtonHidden(true)
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(.black.opacity(0.34), in: Circle())
                    .overlay {
                        Circle()
                            .stroke(.white.opacity(0.08), lineWidth: 1)
                    }
                    .contentShape(Circle())
            }
            .buttonStyle(.plain)
            .padding(.leading, 18)
            .padding(.top, 58)
            .zIndex(999)
        }
        .onAppear {
            animatedTemperature = city.temperature
            showHourly = true

            withAnimation(.easeOut(duration: 0.5).delay(0.12)) {
                showStats = true
            }

            if city.condition.needsPulse {
                withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    pulseIcon = true
                }
            }
        }
    }

    private var heroSection: some View {
        VStack(spacing: 18) {
            Spacer()
                .frame(height: 86)

            VStack(spacing: 8) {
                Text(city.name)
                    .font(.system(size: 42, weight: .semibold, design: .default))
                    .foregroundStyle(.white)
                    .tracking(-1.1)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                Text(city.country.uppercased())
                    .font(.system(size: 13, weight: .semibold, design: .default))
                    .tracking(1.7)
                    .foregroundStyle(.white.opacity(0.66))
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }

            Text("\(animatedTemperature)°")
                .font(.system(size: heroTempSize, weight: .thin, design: .default))
                .foregroundStyle(.white)
                .tracking(-6)
                .contentTransition(.numericText())
                .shadow(color: .black.opacity(0.45), radius: 22, x: 0, y: 12)
                .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animatedTemperature)

            VStack(spacing: 14) {
                Image(systemName: city.condition.icon)
                    .font(.system(size: 48, weight: .medium))
                    .foregroundStyle(
                        LinearGradient(
                            colors: city.condition.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .scaleEffect(city.condition.needsPulse && pulseIcon ? 1.0 : 0.95)
                    .shadow(color: .black.opacity(0.35), radius: 12, x: 0, y: 8)

                Text("\(city.condition.label)  •  Feels like \(city.feelsLike)°")
                    .font(.system(size: 15, weight: .semibold, design: .default))
                    .foregroundStyle(.white.opacity(0.78))
                    .tracking(0.1)
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 18)
        .frame(maxWidth: .infinity)
        .frame(height: 430)
        .background(
            LinearGradient(
                colors: [
                    .black.opacity(0.32),
                    .black.opacity(0.08),
                    .clear
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }

    private var statsGrid: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible(), spacing: 14),
                GridItem(.flexible(), spacing: 14)
            ],
            spacing: 14
        ) {
            WeatherStatCard(
                icon: "humidity.fill",
                label: "Humidity",
                value: "\(city.humidity)",
                unit: "%"
            )
            .staggered(show: showStats, index: 0)

            WeatherStatCard(
                icon: "wind",
                label: "Wind Speed",
                value: "\(city.windSpeed)",
                unit: "km/h"
            )
            .staggered(show: showStats, index: 1)

            WeatherStatCard(
                icon: "sun.max.fill",
                label: "UV Index",
                value: "\(city.uvIndex)",
                unit: "UV"
            )
            .staggered(show: showStats, index: 2)

            WeatherStatCard(
                icon: "thermometer.medium",
                label: "Feels Like",
                value: "\(city.feelsLike)",
                unit: "°C"
            )
            .staggered(show: showStats, index: 3)
        }
    }
}

private extension View {
    func staggered(show: Bool, index: Int) -> some View {
        self
            .opacity(show ? 1 : 0)
            .offset(y: show ? 0 : 24)
            .animation(
                .spring(response: 0.55, dampingFraction: 0.75)
                    .delay(Double(index) * 0.08),
                value: show
            )
    }
}

#Preview {
    CityDetailView(
        city: WeatherData.cities[0],
        namespace: Namespace().wrappedValue
    )
    .environmentObject(WeatherViewModel())
}
