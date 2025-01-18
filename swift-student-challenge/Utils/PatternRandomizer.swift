//
//  PatternRandomizer.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 17/01/25.
//

import Foundation

func patternRandomizer(numberOfPattern: Int, numberOfLines: Int) -> [PatternData] {
    let allSymbols: [PatternSymbol] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine]
    
    let adjacencyMap: [PatternSymbol: [PatternSymbol]] = [
        .one: [.two, .four, .five, .eight, .six],
        .two: [.one, .three, .four, .five, .six, .nine],
        .three: [.two, .five, .six, .four, .eight, .seven],
        .four: [.one, .five, .seven, .two, .eight, .six],
        .five: allSymbols,
        .six: [.three, .five, .nine, .one, .seven, .four],
        .seven: [.four, .five, .eight, .two, .six, .three],
        .eight: [.five, .seven, .nine, .one, .three, .two],
        .nine: [.five, .six, .eight, .two, .four, .one]
    ]
    
    var patterns: [PatternData] = []
    
    for _ in 0..<numberOfPattern {
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
        
        if currentPattern.count == numberOfLines {
            patterns.append(PatternData(path: currentPattern))
        }
    }
    
    return patterns
}


