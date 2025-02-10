//
//  CreditPatternPosition.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 10/02/25.
//

import Foundation

enum CreditPatternIpadPosition: CaseIterable, PatternPositionProtocol {
    case one
    case two
    case three
    case four
    case five
    
    var paddingBottom: CGFloat {
        switch self {
            case .one:
                return -900
            case .two:
                return -800
            case .three:
                return -400
            case .four:
                return -250
            case .five:
                return -300
        }
    }
    
    var paddingLeading: CGFloat {
        switch self {
            case .one:
                return -350
            case .two:
                return 450
            case .three:
                return 25
            case .four:
                return 550
            case .five:
                return -550
        }
    }
    
    var rotationEffect: CGFloat {
        switch self {
            case .one, .four, .five:
                return 11.15
            case .two, .three:
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

enum CreditPatternIphonePosition: CaseIterable, PatternPositionProtocol {
    case one
    case two
    case three
    
    var paddingBottom: CGFloat {
        switch self {
            case .one:
                return -620
            case .two:
                return -450
            case .three:
                return -280
        }
    }
    
    var paddingLeading: CGFloat {
        switch self {
            case .one:
                return 152.5
            case .two:
                return -202.5
            case .three:
                return 202.5
        }
    }
    
    var rotationEffect: CGFloat {
        switch self {
            case .one, .three:
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
