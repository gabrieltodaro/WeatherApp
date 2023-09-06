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

        setupLoading()

        viewModel = WeatherViewModel(delegate: self, networkManager: NetworkManager())
        weatherView?.viewModel = viewModel
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.getStatus()
    }

    // MARK: - Setup Views

    /// Show loading view
    /// It is a UIView that uses all device frame
    /// put a blur on it and an activy indicator on the middle
    private func setupLoading() {
        view.showBlurLoader()
    }

    func deniedAlert() -> UIAlertController {
        let alert = UIAlertController(title: I18nKeys.locationDeniedAlertTitle.localized(),
                                      message: I18nKeys.locationDeniedAlertDescription.localized(),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: I18nKeys.buttonOk.localized(),
                                      style: .default))

        return alert
    }
}

extension WeatherViewController: WeatherCoordinatorDelegate {
    func presentErrorAlert(error: String) {
        let alert = UIAlertController(title: I18nKeys.titleError.localized(),
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: I18nKeys.buttonOk.localized(),
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

    func showDeniedAlert() {
        present(deniedAlert(), animated: true, completion: nil)
    }
}
