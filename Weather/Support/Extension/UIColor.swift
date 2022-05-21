//
//  UIColor.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 21/05/22.
//

import UIKit

extension UIColor {
    public static func colorFromHexString(hex: String, alpha: CGFloat = 1) -> UIColor {
        let hexString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let red = CGFloat(Int(color >> 16) & mask) / 255.0
        let green = CGFloat(Int(color >> 8) & mask) / 255.0
        let blue = CGFloat(Int(color) & mask) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    open class var nobel: UIColor {
        UIColor.colorFromHexString(hex: "#999999")
    }

    open class var whiteSmoke: UIColor {
        UIColor.colorFromHexString(hex: "#F9F9F9")
    }
}
