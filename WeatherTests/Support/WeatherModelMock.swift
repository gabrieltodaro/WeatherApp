//
//  WeatherModelMock.swift
//  WeatherTests
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import Foundation
@testable import Weather

struct WeatherModelMock {
    static func scatteredCloudsSantaMonicaMock() -> Weather {
        let main = Main(temperature: 67.35,
                        feelsLike: 67.35,
                        pressure: 1017,
                        humidity: 75,
                        minTemperature: 59.22,
                        maxTemperature: 79.93,
                        seaLevel: nil,
                        groundLevel: nil)
        let weatherInfo = [WeatherInfo(identifier: 802,
                                       main: "",
                                       description: "scattered clouds",
                                       icon: "03d")]
        let weather = Weather(coord: nil,
                              main: main,
                              weatherInfo: weatherInfo,
                              visibility: 10000,
                              wind: Wind(speed: 11.5, direction: 270, gust: nil),
                              clouds: nil,
                              rain: nil,
                              snow: nil,
                              date: nil,
                              timezone: nil,
                              cityIdentifier: nil,
                              cityName: "Santa Monica")
        return weather
    }

    static func clearSkyCampinasMock() -> Weather {
        let main = Main(temperature: 73.67,
                        feelsLike: 72.19,
                        pressure: 1021,
                        humidity: 31,
                        minTemperature: 73.67,
                        maxTemperature: 73.67,
                        seaLevel: nil,
                        groundLevel: nil)
        let weatherInfo = [WeatherInfo(identifier: 800,
                                       main: "Clear",
                                       description: "clear sky",
                                       icon: "01d")]
        let weather = Weather(coord: nil,
                              main: main,
                              weatherInfo: weatherInfo,
                              visibility: 10000,
                              wind: Wind(speed: 9.22, direction: 30, gust: nil),
                              clouds: nil,
                              rain: nil,
                              snow: nil,
                              date: nil,
                              timezone: nil,
                              cityIdentifier: 6322651,
                              cityName: "Campinas")
        return weather
    }
}
