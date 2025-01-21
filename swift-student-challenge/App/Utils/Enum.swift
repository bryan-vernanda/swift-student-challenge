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
