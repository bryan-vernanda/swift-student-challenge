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
    @Published var levelForHighlightCounter: Int
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
        levelForHighlightCounter = user.level
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
    
    private func adjustLevelTimeAndLines(levelingPattern: LevelingPattern, timeReduction: CGFloat, levelDivideBy: Int, maxNumberOfAddLines: Int, maxAddTime: CGFloat) {
        let defaultNumberOfLines = 3
        let differentCurrLevelWithPatternLevel = level - levelingPattern.value
        
        let numberOfLinesAdded = min((differentCurrLevelWithPatternLevel / levelDivideBy), maxNumberOfAddLines)
        let timeAdded = min((timeReduction * CGFloat(differentCurrLevelWithPatternLevel)), maxAddTime)
        var addDurationCauseByAddLines = 0.0
        
        numberOfLines = defaultNumberOfLines + numberOfLinesAdded
        
        if numberOfLinesAdded != 0 && level > 10 {
            addDurationCauseByAddLines = Double(numberOfLinesAdded) * (Double(levelDivideBy) * timeReduction)
        }
        time = levelingPattern.time - timeAdded + addDurationCauseByAddLines
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
                    timeReduction: 0.222,
                    levelDivideBy: 3,
                    maxNumberOfAddLines: 2,
                    maxAddTime: 2.0
                )
            case 11...30:
                adjustLevelTimeAndLines(
                    levelingPattern: levelingPattern,
                    timeReduction: 0.1666,
                    levelDivideBy: 7,
                    maxNumberOfAddLines: 2,
                    maxAddTime: 3.0
                )
            case 31...50:
                adjustLevelTimeAndLines(
                    levelingPattern: levelingPattern,
                    timeReduction: 0.1111,
                    levelDivideBy: 10,
                    maxNumberOfAddLines: 1,
                    maxAddTime: 2.0
                )
            default:
                adjustLevelTimeAndLines(
                    levelingPattern: levelingPattern,
                    timeReduction: 0.04166,
                    levelDivideBy: 25,
                    maxNumberOfAddLines: 1,
                    maxAddTime: 2.0
                )
        }
    }

    func loadLevel() {
        setupLevelingParameter()
        
        isAnimationRunning = true
        cardViewID = UUID()
        patterns = generatePatterns(numberOfPattern: numberOfPattern, numberOfLines: numberOfLines)
    }
    
    func checkIsUnlocked() -> Bool {
        return patterns.allSatisfy({ $0.isUnlocked })
    }
    
    func refreshLevel() {
        withAnimation(.easeInOut) {
            rotationAngle = 0
        }
        
        if !checkIsUnlocked() {
            if levelForHighlightCounter == 0 {
                levelForHighlightCounter = user.level
            }
            
            loadLevel()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(.easeInOut) {
                self.rotationAngle = -45
            }
        }
    }
}
