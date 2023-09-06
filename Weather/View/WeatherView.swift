//
//  WeatherView.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import UIKit

class WeatherView: UIView {
    var viewModel: WeatherViewModel?

    // MARK: - View Codes
    private lazy var weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const60,
                                       weight: .bold)
        return label
    }()

    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const32,
                                       weight: .medium)
        return label
    }()

    private lazy var mood: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const24,
                                       weight: .light)
        return label
    }()

    private lazy var cityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cityName, mood])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var minTemperature: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const16,
                                       weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var maxTemperature: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const16,
                                       weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var temperaturesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minTemperature, maxTemperature])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var feelsLike: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const16,
                                       weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var humidity: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const16,
                                       weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var tempTriviaStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [feelsLike, humidity])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var completeTemperatureStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [temperaturesStackView, tempTriviaStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var windSpeed: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const16,
                                       weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var windDirection: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: Constants.CGFloatConstants.const16,
                                       weight: .light)
        label.textAlignment = .center
        return label
    }()

    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [windSpeed, windDirection])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layoutMargins = UIEdgeInsets(top: Constants.CGFloatConstants.const0,
                                               left: Constants.CGFloatConstants.const8,
                                               bottom: Constants.CGFloatConstants.const0,
                                               right: Constants.CGFloatConstants.const8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: Lifecycle init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubviews([
            weatherImage,
            temperature,
            cityStackView,
            completeTemperatureStackView,
            windStackView
        ])

        setupConstraints()
    }

    private func setupConstraints() {
        weatherImage.anchor(
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingLeft: Constants.CGFloatConstants.const16,
            top: self.safeAreaLayoutGuide.topAnchor,
            paddingTop: Constants.CGFloatConstants.const16,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingRight: Constants.CGFloatConstants.const16,
            height: Constants.CGFloatConstants.const120
        )

        temperature.anchor(
            top: weatherImage.bottomAnchor,
            paddingTop: Constants.CGFloatConstants.const32,
            centerX: self.centerXAnchor
        )

        cityStackView.anchor(
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingLeft: Constants.CGFloatConstants.const16,
            top: temperature.bottomAnchor,
            paddingTop: Constants.CGFloatConstants.const32,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingRight: Constants.CGFloatConstants.const16
        )

        completeTemperatureStackView.anchor(
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingLeft: Constants.CGFloatConstants.const16,
            top: cityStackView.bottomAnchor,
            paddingTop: Constants.CGFloatConstants.const8,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingRight: Constants.CGFloatConstants.const16,
            height: Constants.CGFloatConstants.const64
        )

        windStackView.anchor(
            left: self.safeAreaLayoutGuide.leftAnchor,
            paddingLeft: Constants.CGFloatConstants.const16,
            top: completeTemperatureStackView.bottomAnchor,
            paddingTop: Constants.CGFloatConstants.const8,
            right: self.safeAreaLayoutGuide.rightAnchor,
            paddingRight: Constants.CGFloatConstants.const16,
            height: Constants.CGFloatConstants.const64
        )
    }

    func setupColors() {
        backgroundColor = .nobel

        cityStackView.backgroundColor = .whiteSmoke.withAlphaComponent(Constants.CGFloatConstants.const0_85)
        cityStackView.clipsToBounds = true
        cityStackView.layer.cornerRadius = Constants.CGFloatConstants.const12

        // swiftlint:disable:next line_length
        completeTemperatureStackView.backgroundColor = .whiteSmoke.withAlphaComponent(Constants.CGFloatConstants.const0_85)
        completeTemperatureStackView.clipsToBounds = true
        completeTemperatureStackView.layer.cornerRadius = Constants.CGFloatConstants.const12

        windStackView.backgroundColor = .whiteSmoke.withAlphaComponent(Constants.CGFloatConstants.const0_85)
        windStackView.clipsToBounds = true
        windStackView.layer.cornerRadius = Constants.CGFloatConstants.const12

    }

    func presentWeatherInfo(weather: Weather) {
        guard let viewModel = viewModel else {
            return
        }

        guard let name = weather.cityName,
            let main = weather.main else {
                return
            }

        cityName.text = name
        temperature.text = "\(String(format: "%.0f", main.temperature ?? 0))º"
        minTemperature.text = main.presentableMinTemperature
        maxTemperature.text = main.presentableMaxTemperature
        feelsLike.text = main.presentableFeelsLike
        humidity.text = main.presentableHumidity

        if let weatherInfo = weather.weatherInfo.first {
            mood.text = weatherInfo?.description?.capitalized ?? ""
            weatherImage.kf.setImage(with: weatherInfo?.iconURL(),
                                     placeholder: nil)
        } else {
            mood.isHidden = true
            weatherImage.isHidden = true
        }

        if let wind = weather.wind {
            let languageCode = viewModel.getLanguageCode()
            windSpeed.text =  wind.presentableWindSpeed(with: viewModel.getSpeedUnit(fom: languageCode))
            windDirection.text = wind.presentabelWindDirection()
        } else {
            windSpeed.isHidden = true
        }
    }
}
