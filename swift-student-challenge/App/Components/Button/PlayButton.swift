//
//  PlayButton.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 25/01/25.
//

import SwiftUI

struct PlayButton: View {
    let deviceType = UIDevice.current.userInterfaceIdiom
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            SoundFXManager.playSound(soundFX: SoundFX.click)
            
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: deviceType == .pad ? 15 : 10)
                    .strokeBorder(.chalkboard, lineWidth: deviceType == .pad ? 3 : 2)
                    .background(
                        RoundedRectangle(cornerRadius: deviceType == .pad ? 15 : 10)
                            .fill(.buttonBackground)
                    )
                
                Text(title)
                    .font(.chalkboard(deviceType == .pad ? .title1 : .title3))
                    .foregroundStyle(.chalkboard)
            }
            .frame(width: deviceType == .pad ? 300 : 200, height: deviceType == .pad ? 90 : 60)
        }
    }
}

#Preview {
    PlayButton(title: "PLAY", action: {})
}
