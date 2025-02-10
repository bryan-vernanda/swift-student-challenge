//
//  CreditViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 10/02/25.
//

import SwiftUI

class CreditViewModel: ObservableObject {
    @Published var deviceType: UIUserInterfaceIdiom
    @Published var patterns: [PatternData]
    
    init() {
        deviceType = UIDevice.current.userInterfaceIdiom
        patterns = []
    }
    
    func checkIsIpad() -> Bool {
        return deviceType == .pad
    }
    
    func refreshPattern() {
        let numberOfPattern = checkIsIpad() ? 5 : 3
        patterns = generatePatterns(numberOfPattern: numberOfPattern, numberOfLines: 6)
    }
    
    func regeneratePattern(at index: Int) {
        guard index >= 0, index < patterns.count else { return }
        let newPattern = generatePatterns(numberOfPattern: 1, numberOfLines: 6).first
        if let newPattern = newPattern {
            patterns[index] = newPattern
        }
    }
}
