//
//  Double.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 21/05/22.
//

import Foundation

extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
