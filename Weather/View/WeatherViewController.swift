//
//  ViewController.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 17/05/22.
//

import Kingfisher
import UIKit

class WeatherViewController: UIViewController {

    private var viewModel: WeatherViewModel?
    private var weatherView: WeatherView?

    /// Latitude and Longitude to get the Weather
    /// Change these values to get the weather from a new place.
    ///
    /// It will be changed in the future to get dynamic places
    /// Or a place from a map
    private let latitude = 34.0194704
    private let longitude = -118.491227

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

        viewModel = WeatherViewModel(networkManager: NetworkManager(), delegate: self)
        weatherView?.viewModel = viewModel
        setupLoading()
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel?.getWeather(at: latitude, and: longitude)
    }

    // MARK: - Setup Views

    /// Show loading view
    /// It is a UIView that uses all device frame
    /// put a blur on it and an activy indicator on the middle
    private func setupLoading() {
        view.showBlurLoader()
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
