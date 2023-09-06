//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 21/05/22.
//

import CoreLocation
import Foundation

protocol WeatherCoordinatorDelegate: AnyObject {
    func hideLoading()
    func presentErrorAlert(error: String)
    func presentWeatherInfo(weather: Weather)
    func showDeniedAlert()
}

class WeatherViewModel: NSObject {
    weak var delegate: WeatherCoordinatorDelegate?

    private var locationManager = CLLocationManager()
    private let enLanguageCode = "en"
    private let networkManager: NetworkManager

    /// Latitude and Longitude to get the Weather
    private var lat: Double = 0.0
    private var long: Double = 0.0

    init(delegate: WeatherCoordinatorDelegate?,
         locationManager: CLLocationManager = CLLocationManager(),
         networkManager: NetworkManager) {
        self.delegate = delegate
        self.locationManager = locationManager
        self.networkManager = networkManager

        super.init()

        self.locationManager.delegate = self
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

    func getStatus() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                break
            case .denied:
                delegate?.showDeniedAlert()
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                locationManager.requestLocation()
            @unknown default:
                break
        }
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            lat = loc.coordinate.latitude
            long = loc.coordinate.longitude
            getWeather(at: lat, and: long)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            case .denied, .restricted:
                delegate?.showDeniedAlert()
            default:
                break
        }
    }
}
