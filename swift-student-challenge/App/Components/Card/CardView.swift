//
//  CardView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardView: View {
    let deviceType = UIDevice.current.userInterfaceIdiom
    var backRotation: CGFloat
    var returnRotation: CGFloat
    var isFlipped: Bool
    var patternData: PatternData?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                .frame(width: deviceType == .pad ? 240 : 150, height: deviceType == .pad ? 240 : 150)
                .foregroundStyle(.buttonBackground)
                .overlay {
                    RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                        .stroke(lineWidth: deviceType == .pad ? 12.8 : 8)
                        .foregroundStyle(.boardLightBrown)
                }
            
            if let patternData = patternData {
                PatternInputView(
                    requiredPattern: [patternData],
                    isReadOnly: true,
                    adjustCircleFrame: (deviceType == .pad ? 17.6 : 11),
                    adjustLineWidth: (deviceType == .pad ? 8 : 5),
                    adjustHeight: (deviceType == .pad ? 70 : 43.75)
                )
                .frame(width: deviceType == .pad ? 280 : 175)
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: deviceType == .pad ? 120 : 75, height: deviceType == .pad ? 120 : 75)
                    .foregroundStyle(.chalkboard)
            }
            
        }
        .rotation3DEffect(.degrees(isFlipped ? backRotation: returnRotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

#Preview {
    @Previewable @State var isFlipped: Bool = false
    @Previewable var patternData: PatternData = PatternData(path: [.three, .two, .four, .eight, .nine])
    
    ZStack {
        CardView(backRotation: 0, returnRotation: -90, isFlipped: isFlipped, patternData: patternData)
            .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
        
        CardView(backRotation: 90, returnRotation: 0, isFlipped: isFlipped)
            .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
    }
    .onTapGesture {
        withAnimation(.easeIn) {
            isFlipped.toggle()
        }
    }
}
