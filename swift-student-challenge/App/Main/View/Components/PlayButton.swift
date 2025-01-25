//
//  PlayButton.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 25/01/25.
//

import SwiftUI

struct PlayButton: View {
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
                    .font(.chalkboard(.title3))
            }
            .frame(width: 200, height: 60)
        }
    }
}

#Preview {
    PlayButton(title: "PLAY", action: {})
        .foregroundStyle(.chalkboard)
}
