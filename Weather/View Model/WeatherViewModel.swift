//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 21/05/22.
//

import Foundation

protocol WeatherCoordinatorDelegate: AnyObject {
    func hideLoading()
    func presentErrorAlert(error: String)
    func presentWeatherInfo(weather: Weather)
}

struct WeatherViewModel {
    private let enLanguageCode = "en"
    let networkManager: NetworkManager
    let delegate: WeatherCoordinatorDelegate?

    // MARK: - Request to the Open Weather API
    func getWeather(at lat: Double, and lon: Double) {
        networkManager.getWeather(at: lat,
                                  and: lon,
                                  with: getLanguageCode(),
                                  units: getUnits(from: getLanguageCode())) { weather, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.delegate?.hideLoading()
                    self.delegate?.presentErrorAlert(error: error)
                    return
                }
            } else if let weather = weather {
                DispatchQueue.main.async {
                    self.delegate?.presentWeatherInfo(weather: weather)
                    self.delegate?.hideLoading()
                    return
                }
            }
        }
    }

    // MARK: - View Model helper methods
    lazy var languageCode: String = {
        Locale.current.languageCode ?? enLanguageCode
    }()

    func getLanguageCode() -> String {
        Locale.current.languageCode ?? enLanguageCode
    }

    func getUnits(from languageCode: String) -> String {
        languageCode == enLanguageCode
        ? WeatherUnit.imperial.rawValue
        : WeatherUnit.metric.rawValue
    }

    func getSpeedUnit(fom languageCode: String) -> String {
        languageCode == enLanguageCode
        ? WeatherSpeedUnit.mph.rawValue
        : WeatherSpeedUnit.metric.rawValue
    }
}
