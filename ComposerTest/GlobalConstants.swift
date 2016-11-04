//
//  GlobalConstants.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import Font
import Log
import UIKit

public let Log = Logger()

struct Global {
    struct Sizes {
        static let SpacingUnit: CGFloat = 8.0
        static let CardCornerRadius: CGFloat = 8.0
    }
    
    struct Text {
        static let FontName = "BrixSans"
    }
}

enum MaitsuTextFieldSize: CGFloat {
    case small  = 16.0
    case medium = 20.0
    case large  = 24.0
}

extension UIColor {    
    // Background color
    static var maitsuCream: UIColor {
        return UIColor.colorWithRGB(0xfff7ea)
    }
    
    // Main colors
    static var maitsuOrange: UIColor {
        return UIColor.colorWithRGB(0xf77754)
    }
    
    static var maitsuGreen: UIColor {
        return UIColor.colorWithRGB(0x83c264)
    }
    
    static var maitsuRed: UIColor {
        return UIColor.colorWithRGB(0xef5953)
    }
    
    static var maitsuBlue: UIColor {
        return UIColor.colorWithRGB(0x3cbbcd)
    }
    
    // Greyscale colors
    static var maitsuText: UIColor {
        return UIColor.colorWithRGB(0x555555)
    }
    
    static var maitsuNeutralGrey: UIColor {
        return UIColor.colorWithRGB(0xcac1c1)
    }
    
    static var maitsuLightGrey: UIColor {
        return UIColor.colorWithRGB(0xeae1e1)
    }
    
    static var maitsuGrey: UIColor {
        return UIColor.colorWithRGB(0xf4eeee)
    }
}

extension UILayoutPriority {
    static var low: Float { return 250.0 }
    static var high: Float { return 750.0 }
    static var required: Float { return 1000.0 }
}
