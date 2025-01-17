//
//  CardCombinationView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardCombinationView: View {
    let patternData: [PatternData] = [
        PatternData(path: [.three, .two, .four, .eight, .nine]),
        PatternData(path: [.two, .three, .five, .nine, .eight]),
        PatternData(path: [.three, .six, .nine, .eight, .seven]),
        PatternData(path: [.three, .two, .one, .four, .seven])
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(patternData) { data in
                    CardSpinView(patternData: data)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CardCombinationView()
}
