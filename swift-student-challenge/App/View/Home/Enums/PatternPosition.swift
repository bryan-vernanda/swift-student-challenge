//
//  PatternPosition.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 31/01/25.
//

import Foundation

enum PatternPosition: CaseIterable {
    case one
    case two
    case three
    case four
    case five
    case six
    
    var paddingBottom: CGFloat {
        switch self {
            case .one:
                return -725
            case .two:
                return -675
            case .three:
                return -125
            case .four:
                return -75
            case .five:
                return 475
            case .six:
                return 525
        }
    }
    
    var paddingLeading: CGFloat {
        switch self {
            case .one:
                return -450
            case .two:
                return 450
            case .three:
                return -615
            case .four:
                return 615
            case .five:
                return -600
            case .six:
                return 600
        }
    }
    
    var rotationEffect: CGFloat {
        switch self {
            case .one, .four, .five:
                return 11.45
            case .two, .three, .six:
                return -11.45
        }
    }
}
