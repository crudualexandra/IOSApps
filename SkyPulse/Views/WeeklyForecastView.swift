import SwiftUI

struct WeeklyForecastView: View {
    @EnvironmentObject private var viewModel: WeatherViewModel

    let city: City

    private var minLow: Int {
        city.weekly.map(\.low).min() ?? 0
    }

    private var maxHigh: Int {
        city.weekly.map(\.high).max() ?? 1
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("7-Day Forecast")
                .font(.system(size: 24, weight: .semibold, design: .default))
                .tracking(-0.4)
                .foregroundStyle(.white)

            VStack(spacing: 8) {
                ForEach(city.weekly) { day in
                    forecastRow(day)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.black.opacity(0.24))
            )
            .overlay {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(.white.opacity(0.10), lineWidth: 1)
            }
        }
        .padding(.horizontal, 18)
    }

    private func forecastRow(_ day: DailyWeather) -> some View {
        HStack(spacing: 12) {
            Text(day.day)
                .font(.system(size: 17, weight: .semibold, design: .default))
                .tracking(-0.2)
                .foregroundStyle(.white)
                .frame(width: 42, alignment: .leading)

            Image(systemName: day.condition.icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(.white.opacity(0.92))
                .frame(width: 30)

            Text("\(day.low)°")
                .font(.system(size: 14, weight: .medium, design: .default))
                .foregroundStyle(.white.opacity(0.48))
                .frame(width: 36, alignment: .trailing)

            temperatureRangeBar(day)

            Text("\(day.high)°")
                .font(.system(size: 20, weight: .semibold, design: .default))
                .tracking(-0.4)
                .foregroundStyle(.white)
                .frame(width: 38, alignment: .trailing)
        }
        .padding(.vertical, 8)
    }

    private func temperatureRangeBar(_ day: DailyWeather) -> some View {
        GeometryReader { geometry in
            let totalRange = max(maxHigh - minLow, 1)
            let startRatio = CGFloat(day.low - minLow) / CGFloat(totalRange)
            let endRatio = CGFloat(day.high - minLow) / CGFloat(totalRange)
            let width = geometry.size.width
            let start = width * startRatio
            let end = max(width * endRatio, start + 18)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.white.opacity(0.12))

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: day.condition.gradientColors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: end - start)
                    .offset(x: start)
            }
        }
        .frame(height: 9)
    }
}

#Preview {
    ZStack {
        Image("sky_background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        WeeklyForecastView(city: WeatherData.cities[0])
            .environmentObject(WeatherViewModel())
    }
}
