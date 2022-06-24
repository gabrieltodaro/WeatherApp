//
//  ViewController.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 17/05/22.
//

import CoreLocation
import Kingfisher
import UIKit

class WeatherViewController: UIViewController {

    private var viewModel: WeatherViewModel?
    private var weatherView: WeatherView?
    private var locationManager = CLLocationManager()

    /// Latitude and Longitude to get the Weather
    /// Change these values to get the weather from a new place.
    ///
    /// It will be changed in the future to get dynamic places
    /// Or a place from a map

    private var lat: Double = 0.0
    private var long: Double = 0.0

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        weatherView = WeatherView(frame: view.frame)

        guard let weatherView = weatherView else {
            return
        }

        weatherView.frame = view.frame
        weatherView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view = weatherView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self

        viewModel = WeatherViewModel(networkManager: NetworkManager(), delegate: self)
        weatherView?.viewModel = viewModel
//        setupLoading()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            showDeniedAlert()
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            getWeather()
        @unknown default:
            break
        }
    }

    private func getWeather() {
        locationManager.requestLocation()
    }

    // MARK: - Setup Views

    /// Show loading view
    /// It is a UIView that uses all device frame
    /// put a blur on it and an activy indicator on the middle
    private func setupLoading() {
        view.showBlurLoader()
    }

    private func showDeniedAlert() {
        let alert = UIAlertController(title: "Location denied",
                                      message: "You denied the location request. Please go to Settings app and change it.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default))
        present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController: WeatherCoordinatorDelegate {
    func presentErrorAlert(error: String) {
        let alert = UIAlertController(title: L18nKeys.titleError.localized(),
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L18nKeys.buttonOk.localized(),
                                      style: .default,
                                      handler: nil))

        present(alert, animated: true, completion: nil)
    }

    func presentWeatherInfo(weather: Weather) {
        weatherView?.presentWeatherInfo(weather: weather)
    }

    func hideLoading() {
        view.removeBluerLoader()
        weatherView?.setupColors()
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.first {
            lat = loc.coordinate.latitude
            long = loc.coordinate.longitude
            viewModel?.getWeather(at: lat, and: long)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
