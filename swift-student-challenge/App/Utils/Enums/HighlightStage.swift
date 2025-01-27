//
//  HighlightStage.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 27/01/25.
//

import Foundation

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
