//
//  OverlayView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

extension GameplayView {
    @ViewBuilder
    func overlayView(
        title: String,
        buttons: [OverlayButtonData]
    ) -> some View {
        GeometryReader { _ in
            Rectangle()
                .fill(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(lineWidth: 8)
                    .foregroundStyle(.boardDarkBrown)
                    .frame(width: 280, height: CGFloat(200 + buttons.count * 50))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 8)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.boardBackground)
                    )
                
                VStack(spacing: 16) {
                    Text(title)
                        .font(.chalkboard(.title2))
                        .padding(.bottom)
                    
                    ForEach(buttons, id: \.id) { button in
                        PlayButton(
                            title: button.label,
                            action: button.action
                        )
                    }
                }
                .padding(.bottom)
                .foregroundStyle(.chalkboard)
                .frame(width: 250)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
