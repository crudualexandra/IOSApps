//
//  WeatherViewModel.swift
//  SkyPulse
//
//  Created by adm on 15.06.2026.
//

import SwiftUI
import Combine
import Foundation

final class WeatherViewModel: ObservableObject {
    @Published var cities: [City]
    @Published var selectedCity: City?

    init(cities: [City] = WeatherData.cities) {
        self.cities = cities
    }

    func selectCity(_ city: City) {
        selectedCity = city
    }

    func temperatureString(_ temp: Int) -> String {
        "\(temp)°"
    }

    func conditionGradient(_ condition: WeatherCondition) -> LinearGradient {
        LinearGradient(
            colors: condition.gradientColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

