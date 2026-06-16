import SwiftUI

struct HourlyForecastRow: View {
    @EnvironmentObject private var viewModel: WeatherViewModel

    let city: City

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionTitle

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(city.hourly) { hour in
                        hourlyCard(hour)
                    }
                }
                .padding(.horizontal, 18)
            }
        }
    }

    private var sectionTitle: some View {
        Text("Hourly Forecast")
            .font(.system(size: 24, weight: .semibold, design: .default))
            .tracking(-0.4)
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
    }

    private func hourlyCard(_ hour: HourlyWeather) -> some View {
        VStack(spacing: 12) {
            Text(hour.hour)
                .font(.system(size: 14, weight: .semibold, design: .default))
                .tracking(0.2)
                .foregroundStyle(.white.opacity(0.72))

            Image(systemName: hour.condition.icon)
                .font(.system(size: 25, weight: .medium))
                .foregroundStyle(.white)

            Text(viewModel.temperatureString(hour.temp))
                .font(.system(size: 27, weight: .semibold, design: .default))
                .tracking(-0.6)
                .foregroundStyle(.white)
        }
        .frame(width: 78, height: 118)
        .background(
            ZStack {
                viewModel.conditionGradient(hour.condition)
                    .opacity(0.82)

                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.white.opacity(0.05))
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(.white.opacity(0.12), lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Image("sky_background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        HourlyForecastRow(city: WeatherData.cities[0])
            .environmentObject(WeatherViewModel())
    }
}
