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
    
    var isCorrect: Bool
    var onComplete: (() -> Void)?
    
    @State private var isFlipped: Bool = false
    @State private var isAnimated: Bool = false
    @State private var timer: Timer? = nil
    @State private var flashcardRotation = 0.0
    @State private var contentRotation = 0.0
    
    var body: some View {
        ZStack {
            if isFlipped {
                CardView(patternData: patternData, isCorrect: isCorrect)
            } else {
                CardView(isCorrect: isCorrect)
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
        .onAppear {
            if !isAnimated {
                startFlipping()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
        .onChange(of: patternData.isUnlocked) { _, newValue in
            if newValue {
                flipCard()
                SoundFXManager.playSound(soundFX: SoundFX.flipCard)
            }
        }
    }
    
    private func flipCard() {
        let animationTime = 0.5
        let rotationAmount = isFlipped ? -180.0 : 180.0
        
        withAnimation(Animation.linear(duration: animationTime)) {
            flashcardRotation += rotationAmount
        }
        
        withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
            contentRotation += rotationAmount
            isFlipped.toggle()
            SoundFXManager.playSound(soundFX: SoundFX.flipCard)
        }
    }
    
    private func startFlipping() {
        isAnimated = true
        
        flipCard()
        
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: false) { _ in
            flipCard()
            onComplete?()
        }
    }
}


#Preview {
    @Previewable var patternData: PatternData = PatternData(path: [.three, .two, .four, .eight, .nine])
    @Previewable let time: CGFloat = 3.0
    
    CardSpinView(patternData: patternData, time: time, isCorrect: false)
}
