//
//  CardSpinView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardSpinView: View {
    let patternData: PatternData
    let time: CGFloat
    var onComplete: (() -> Void)?
    
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
        .onChange(of: patternData.isUnlocked) { _, newValue in
            if newValue {
                isFlipped = true
                SoundFXManager.playSound(soundFX: SoundFX.flipCard)
            }
        }
    }
    
    private func startFlipAnimation() {
        isAnimated = true
        
        withAnimation(.easeIn) {
            isFlipped.toggle()
            SoundFXManager.playSound(soundFX: SoundFX.flipCard)
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { _ in
            withAnimation(.easeIn) {
                isFlipped.toggle()
                SoundFXManager.playSound(soundFX: SoundFX.flipCard)
            }
            onComplete?()
        }
    }
}

#Preview {
    CardSpinView(
        patternData: PatternData(path: [.three, .two, .four, .eight, .nine]),
        time: 4.0
    )
}
