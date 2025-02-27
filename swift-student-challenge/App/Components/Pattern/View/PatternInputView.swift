//
//  PatternView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 17/01/25.
//

import SwiftUI

struct PatternInputView: View {
    // Configuration
    var outerCircleColor: Color = .chalkboard // outer circle color of each pattern dot
    var lineColor: Color = .chalkboard // line color for drawn pattern
    var skipVerification: Bool = false // flag to disable pattern verification
    var requiredPattern: [PatternData] // required Pattern to unlock
    var isReadOnly: Bool = false // New property to control read-only mode
    var adjustCircleFrame: CGFloat = 11
    var adjustLineWidth: CGFloat = 5
    var adjustHeight: CGFloat = 100
    var onPatternComplete: ((Bool, [PatternSymbol]) -> ())? = nil // completion handler for pattern input
    
    // view properties
    @State var availableDots: [PatternNode] = (1...9).compactMap({return PatternNode(number: $0)}) // All pattern dots
    @State var currentDragLocation: CGPoint = .zero // the current dragging location
    @State var activePattern: [PatternNode] = [] // the dots connected in the active pattern
    @State var displayError: Bool = false // trigger to display incorrect pattern animation
    
    var body: some View {
        PatternGridView()
            .background {
                let points = activePattern.map({
                    let frame = $0.dotFrame
                    return CGPoint(x: frame.midX, y: frame.midY)
                })
                ZStack {
                    if !points.isEmpty {
                        PatternDrawingPath(points: points, currentLocation: currentDragLocation)
                            .stroke(
                                displayError ? .red : lineColor,
                                style: StrokeStyle(
                                    lineWidth: adjustLineWidth, lineCap: .round, lineJoin: .round
                                )
                            )
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut, value: points)
            }
            .shakeEffect(trigger: displayError, distance: 10) // default 20
            .onAppear {
                // Pre-fill the activePattern with the required pattern
                if isReadOnly, let firstPattern = requiredPattern.first {
                    activePattern = firstPattern.path.compactMap { symbol in
                        availableDots.first { $0.number == symbol.rawValue }
                    }
                }
            }
    }
}

#Preview {
    HomeView()
}
