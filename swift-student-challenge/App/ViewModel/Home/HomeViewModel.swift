//
//  HomeViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var level: Int
    @Published var highestLevel: Int
    @Published var navigationPath: NavigationPath
    @Published var deviceType: UIUserInterfaceIdiom
    @Published var patterns: [PatternData]
    
    private var user: User
    
    init() {
        user = User()
        level = user.level
        highestLevel = user.highestLevel
        navigationPath = NavigationPath()
        deviceType = UIDevice.current.userInterfaceIdiom
        patterns = []
    }
    
    func checkIsIpad() -> Bool {
        return deviceType == .pad
    }
    
    func refreshView() {
        level = user.level
        highestLevel = user.highestLevel
        
        let numberOfPattern = checkIsIpad() ? 6 : 2
        patterns = generatePatterns(numberOfPattern: numberOfPattern, numberOfLines: 6)
    }
    
    func regeneratePattern(at index: Int) {
        guard index >= 0, index < patterns.count else { return }
        let newPattern = generatePatterns(numberOfPattern: 1, numberOfLines: 6).first
        if let newPattern = newPattern {
            patterns[index] = newPattern
        }
    }
    
    func resetLevel() {
        user.resetLevel()
    }
    
    func navigateToGameplayView() {
        navigationPath.append(DestinationPath.gameplay)
    }

    func navigateToCreditView() {
        navigationPath.append(DestinationPath.credits)
    }
}
