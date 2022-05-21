//
//  NSLayoutConstraint.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 21/05/22.
//

import UIKit

// MARK: - Constraints
public extension NSLayoutConstraint {
    func off() {
        isActive = false
    }
    func on() {
        isActive = true
    }
    func toggle() {
        isActive = !isActive
    }
}
