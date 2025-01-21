//
//  CardCombinationView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardCombinationView: View {
    let patternData: [PatternData]
    let time: CGFloat
    var onComplete: (() -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Display items in a 2-column grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(patternData.prefix(patternData.count - (patternData.count % 2))) { data in
                        CardSpinView(patternData: data, time: time, onComplete: onComplete)
                    }
                }
                
                // Center the last item if the count is odd
                if patternData.count % 2 != 0 {
                    let lastItem = patternData[patternData.count - 1]
                    CardSpinView(patternData: lastItem, time: time, onComplete: onComplete)
                        .frame(maxWidth: .infinity, alignment: .center) // Center the last item
                }
            }
        }
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
    
    CardCombinationView(patternData: patternData, time: time)
}
