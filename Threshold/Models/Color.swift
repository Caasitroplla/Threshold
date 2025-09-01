//
//  Color.swift
//  Threshold
//
//  Created by Issac Allport on 26/08/2025.
//

import SwiftUI

extension Color {
    private struct Components {
            let red: Double
            let green: Double
            let blue: Double
            let alpha: Double
        }
    
    var accessibleFontColor: Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: nil)
        return isLightColor(red: red, green: green, blue: blue) ? .black : .white
    }
    
    private func isLightColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> Bool {
            let lightRed = red > 0.65
            let lightGreen = green > 0.65
            let lightBlue = blue > 0.65

            let lightness = [lightRed, lightGreen, lightBlue].reduce(0) { $1 ? $0 + 1 : $0 }
            return lightness >= 2
        }
}
                    
