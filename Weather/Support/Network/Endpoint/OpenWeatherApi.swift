//
//  OpenWeatherEndpoint.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

enum NetworkEnvironment {
    case production
}

enum OpenWeatherApi {
    case currentWeather(lat: Double, lon: Double, lang: String, units: String)
}

extension OpenWeatherApi: EndpointType {
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("baseURL could not be configured.")
        }

        return url
    }

    var path: String {
        switch self {
        case .currentWeather(let lat, let lon, let lang, let units):
            // swiftlint:disable:next line_length
            return "weather?lat=\(lat)&lon=\(lon)&appid=\(NetworkManager.OpenWeatherApiKey)&lang=\(lang)&units=\(units)"
        }
    }

    var httpMethod: HTTPMethod {
        .get
    }

    var task: HTTPTask {
        .request
    }

    var httpHeaders: HTTPHeaders? {
        nil
    }

}
