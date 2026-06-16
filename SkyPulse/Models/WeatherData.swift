//
//  WeatherData.swift
//  SkyPulse
//
//  Created by adm on 15.06.2026.
//

import Foundation

enum WeatherData {
    static let cities: [City] = [
        City(
            name: "Tokyo",
            country: "Japan",
            condition: .sunny,
            temperature: 31,
            feelsLike: 34,
            humidity: 55,
            windSpeed: 12,
            uvIndex: 8,
            hourly: [
                HourlyWeather(hour: "08:00", temp: 25, condition: .sunny),
                HourlyWeather(hour: "09:00", temp: 27, condition: .sunny),
                HourlyWeather(hour: "10:00", temp: 28, condition: .sunny),
                HourlyWeather(hour: "11:00", temp: 30, condition: .sunny),
                HourlyWeather(hour: "12:00", temp: 31, condition: .sunny),
                HourlyWeather(hour: "13:00", temp: 32, condition: .sunny),
                HourlyWeather(hour: "14:00", temp: 33, condition: .sunny),
                HourlyWeather(hour: "15:00", temp: 32, condition: .partlyCloudy),
                HourlyWeather(hour: "16:00", temp: 31, condition: .partlyCloudy),
                HourlyWeather(hour: "17:00", temp: 29, condition: .sunny),
                HourlyWeather(hour: "18:00", temp: 27, condition: .sunny),
                HourlyWeather(hour: "19:00", temp: 26, condition: .cloudy)
            ],
            weekly: [
                DailyWeather(day: "Mon", high: 32, low: 24, condition: .sunny),
                DailyWeather(day: "Tue", high: 31, low: 23, condition: .partlyCloudy),
                DailyWeather(day: "Wed", high: 29, low: 22, condition: .cloudy),
                DailyWeather(day: "Thu", high: 30, low: 23, condition: .sunny),
                DailyWeather(day: "Fri", high: 33, low: 25, condition: .sunny),
                DailyWeather(day: "Sat", high: 34, low: 26, condition: .sunny),
                DailyWeather(day: "Sun", high: 30, low: 24, condition: .rainy)
            ]
        ),

        City(
            name: "London",
            country: "United Kingdom",
            condition: .cloudy,
            temperature: 14,
            feelsLike: 12,
            humidity: 80,
            windSpeed: 22,
            uvIndex: 2,
            hourly: [
                HourlyWeather(hour: "08:00", temp: 11, condition: .cloudy),
                HourlyWeather(hour: "09:00", temp: 12, condition: .cloudy),
                HourlyWeather(hour: "10:00", temp: 13, condition: .cloudy),
                HourlyWeather(hour: "11:00", temp: 14, condition: .cloudy),
                HourlyWeather(hour: "12:00", temp: 14, condition: .rainy),
                HourlyWeather(hour: "13:00", temp: 15, condition: .cloudy),
                HourlyWeather(hour: "14:00", temp: 15, condition: .cloudy),
                HourlyWeather(hour: "15:00", temp: 14, condition: .rainy),
                HourlyWeather(hour: "16:00", temp: 13, condition: .cloudy),
                HourlyWeather(hour: "17:00", temp: 12, condition: .cloudy),
                HourlyWeather(hour: "18:00", temp: 12, condition: .windy),
                HourlyWeather(hour: "19:00", temp: 11, condition: .cloudy)
            ],
            weekly: [
                DailyWeather(day: "Mon", high: 15, low: 9, condition: .cloudy),
                DailyWeather(day: "Tue", high: 14, low: 8, condition: .rainy),
                DailyWeather(day: "Wed", high: 16, low: 10, condition: .cloudy),
                DailyWeather(day: "Thu", high: 13, low: 7, condition: .windy),
                DailyWeather(day: "Fri", high: 15, low: 9, condition: .partlyCloudy),
                DailyWeather(day: "Sat", high: 17, low: 11, condition: .cloudy),
                DailyWeather(day: "Sun", high: 14, low: 8, condition: .rainy)
            ]
        ),

        City(
            name: "New York",
            country: "United States",
            condition: .partlyCloudy,
            temperature: 22,
            feelsLike: 23,
            humidity: 60,
            windSpeed: 18,
            uvIndex: 5,
            hourly: [
                HourlyWeather(hour: "08:00", temp: 18, condition: .partlyCloudy),
                HourlyWeather(hour: "09:00", temp: 19, condition: .partlyCloudy),
                HourlyWeather(hour: "10:00", temp: 20, condition: .sunny),
                HourlyWeather(hour: "11:00", temp: 21, condition: .sunny),
                HourlyWeather(hour: "12:00", temp: 22, condition: .partlyCloudy),
                HourlyWeather(hour: "13:00", temp: 23, condition: .partlyCloudy),
                HourlyWeather(hour: "14:00", temp: 24, condition: .cloudy),
                HourlyWeather(hour: "15:00", temp: 23, condition: .cloudy),
                HourlyWeather(hour: "16:00", temp: 22, condition: .partlyCloudy),
                HourlyWeather(hour: "17:00", temp: 21, condition: .sunny),
                HourlyWeather(hour: "18:00", temp: 20, condition: .partlyCloudy),
                HourlyWeather(hour: "19:00", temp: 19, condition: .cloudy)
            ],
            weekly: [
                DailyWeather(day: "Mon", high: 24, low: 17, condition: .partlyCloudy),
                DailyWeather(day: "Tue", high: 25, low: 18, condition: .sunny),
                DailyWeather(day: "Wed", high: 21, low: 15, condition: .rainy),
                DailyWeather(day: "Thu", high: 20, low: 14, condition: .cloudy),
                DailyWeather(day: "Fri", high: 23, low: 16, condition: .partlyCloudy),
                DailyWeather(day: "Sat", high: 26, low: 19, condition: .sunny),
                DailyWeather(day: "Sun", high: 22, low: 16, condition: .windy)
            ]
        ),

        City(
            name: "Dubai",
            country: "United Arab Emirates",
            condition: .sunny,
            temperature: 42,
            feelsLike: 46,
            humidity: 30,
            windSpeed: 9,
            uvIndex: 11,
            hourly: [
                HourlyWeather(hour: "08:00", temp: 35, condition: .sunny),
                HourlyWeather(hour: "09:00", temp: 37, condition: .sunny),
                HourlyWeather(hour: "10:00", temp: 39, condition: .sunny),
                HourlyWeather(hour: "11:00", temp: 40, condition: .sunny),
                HourlyWeather(hour: "12:00", temp: 42, condition: .sunny),
                HourlyWeather(hour: "13:00", temp: 43, condition: .sunny),
                HourlyWeather(hour: "14:00", temp: 44, condition: .sunny),
                HourlyWeather(hour: "15:00", temp: 44, condition: .sunny),
                HourlyWeather(hour: "16:00", temp: 43, condition: .sunny),
                HourlyWeather(hour: "17:00", temp: 41, condition: .sunny),
                HourlyWeather(hour: "18:00", temp: 39, condition: .sunny),
                HourlyWeather(hour: "19:00", temp: 37, condition: .sunny)
            ],
            weekly: [
                DailyWeather(day: "Mon", high: 43, low: 31, condition: .sunny),
                DailyWeather(day: "Tue", high: 44, low: 32, condition: .sunny),
                DailyWeather(day: "Wed", high: 42, low: 30, condition: .sunny),
                DailyWeather(day: "Thu", high: 45, low: 33, condition: .sunny),
                DailyWeather(day: "Fri", high: 44, low: 32, condition: .windy),
                DailyWeather(day: "Sat", high: 43, low: 31, condition: .sunny),
                DailyWeather(day: "Sun", high: 42, low: 30, condition: .sunny)
            ]
        ),

        City(
            name: "Reykjavik",
            country: "Iceland",
            condition: .stormy,
            temperature: 6,
            feelsLike: 1,
            humidity: 90,
            windSpeed: 45,
            uvIndex: 1,
            hourly: [
                HourlyWeather(hour: "08:00", temp: 5, condition: .stormy),
                HourlyWeather(hour: "09:00", temp: 5, condition: .rainy),
                HourlyWeather(hour: "10:00", temp: 6, condition: .stormy),
                HourlyWeather(hour: "11:00", temp: 6, condition: .stormy),
                HourlyWeather(hour: "12:00", temp: 7, condition: .rainy),
                HourlyWeather(hour: "13:00", temp: 7, condition: .windy),
                HourlyWeather(hour: "14:00", temp: 6, condition: .stormy),
                HourlyWeather(hour: "15:00", temp: 6, condition: .rainy),
                HourlyWeather(hour: "16:00", temp: 5, condition: .windy),
                HourlyWeather(hour: "17:00", temp: 5, condition: .stormy),
                HourlyWeather(hour: "18:00", temp: 4, condition: .rainy),
                HourlyWeather(hour: "19:00", temp: 4, condition: .windy)
            ],
            weekly: [
                DailyWeather(day: "Mon", high: 7, low: 3, condition: .stormy),
                DailyWeather(day: "Tue", high: 6, low: 2, condition: .rainy),
                DailyWeather(day: "Wed", high: 5, low: 1, condition: .snowy),
                DailyWeather(day: "Thu", high: 7, low: 3, condition: .windy),
                DailyWeather(day: "Fri", high: 6, low: 2, condition: .stormy),
                DailyWeather(day: "Sat", high: 8, low: 4, condition: .cloudy),
                DailyWeather(day: "Sun", high: 7, low: 3, condition: .rainy)
            ]
        ),

        City(
            name: "Sydney",
            country: "Australia",
            condition: .rainy,
            temperature: 18,
            feelsLike: 17,
            humidity: 75,
            windSpeed: 28,
            uvIndex: 4,
            hourly: [
                HourlyWeather(hour: "08:00", temp: 16, condition: .rainy),
                HourlyWeather(hour: "09:00", temp: 17, condition: .rainy),
                HourlyWeather(hour: "10:00", temp: 18, condition: .cloudy),
                HourlyWeather(hour: "11:00", temp: 18, condition: .rainy),
                HourlyWeather(hour: "12:00", temp: 19, condition: .rainy),
                HourlyWeather(hour: "13:00", temp: 19, condition: .cloudy),
                HourlyWeather(hour: "14:00", temp: 18, condition: .rainy),
                HourlyWeather(hour: "15:00", temp: 18, condition: .rainy),
                HourlyWeather(hour: "16:00", temp: 17, condition: .windy),
                HourlyWeather(hour: "17:00", temp: 17, condition: .cloudy),
                HourlyWeather(hour: "18:00", temp: 16, condition: .rainy),
                HourlyWeather(hour: "19:00", temp: 16, condition: .rainy)
            ],
            weekly: [
                DailyWeather(day: "Mon", high: 19, low: 15, condition: .rainy),
                DailyWeather(day: "Tue", high: 20, low: 16, condition: .cloudy),
                DailyWeather(day: "Wed", high: 21, low: 17, condition: .partlyCloudy),
                DailyWeather(day: "Thu", high: 18, low: 14, condition: .rainy),
                DailyWeather(day: "Fri", high: 19, low: 15, condition: .windy),
                DailyWeather(day: "Sat", high: 22, low: 17, condition: .sunny),
                DailyWeather(day: "Sun", high: 20, low: 16, condition: .cloudy)
            ]
        )
    ]
}
