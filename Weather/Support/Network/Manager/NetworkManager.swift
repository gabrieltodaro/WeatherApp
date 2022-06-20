//
//  NetworkManager.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 19/05/22.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated."
    case badRequest = "Bad request."
    case outdated = "The URL you requestes is outdated."
    case failed = "Network request failed."
    case noData = "Response return with no data."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

typealias WeatherCompletionHandler = (_ weather: Weather?, _ error: String?) -> Void

struct NetworkManager {
    static let OpenWeatherApiKey = "d4277b87ee5c71a468ec0c3dc311a724"
    static let environment: NetworkEnvironment = .production
    private let router = Router<OpenWeatherApi>()

    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }

    func getWeather(at lat: Double,
                    and lon: Double,
                    with lang: String,
                    units: String,
                    completion: @escaping WeatherCompletionHandler) {
        // swiftlint:disable:next line_length
        router.request(.currentWeather(lat: lat, lon: lon, lang: lang, units: units)) { data, response, error in

            if error != nil {
                completion(nil, "Please check your network connection.")
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Weather.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
}
