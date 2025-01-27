//
//  GeneratePatterns.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 25/01/25.
//

import Foundation

func generatePatterns(numberOfPattern: Int, numberOfLines: Int) -> [PatternData] {
    let allSymbols: [PatternSymbol] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine]
    
    let adjacencyMap: [PatternSymbol: [PatternSymbol]] = [
        .one: [.two, .four, .five],
        .two: [.one, .three, .five],
        .three: [.two, .six, .five],
        .four: [.one, .five, .seven],
        .five: allSymbols,
        .six: [.three, .five, .nine],
        .seven: [.four, .five, .eight],
        .eight: [.seven, .five, .nine],
        .nine: [.six, .five, .eight]
    ]
    
    var patterns: [PatternData] = []
    var generatedPaths: Set<[PatternSymbol]> = []

    while patterns.count < numberOfPattern {
        var currentPattern: [PatternSymbol] = []
        var currentSymbol = allSymbols.randomElement()!
        currentPattern.append(currentSymbol)
        
        for _ in 1..<numberOfLines {
            guard let validSymbols = adjacencyMap[currentSymbol]?.filter({ !currentPattern.contains($0) }), !validSymbols.isEmpty else {
                break
            }
            currentSymbol = validSymbols.randomElement()!
            currentPattern.append(currentSymbol)
        }
        
        let isDuplicate = generatedPaths.contains(currentPattern)
        let isPalindrome = generatedPaths.contains(currentPattern.reversed())
        
        if currentPattern.count == numberOfLines && !isDuplicate && !isPalindrome {
            patterns.append(PatternData(path: currentPattern))
            generatedPaths.insert(currentPattern)
        }
    }
    
    return patterns
}
