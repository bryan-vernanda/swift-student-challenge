//
//  SoundFX.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 29/01/25.
//

import Foundation

enum SoundFX {
    case click
    case flipCard
    case levelUp
    
    var name: String  {
        switch self {
            case .click: return "pop-button"
            case .flipCard: return "flip-card"
            case .levelUp: return "level-up"
        }
    }
    
//    var volume: Float {
//        switch self {
//            case .click: return 0.1
//            case .correct: return 0.5
//            case .wrong: return 0.5
//        }
//    }
}
