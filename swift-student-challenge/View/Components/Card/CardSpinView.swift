//
//  CardSpinView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardSpinView: View {
    let patternData: PatternData
    
    @State private var isFlipped: Bool = false
    @State private var isAnimated: Bool = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack {
            CardView(backRotation: 0, returnRotation: -90, isFlipped: isFlipped, patternData: patternData)
                .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
            
            CardView(backRotation: 90, returnRotation: 0, isFlipped: isFlipped)
                .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
        }
        .onAppear {
            if !isAnimated {
                startFlipAnimation()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func startFlipAnimation() {
        isAnimated = true
        
        withAnimation(.easeIn) {
            isFlipped.toggle()
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
            withAnimation(.easeIn) {
                isFlipped.toggle()
            }
        }
    }
}

#Preview {
    CardSpinView(patternData: PatternData(path: [.three, .two, .four, .eight, .nine]))
}
