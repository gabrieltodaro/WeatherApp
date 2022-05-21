//
//  L18nKeys.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 22/05/22.
//

import Foundation

enum L18nKeys: String {
    case titleError = "title_error"
    case buttonOk = "button_ok"
    case buttonCancel = "button_cancel"

    case titleTempMin = "title_temp_min"
    case titleTempMax = "title_temp_max"
    case titleFeelsLike = "title_feels_like"
    case titleHumidity = "title_humidity"
    case titleWind = "title_wind"
    case titleWindDirection = "title_wind_direction"

    func localized() -> String {
        rawValue.localized
    }
}
