//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Gabriel Patane Todaro on 17/05/22.
//

import XCTest
@testable import Weather

class WeatherViewSnapshotTests: BaseSnapShotTest {
    var sut: WeatherView?
    var viewController: UIViewController?

    override func setUp() {
        super.setUp()
        sut = WeatherView()

        guard let sut = sut else {
            return
        }

        sut.viewModel = WeatherViewModel(networkManager: NetworkManager(), delegate: nil)

        viewController = UIViewController()
        viewController?.view = sut
        sut.setupColors()

        recordMode = false
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        viewController = nil

        XCTAssertNil(sut)
        XCTAssertNil(viewController)
    }

    func testWeatherViewInSantaMonica() {
        sut?.presentWeatherInfo(weather: WeatherModelMock.scatteredCloudsSantaMonicaMock())
        setupAndTakeSnapshots(viewController: viewController!,
                              pixelTolerance: 0.0,
                              overallTolerance: 0.0)
    }

    func testWeatherViewInCampinas() {
        sut?.presentWeatherInfo(weather: WeatherModelMock.clearSkyCampinasMock())
        setupAndTakeSnapshots(viewController: viewController!,
                              pixelTolerance: 0.0,
                              overallTolerance: 0.0)
    }
}
