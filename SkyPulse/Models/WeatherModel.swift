//
//  WeatherModel.swift
//  SkyPulse
//
//  Created by adm on 15.06.2026.
//

import SwiftUI

struct City: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let country: String
    let condition: WeatherCondition
    let temperature: Int
    let feelsLike: Int
    let humidity: Int
    let windSpeed: Int
    let uvIndex: Int
    let hourly: [HourlyWeather]
    let weekly: [DailyWeather]
}

enum WeatherCondition: String, CaseIterable, Hashable {
    case sunny
    case cloudy
    case rainy
    case stormy
    case snowy
    case windy
    case partlyCloudy

    var icon: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .cloudy:
            return "cloud.fill"
        case .rainy:
            return "cloud.rain.fill"
        case .stormy:
            return "cloud.bolt.rain.fill"
        case .snowy:
            return "snowflake"
        case .windy:
            return "wind"
        case .partlyCloudy:
            return "cloud.sun.fill"
        }
    }

    var gradientColors: [Color] {
        switch self {
        case .sunny:
            return [Color(hex: "#FF6B00"), Color(hex: "#FFD700")]
        case .rainy:
            return [Color(hex: "#1A1AFF"), Color(hex: "#00C8FF")]
        case .stormy:
            return [Color(hex: "#1C0045"), Color(hex: "#7B00D4")]
        case .snowy:
            return [Color(hex: "#B0E0FF"), Color(hex: "#FFFFFF")]
        case .cloudy:
            return [Color(hex: "#5A5A8A"), Color(hex: "#B0B0D0")]
        case .windy:
            return [Color(hex: "#00A6A6"), Color(hex: "#9EF01A")]
        case .partlyCloudy:
            return [Color(hex: "#F77F00"), Color(hex: "#4A90D9")]
        }
    }

    var label: String {
        switch self {
        case .sunny:
            return "Sunny"
        case .cloudy:
            return "Cloudy"
        case .rainy:
            return "Rainy"
        case .stormy:
            return "Stormy"
        case .snowy:
            return "Snowy"
        case .windy:
            return "Windy"
        case .partlyCloudy:
            return "Partly Cloudy"
        }
    }

    var needsPulse: Bool {
        self == .stormy || self == .rainy
    }
}

struct HourlyWeather: Identifiable, Hashable {
    let id = UUID()
    let hour: String
    let temp: Int
    let condition: WeatherCondition
}

struct DailyWeather: Identifiable, Hashable {
    let id = UUID()
    let day: String
    let high: Int
    let low: Int
    let condition: WeatherCondition
}

extension Color {
    init(hex: String) {
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&value)

        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double

        switch cleanedHex.count {
        case 6:
            red = Double((value >> 16) & 0xFF) / 255
            green = Double((value >> 8) & 0xFF) / 255
            blue = Double(value & 0xFF) / 255
            alpha = 1
        case 8:
            red = Double((value >> 24) & 0xFF) / 255
            green = Double((value >> 16) & 0xFF) / 255
            blue = Double((value >> 8) & 0xFF) / 255
            alpha = Double(value & 0xFF) / 255
        default:
            red = 1
            green = 1
            blue = 1
            alpha = 1
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
extension City {
    var backgroundImageName: String {
        switch name {
        case "Tokyo":
            return "city_tokyo"
        case "London":
            return "city_london"
        case "New York":
            return "city_newyork"
        case "Dubai":
            return "city_dubai"
        case "Reykjavik":
            return "city_reykjavik"
        case "Sydney":
            return "city_sydney"
        default:
            return "sky_background"
        }
    }
}
