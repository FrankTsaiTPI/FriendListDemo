//
//  UIColor+Extension.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/8.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255)
    }
}

extension UIColor {
    class var white_two: UIColor {
        UIColor(hexString: "#fcfcfc")
    }
    
    class var greyishBrown: UIColor {
        UIColor(hexString: "#474747")
    }
    
    class var lightGrey: UIColor {
        UIColor(hexString: "#999999")
    }
    
    class var veryLightPink: UIColor {
        UIColor(hexString: "#efefef")
    }
    
    class var hotPink: UIColor {
        UIColor(hexString: "#ec008c")
    }
    
    class var frogGreen: UIColor {
        UIColor(hexString: "#56b30b")
    }
    
    class var booger: UIColor {
        UIColor(hexString: "#a6cc42")
    }
    
    class var appleGreen40: UIColor {
        UIColor(hexString: "#79C41B")
    }
    
    class var pinkishGrey: UIColor {
        UIColor(hexString: "#c9c9c9")
    }
    
    class var whiteThree: UIColor {
        UIColor(hexString: "#e4e4e4")
    }
    
    class var steel: UIColor {
        UIColor(hexString: "#8e8e93")
    }
}
