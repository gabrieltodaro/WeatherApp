//
//  Weather.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 18/05/22.
//

import Foundation

enum WeatherUnit: String {
    case standard
    case metric
    case imperial
}

enum WeatherSpeedUnit: String {
    case mph
    case metric = "m/s"
}

struct Weather: Decodable {
    let coord: Coordinates?
    let main: Main?
    let weatherInfo: [WeatherInfo?]
    let visibility: Double?
    let wind: Wind?
    let clouds: Clouds?
    let rain: Rain?
    let snow: Snow?
    let date, timezone: Date?
    let cityIdentifier: Int?
    let cityName: String?

    private enum CodingKeys: String, CodingKey {
        case coord
        case main
        case weatherInfo = "weather"
        case visibility
        case wind
        case clouds
        case rain
        case snow
        case date = "dt"
        case timezone
        case cityIdentifier = "id"
        case cityName = "name"
    }
}

struct Coordinates: Decodable {
    let latitude, longitude: Double?

    private enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

struct WeatherInfo: Decodable {
    let identifier: Int?
    let main, description, icon: String?

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case main
        case description
        case icon
    }

    func iconURL() -> URL? {
        URL(string: "\(Constants.HTTPConstants.openWeatherIconUrl)\(icon ?? "")@2x.png")
    }
}

struct Wind: Decodable {
    let speed, direction, gust: Double?

    private enum CodingKeys: String, CodingKey {
        case speed
        case direction = "deg"
        case gust
    }

    func presentableWindSpeed(with metric: String) -> String {
        "\(I18nKeys.titleWind.localized()) \(speed ?? 0) \(metric)"
    }

    func presentabelWindDirection() -> String {
        "\(I18nKeys.titleWindDirection.localized()) \(direction ?? 0)º"
    }
}

struct Clouds: Decodable {
    let all: Double?

    private enum CodingKeys: String, CodingKey {
        case all
    }
}

struct Rain: Decodable {
    let oneHour, threeHour: Double?

    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}

struct Snow: Decodable {
    let oneHour, threeHour: Double?

    private enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}
