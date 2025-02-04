//
//  GameplayViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

class GameplayViewModel: ObservableObject {
    @Published var level: Int
    @Published var numberOfPattern: Int
    @Published var numberOfLines: Int
    @Published var time: CGFloat
    @Published var isAnimationRunning: Bool
    @Published var isSettingOpen: Bool
    @Published var rotationAngle: Double
    @Published var deviceType: UIUserInterfaceIdiom
    @Published var cardViewID: UUID
    @Published var patterns: [PatternData]
    
    private var user: User
    
    init() {
        user = User()
        level = user.level
        numberOfPattern = 0
        numberOfLines = 0
        time = 0
        isAnimationRunning = true
        isSettingOpen = false
        rotationAngle = -45
        deviceType = UIDevice.current.userInterfaceIdiom
        cardViewID = UUID()
        patterns = []
    }
    
    func checkIsIpad() -> Bool {
        return deviceType == .pad
    }
    
    func resetLevel() {
        user.resetLevel()
        level = user.level
        loadLevel()
    }
    
    func goToNextLevel() {
        user.highestLevel = max(user.highestLevel, level)
        level += 1
        user.level = level
    }
    
    private func adjustLevelTimeAndLines(levelingPattern: LevelingPattern, timeReduction: CGFloat, levelDivideBy: Int, maxNumberOfAddLines: Int) {
        let defaultNumberOfLines = 3
        let maxAddTime = 2.0
        let differentCurrLevelWithPatternLevel = level - levelingPattern.value
        
        time = levelingPattern.time - min((timeReduction * CGFloat(differentCurrLevelWithPatternLevel)), maxAddTime)
        numberOfLines = defaultNumberOfLines + min((differentCurrLevelWithPatternLevel / levelDivideBy), maxNumberOfAddLines)
    }
    
    private func findLevelingPattern() -> LevelingPattern? {
        let allCases = LevelingPattern.allCases
        let sortedCases = allCases.sorted { $0.value > $1.value }
        
        for pattern in sortedCases {
            if pattern.value <= level {
                return pattern
            }
        }
        
        return nil
    }
    
    private func setupLevelingParameter() {
        let levelingPattern = findLevelingPattern()!
        
        numberOfPattern = levelingPattern.numberOfPattern
        switch level {
            case ...10:
                adjustLevelTimeAndLines(
                    levelingPattern: levelingPattern,
                    timeReduction: 0.22,
                    levelDivideBy: 3,
                    maxNumberOfAddLines: 2
                )
            case 11...50:
                adjustLevelTimeAndLines(
                    levelingPattern: levelingPattern,
                    timeReduction: 0.105,
                    levelDivideBy: 7,
                    maxNumberOfAddLines: 2
                )
            default:
                adjustLevelTimeAndLines(
                    levelingPattern: levelingPattern,
                    timeReduction: 0.0408,
                    levelDivideBy: 14,
                    maxNumberOfAddLines: 3
                )
        }
    }

    func loadLevel() {
        setupLevelingParameter()
        
        isAnimationRunning = true
        cardViewID = UUID()
        patterns = generatePatterns(numberOfPattern: numberOfPattern, numberOfLines: numberOfLines)
    }
    
    func refreshLevel() {
        withAnimation(.easeInOut) {
            rotationAngle = 0
        }
        
        if !patterns.allSatisfy({ $0.isUnlocked }) {
            loadLevel()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut) {
                self.rotationAngle = -45
            }
        }
    }
}
