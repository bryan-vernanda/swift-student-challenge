//
//  CardView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 16/01/25.
//

import SwiftUI

struct CardView: View {
    let deviceType = UIDevice.current.userInterfaceIdiom
    var patternData: PatternData?
    
    var body: some View {
        ZStack {
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
        .frame(width: deviceType == .pad ? 240 : 150, height: deviceType == .pad ? 240 : 150)
        .background(
            RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                .foregroundStyle(.buttonBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                .stroke(lineWidth: deviceType == .pad ? 12.8 : 8)
                .foregroundStyle(.boardLightBrown)
        )
    }
}

#Preview {
    CardView()
}
