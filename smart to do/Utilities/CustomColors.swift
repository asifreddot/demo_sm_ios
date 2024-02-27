//
//  Colors.swift
//  smart to do
//
//  Created by Asif Reddot on 22/2/24.
//

import Foundation
import UIKit

public class CustomColors: NSObject {
    public lazy var color009B3E: UIColor = hexStringToUIColor(hex: "#009B3E")
    public lazy var color061053: UIColor = hexStringToUIColor(hex: "#061053")
    public lazy var colorCACFF4: UIColor = hexStringToUIColor(hex: "#CACFF4")
    public lazy var color2D3D5A: UIColor = hexStringToUIColor(hex: "#2D3D5A")
    public lazy var colorFFFFFF: UIColor = hexStringToUIColor(hex: "#FFFFFF")
    public lazy var colorAB8D00: UIColor = hexStringToUIColor(hex: "#AB8D00")
    public lazy var colorFFD300: UIColor = hexStringToUIColor(hex: "#FFD300")
    public lazy var color009A3E: UIColor = hexStringToUIColor(hex: "#009A3E")
    
    public func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
