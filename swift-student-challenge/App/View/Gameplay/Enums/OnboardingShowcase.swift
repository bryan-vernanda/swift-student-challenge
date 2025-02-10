//
//  OnboardingShowcase.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 27/01/25.
//

import Foundation

enum OnboardingShowcase: CaseIterable {
    case settings
    case refresh
    case level
    case patternCard
    case patternInput
    
    var index: Int {
        return OnboardingShowcase.allCases.firstIndex(of: self) ?? 0
    }
    
    var title: String {
        switch self {
            case .settings:
                return "Settings"
            case .refresh:
                return "Refresh"
            case .level:
                return "Level"
            case .patternCard:
                return "Pattern Card"
            case .patternInput:
                return "Pattern Input"
        }
    }
    
    var detail: String {
        switch self {
            case .settings:
                return "Settings will allow you to paused, restart, or exit the game."
            case .refresh:
                return "Refresh the pattern if you've forgotten or to restart this level."
            case .level:
                return "Your current game level."
            case .patternCard:
                return "Memorize your pattern card to unlock the next level."
            case .patternInput:
                return "Draw the correct pattern based on the pattern card you've seen."
        }
    }
}
