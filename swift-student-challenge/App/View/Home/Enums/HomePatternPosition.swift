//
//  PatternPosition.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 31/01/25.
//

import Foundation

enum HomePatternIpadPosition: CaseIterable, PatternPositionProtocol {
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
                return 11.15
            case .two, .three, .six:
                return -11.15
        }
    }
    
    var circleFrame: CGFloat {
        switch self {
            default:
                return 13.2
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
            default:
                return 6
        }
    }
    
    var height: CGFloat {
        switch self {
            default:
                return 60
        }
    }
    
    var frameWidth: CGFloat {
        switch self {
            default:
                return 240
        }
    }
    
    var overlayAdjust: CGFloat {
        switch self {
            default:
                return 150
        }
    }
}

enum HomePatternIphonePosition: CaseIterable, PatternPositionProtocol {
    case one
    case two
    
    var paddingBottom: CGFloat {
        switch self {
            case .one:
                return -500
            case .two:
                return -400
        }
    }
    
    var paddingLeading: CGFloat {
        switch self {
            case .one:
                return 182.5
            case .two:
                return -182.5
        }
    }
    
    var rotationEffect: CGFloat {
        switch self {
            case .one:
                return -11.15
            case .two:
                return 11.15
        }
    }
    
    var circleFrame: CGFloat {
        switch self {
            default:
                return 8.8
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
            default:
                return 4
        }
    }
    
    var height: CGFloat {
        switch self {
            default:
                return 40
        }
    }
    
    var frameWidth: CGFloat {
        switch self {
            default:
                return 160
        }
    }
    
    var overlayAdjust: CGFloat {
        switch self {
            default:
                return 100
        }
    }
}
