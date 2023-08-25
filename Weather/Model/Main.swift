//
//  Main.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import Foundation

struct Main: Codable {
    let temperature, feelsLike, pressure, humidity,
        minTemperature, maxTemperature, seaLevel, groundLevel: Double?

    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case seaLevel = "sea_level"
        case groundLevel = "grnd_level"
    }

    var presentableMinTemperature: String {
        "\(I18nKeys.titleTempMin.localized()): \(String(format: "%.0f", minTemperature ?? 0))º"
    }

    var presentableMaxTemperature: String {
        "\(I18nKeys.titleTempMax.localized()): \(String(format: "%.0f", maxTemperature ?? 0))º"
    }

    var presentableFeelsLike: String {
        "\(I18nKeys.titleFeelsLike.localized())º: \(String(format: "%.0f", feelsLike ?? 0))"
    }

    var presentableHumidity: String {
        "\(I18nKeys.titleHumidity.localized()): \(String(format: "%.0f", humidity ?? 0))%"
    }
}
