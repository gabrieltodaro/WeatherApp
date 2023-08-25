//
//  UIView.swift
//  Weather
//
//  Created by Gabriel Patane Todaro on 21/05/22.
//

import UIKit

extension UIView {
    /// Set translatesAutoresizingMaskIntoConstraints into false automatically while adding the subviews
    @discardableResult
    func addSubviews(_ views: [UIView]) -> Self {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        return self
    }
}

extension UIView {
    func anchor(
        left: NSLayoutXAxisAnchor? = nil,
        paddingLeft: CGFloat? = nil,
        top: NSLayoutYAxisAnchor? = nil,
        paddingTop: CGFloat? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingRight: CGFloat? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        paddingBottom: CGFloat? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil) {

            let topInset = CGFloat(0)
            let bottomInset = CGFloat(0)

            translatesAutoresizingMaskIntoConstraints = false

            if let left {
                leftAnchor.constraint(equalTo: left, constant: (paddingLeft ?? 0)).isActive = true
            }

            if let top {
                topAnchor.constraint(equalTo: top, constant: (paddingTop ?? 0) + topInset).isActive = true
            }

            if let right {
                rightAnchor.constraint(equalTo: right, constant: -(paddingRight ?? 0)).isActive = true
            }

            if let bottom {
                let padding = -(paddingBottom ?? 0) - bottomInset
                bottomAnchor.constraint(equalTo: bottom, constant: padding).isActive = true
            }

            if let height, height != 0 {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }

            if let width, width != 0 {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }

            self.center(x: centerX, y: centerY)
        }

    // swiftlint:disable identifier_name
    func center(x: NSLayoutXAxisAnchor? = nil,
                y: NSLayoutYAxisAnchor? = nil) {
        if let x {
            self.centerXAnchor.constraint(equalTo: x).isActive = true
        }

        if let y {
            self.centerYAnchor.constraint(equalTo: y).isActive = true
        }
    }
    // swiftlint:enable identifier_name
}
