//
//  Font+Chalkboard.swift
//  hanvest
//
//  Created by Bryan Vernanda on 25/01/24.
//

import SwiftUI

enum ChalkboardFontWeight {
//    case black
    case bold
//    case heavy
//    case light
//    case medium
//    case regular
//    case semibold
//    case thin
//    case ultraLight
    
    var value: String {
        switch self {
            case .bold:
                "ChalkboardSE-Bold"
        }
    }
}

enum ChalkboardFontSize {
    case XXLTitle
    case XLTitle
    case largeTitle
    case title1
    case title2
    case title3
    case body
    case callout
    case subhead
    case footnote
    case caption1
    case caption2
    
    var size: CGFloat {
        switch self {
            case .XXLTitle:
                52
            case .XLTitle:
                48
            case .largeTitle:
                40
            case .title1:
                36
            case .title2:
                32
            case .title3:
                24
            case .body:
                20
            case .callout:
                16
            case .subhead:
                15
            case .footnote:
                13
            case .caption1:
                12
            case .caption2:
                11
        }
    }
}

extension Font {
    static func chalkboard(_ fontSize: ChalkboardFontSize, _ fontWeight: ChalkboardFontWeight = .bold) -> Font {
        return Font.custom(fontWeight.value, size: fontSize.size)
    }
    
    static func chalkboard(fontSize: CGFloat, _ fontWeight: ChalkboardFontWeight = .bold) -> Font {
        return Font.custom(fontWeight.value, size: fontSize)
    }
}

