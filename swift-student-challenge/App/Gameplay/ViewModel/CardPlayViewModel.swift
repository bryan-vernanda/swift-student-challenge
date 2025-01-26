//
//  CardPlayViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

class CardPlayViewModel: ObservableObject {
    @Published var level: Int
    @Published var numberOfPattern: Int
    @Published var numberOfLines: Int
    @Published var time: CGFloat
    @Published var isAnimationRunning: Bool
    @Published var isSettingOpen: Bool
    @Published var rotationAngle: Double
    @Published var cardViewID: UUID
    @Published var patterns: [PatternData]
    
    private var levelModel: Level
    
    init() {
        levelModel = Level()
        level = levelModel.level
        numberOfPattern = 0
        numberOfLines = 0
        time = 0
        isAnimationRunning = true
        isSettingOpen = false
        rotationAngle = -45
        cardViewID = UUID()
        patterns = []
    }
    
    func resetLevel() {
        levelModel.resetLevel()
        level = levelModel.level
        loadLevel()
    }
    
    func goToNextLevel() {
        level += 1
        levelModel.level = level
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
        withAnimation(.easeInOut(duration: 0.5)) {
            rotationAngle = 0
        }
        
        if !patterns.allSatisfy({ $0.isUnlocked }) {
            loadLevel()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.rotationAngle = -45
            }
        }
    }
}
