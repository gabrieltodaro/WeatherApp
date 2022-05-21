//
//  WeatherModelTests.swift
//  WeatherTests
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import XCTest
@testable import Weather

class WeatherModelTests: XCTestCase {

    var sut: Weather?

    override func setUp() {
        super.setUp()
        sut = WeatherModelMock.clearSkyCampinasMock()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        XCTAssertNil(sut)
    }

    func testWindSpeedText() {
        guard let wind = sut?.wind else {
            XCTFail("Wind object should not be nil.")
            return
        }

        let speedText = wind.presentableWindSpeed(with: WeatherSpeedUnit.mph.rawValue)
        XCTAssertTrue(speedText.contains(WeatherSpeedUnit.mph.rawValue))
    }
}
