//
//  WeatherViewModelTests.swift
//  WeatherTests
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import XCTest
@testable import Weather

class WeatherViewModelTests: XCTestCase {

    var sut: WeatherViewModel?

    override func setUp() {
        super.setUp()
        sut = WeatherViewModel(networkManager: NetworkManager(),
                               delegate: nil)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        XCTAssertNil(sut)
    }

    func testGetLanguageCode() {
        let code = sut?.getLanguageCode()
        XCTAssertNotNil(code)
    }

    func testGetUnits() {
        var unit = sut?.getUnits(from: "en")
        XCTAssertEqual(unit, WeatherUnit.imperial.rawValue)

        unit = sut?.getUnits(from: "pt")
        XCTAssertEqual(unit, WeatherUnit.metric.rawValue)
    }

    func testGetSpeedUnit() {
        var speedUnit = sut?.getSpeedUnit(fom: "en")
        XCTAssertEqual(speedUnit, WeatherSpeedUnit.mph.rawValue)

        speedUnit = sut?.getSpeedUnit(fom: "pt")
        XCTAssertEqual(speedUnit, WeatherSpeedUnit.metric.rawValue)
    }
}
