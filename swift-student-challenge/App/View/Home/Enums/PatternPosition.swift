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
                return -900
            case .two:
                return -850
            case .three:
                return -212.5
            case .four:
                return -162.5
            case .five:
                return 475
            case .six:
                return 525
        }
    }
    
    var paddingLeading: CGFloat {
        switch self {
            case .one:
                return -400
            case .two:
                return 400
            case .three:
                return -615
            case .four:
                return 615
            case .five:
                return -575
            case .six:
                return 575
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
    
    var paddingLeadTrail: CGFloat {
        switch self {
            case .one, .two:
                return 120
            case .three, .four:
                return 50
            case .five, .six:
                return -30
        }
    }
}
