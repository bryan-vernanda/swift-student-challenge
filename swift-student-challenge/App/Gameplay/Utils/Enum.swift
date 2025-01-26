//
//  Enum.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import Foundation

// PatternSymbol: Represent the numbers in the pattern code (1-9)
enum PatternSymbol: Int {
    case one = 1, two, three, four, five, six, seven, eight, nine
}

enum LevelingPattern: CaseIterable {
    case zero
    case one
    case eleven
    case thirtyOne
    case fiftyOne
    
    var value: Int {
        switch self {
            case .zero:
                return 0
            case .one:
                return 1
            case .eleven:
                return 11
            case .thirtyOne:
                return 31
            case .fiftyOne:
                return 51
        }
    }
    
    var numberOfPattern: Int {
        switch self {
            case .zero, .one:
                return 1
            case .eleven:
                return 2
            case .thirtyOne:
                return 3
            case .fiftyOne:
                return 4
        }
    }
    
    var time: CGFloat {
        switch self {
            case .zero, .one:
                return 4.0
            case .eleven:
                return 5.0
            case .thirtyOne:
                return 5.5
            case .fiftyOne:
                return 6.0
        }
    }
}

enum HighlightStage: CaseIterable {
    case onboarding
    case isDone
    
    var stringValue: String {
        switch self {
            case .onboarding:
                return "onboarding"
            case .isDone:
                return "is done"
        }
    }
}

enum OnboardingShowcase: CaseIterable {
    case refresh
    case settings
    case level
    case patternCard
    case patternInput
    
    var index: Int {
        return OnboardingShowcase.allCases.firstIndex(of: self) ?? 0
    }
    
    var title: String {
        switch self {
            case .refresh:
                return "Refresh"
            case .settings:
                return "Settings"
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
            case .refresh:
                return "Refresh the pattern if you've forgotten or to restart this level."
            case .settings:
                return "Settings will allow you to paused, restart, or exit the game."
            case .level:
                return "Your current game level."
            case .patternCard:
                return "Memorize your pattern card to unlock the next level."
            case .patternInput:
                return "Draw the correct pattern based on the pattern card you've seen."
        }
    }
}
