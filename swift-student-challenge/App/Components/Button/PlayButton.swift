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
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(.chalkboard, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.buttonBackground)
                    )
                
                Text(title)
                    .font(.chalkboard(deviceType == .pad ? .title2half : .title3))
            }
            .frame(width: deviceType == .pad ? 233.33 : 200, height: deviceType == .pad ? 70 : 60)
        }
    }
}

#Preview {
    PlayButton(title: "PLAY", action: {})
        .foregroundStyle(.chalkboard)
}
