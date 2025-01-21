//
//  PatternDrawingPath.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

extension PatternInputView {
    // PatternDrawingPath: A shape to draw the path of the pattern
    struct PatternDrawingPath: Shape {
        var points: [CGPoint] // the point of the connected pattern
        var currentLocation: CGPoint // the current drag location
        func path(in rect: CGRect) -> Path {
            var path = Path()
            for (index, point) in points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            if currentLocation != .zero {
                path.addLine(to: currentLocation)
            }
            return path
        }
    }
}
