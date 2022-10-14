//
//  UIFont+Utils.swift
//  Nomad
//
//  Created by Diego Luna on 08/07/20.
//

import UIKit

enum FontName: String {
    case light = "Montserrat Light"
    case regular = "Montserrat Regular"
    case bold = "Montserrat Bold"
}

enum FontStyle {
    case light
    case regular
    case bold
    
    func name() -> String {
        switch self {
        case .light:
            return "Montserrat Light"
        case .regular:
            return "Montserrat Regular"
        case .bold:
            return "Montserrat Bold"
        }
    }
}

enum SicloFont {
    case base(type: FontBase)
    case custom(value: CGFloat)
    
    var value: CGFloat {
        switch self {
        case .base(let type):
            return type.rawValue
            
        case .custom(let customSize):
            return customSize
        }
    }
}

enum FontBase: CGFloat {
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    case fourteen = 14
    case sixteen = 16
    case seventeen = 17
    case eighteen = 18
    case twenty = 20
    case twentyFour = 24
    case twentySix = 26
    case twentyEight = 28
    case thirty = 30
    case thirtyFour = 34
}

public struct FontCore {

    public var tenRegular: UIFont {
        return FontCore.font(.ten, style: .regular)
    }
    
    public var elevenRegular: UIFont {
        return FontCore.font(.eleven, style: .regular)
    }
    
    public var twelveLight: UIFont {
        return FontCore.font(.twelve, style: .light)
    }
    
    public var twelveBold: UIFont {
        return FontCore.font(.twelve, style: .bold)
    }
    
    public var twelveRegular: UIFont {
        return FontCore.font(.twelve, style: .regular)
    }
    
    public var fourteenRegular: UIFont {
        return FontCore.font(.fourteen, style: .regular)
    }
    
    public var fourteenBold: UIFont {
        return FontCore.font(.fourteen, style: .bold)
    }
    
    public var sixteenRegular: UIFont {
        return FontCore.font(.sixteen, style: .regular)
    }
    
    public var sixteenBold: UIFont {
        return FontCore.font(.sixteen, style: .bold)
    }
    
    public var eighteenRegular: UIFont {
        return FontCore.font(.eighteen, style: .regular)
    }
    
    public var eighteenBold: UIFont {
        return FontCore.font(.eighteen, style: .bold)
    }
    
    public var twentySixRegular: UIFont {
        return FontCore.font(.twentySix, style: .regular)
    }
    
    public var twentySixBold: UIFont {
        return FontCore.font(.twentySix, style: .bold)
    }

    public var thirtyRegular: UIFont {
        return FontCore.font(.thirty, style: .regular)
    }
        
    public var twentyBold: UIFont {
        return FontCore.font(.twenty, style: .bold)
    }

    public var twentyFourRegular: UIFont {
        return FontCore.font(.twentyFour, style: .regular)
    }

    public var thirtyFourBold: UIFont {
        return FontCore.font(.thirtyFour, style: .bold)
    }
}

extension FontCore {
    static func font(_ font: FontBase, style: FontName) -> UIFont {
        UIFont.register(font: style.rawValue, withExtension: "otf")
        
        let siclofont = UIFont(name: style.rawValue, size: font.rawValue)
        return siclofont ?? UIFont.defaultFont(size: font.rawValue)
    }
}

extension UIFont {
    convenience init?(_ type: FontStyle, size: CGFloat) {
        self.init(name: type.name(), size: size)
    }
    
    static func defaultFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func register(font named: String, withExtension extensionType: String) {
        let bundle = Bundle.main
        var error: Unmanaged<CFError>? 
        defer { error?.release() }
        guard let url = bundle.url(forResource: named, withExtension: extensionType),
            let provider = CGDataProvider(url: url as CFURL) else { return }
        
        if let font = CGFont(provider) {
            _ = CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
