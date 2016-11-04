//
//  Font+Extensions.swift
//  ComposerTest
//
//  Created by Justin Edmund on 11/4/16.
//  Copyright © 2016 Justin Edmund. All rights reserved.
//

import Font

extension Font {
    fileprivate static func standardFontWeight(_ weight: FontWeight) -> String {
        switch weight {
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .bold:
            return "Bold"
        case .black:
            return "Black"
        default:
            return ""
        }
    }
    
    fileprivate static func name(_ weight: FontWeight, style: FontStyle) -> String {
        let base = Global.Text.FontName
        let weightNumber = standardFontWeight(weight)
        
        let weightAndStyle: String
        
        switch style {
        default:
            weightAndStyle = weightNumber
        }
        
        return "\(base)\(weightAndStyle)"
    }
    
    static func StandardFont(_ size: CGFloat = 16, weight: FontWeight = .regular, style: FontStyle = .none) -> Font {
        let fontName = name(weight, style: style)
        return Font(fontName: fontName, size: size)
    }
}

