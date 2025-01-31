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
                return 50
            case .two:
                return 100
            case .three:
                return 300
            case .four:
                return 350
            case .five:
                return 550
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
    
    var paddingLeadTrail: CGFloat {
        switch self {
            case .three, .four, .five, .six:
                return 70
            case .one, .two:
                return 150
        }
    }
}
