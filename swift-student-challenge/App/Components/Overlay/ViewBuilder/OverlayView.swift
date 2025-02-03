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
        let deviceType = UIDevice.current.userInterfaceIdiom
        
        GeometryReader { _ in
            Rectangle()
                .fill(.black)
                .opacity(0.5)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                    .stroke(lineWidth: deviceType == .pad ? 12.8 : 8)
                    .foregroundStyle(.boardDarkBrown)
                    .frame(width: deviceType == .pad ? 448 : 280, height: CGFloat((deviceType == .pad ? 320 : 200) + buttons.count * (deviceType == .pad ? 80 : 50)))
                    .clipShape(
                        RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                            .stroke(lineWidth: deviceType == .pad ? 12.8 : 8)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: deviceType == .pad ? 48 : 30)
                            .fill(.boardBackground)
                    )
                
                VStack(spacing: deviceType == .pad ? 25.6 : 16) {
                    Text(title)
                        .font(deviceType == .pad ? .chalkboard(fontSize: 44) : .chalkboard(.title2))
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
                .frame(width: deviceType == .pad ? 400 : 250)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
