//
//  CardCombinationView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardCombinationView: View {
    let deviceType = UIDevice.current.userInterfaceIdiom
    let patternData: [PatternData]
    let time: CGFloat
    let levelForHighlightCounter: Int
    
    var isCorrect: Bool
    var onComplete: (() -> Void)?
    
    var body: some View {
        VStack(spacing: patternData.count != 1 ? (deviceType == .pad ? 51.2 : 32) : 0) {
            // Display items in a 2-column grid
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 0),
                    GridItem(.flexible(), spacing: 0)
                ],
                spacing: deviceType == .pad ? 51.2 : 32
            ) {
                ForEach(patternData.prefix(patternData.count - (patternData.count % 2))) { data in
                    CardSpinView(patternData: data, time: time, levelForHighlightCounter: levelForHighlightCounter, isCorrect: isCorrect, onComplete: onComplete)
                }
            }
            
            // Center the last item if the count is odd
            if patternData.count % 2 != 0 {
                let lastItem = patternData[patternData.count - 1]
                CardSpinView(patternData: lastItem, time: time, levelForHighlightCounter: levelForHighlightCounter, isCorrect: isCorrect, onComplete: onComplete)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: deviceType == .pad ? 600 : 375)
    }
}

#Preview {
    let patternData: [PatternData] = [
        PatternData(path: [.three, .two, .four, .eight, .nine]),
        PatternData(path: [.two, .three, .five, .nine, .eight]),
        PatternData(path: [.three, .six, .nine, .eight, .seven]),
        PatternData(path: [.three, .two, .one, .four, .seven])
    ]
    let time = 4.0
    
    CardCombinationView(patternData: patternData, time: time, levelForHighlightCounter: 1, isCorrect: false)
}
