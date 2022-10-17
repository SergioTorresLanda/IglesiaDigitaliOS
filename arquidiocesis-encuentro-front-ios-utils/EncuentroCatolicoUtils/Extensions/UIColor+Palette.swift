//
//  UIColor+Palette.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 16/10/22.
//

import UIKit

//TODO: - Fill all colors
/// UIColor extension with app colors
/// Grab color from this or add more. Not use custom colors
public extension UIColor {
    //MARK: - Static
    ///App Primary Color
    static var primary: UIColor {
        UIColor(named: "ePrimary", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Primary Light Color
    static var primaryLight: UIColor {
        UIColor(named: "primaryLight", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Primary Dark Color
    static var primaryDark: UIColor {
        UIColor(named: "primaryDark", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Secondary Color
    static var secondary: UIColor {
        UIColor(named: "secondary", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Secondary Light Color
    static var secondaryLight: UIColor {
        UIColor(named: "secondaryLight", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Secondary Dark Color
    static var secondaryDark: UIColor {
        UIColor(named: "secondaryDark", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Success Color
    static var success: UIColor {
        UIColor(named: "success", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Warning Color
    static var warning: UIColor {
        UIColor(named: "warning", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Danger Color
    static var danger: UIColor {
        .red
    }
    
    ///App Info Color
    static var info: UIColor {
        UIColor(named: "info", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Accent Success Color
    static var successDark: UIColor {
        UIColor(named: "successDark", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Accent Warning Color
    static var warningDark: UIColor {
        UIColor(named: "warningDark", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Accent Danger Color
    static var dangerDark: UIColor {
        UIColor(named: "dangerDark", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Accent Info Color
    static var infoDark: UIColor {
        UIColor(named: "infoDark", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Text Light color
    static var text: UIColor {
        UIColor(named: "text", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Text Light color
    static var textOnPrimary: UIColor {
        UIColor(named: "textOnPrimary", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    ///App Text Dark color
    static var textOnSecondary: UIColor {
        UIColor(named: "textOnSecondary", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    /// App Background color
    static var background: UIColor {
        UIColor(named: "eBackground", in: .local, compatibleWith: nil) ?? UIColor()
    }
    
    /// App disabled color
    static var disabled: UIColor {
        .gray
    }
    
    //MARK: - Methods
    static func getColorFromHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let hex: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        let scanner  = Scanner(string: hex)
        var color: UInt64 = 0
        
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
