//
//  PatternNode.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import Foundation

extension PatternInputView {
    // Pattern node : represent each dot in the pattern grid
    struct PatternNode: Identifiable {
        let id: UUID = UUID() // Unique identifier for each dot
        var number: Int // The number representing the dot
        var dotFrame: CGRect = .zero // the frame of the dot for detecting touches
    }
}
