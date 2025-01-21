//
//  OverlayView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

extension CardPlayView {
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
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
                    .foregroundStyle(.orange)
                    .background(.black)
                    .frame(width: 275, height: CGFloat(150 + buttons.count * 50))
                
                VStack(spacing: 16) {
                    Text(title)
                        .font(.title2)
                        .padding(.bottom)
                    
                    ForEach(buttons, id: \.id) { button in
                        Button(action: button.action) {
                            Text(button.label)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
                .foregroundStyle(.white)
                .frame(width: 250)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
