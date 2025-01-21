//
//  PatternInputViewHelper.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

fileprivate struct PatternInputViewNamespace {
    // Pattern node : represent each dot in the pattern grid
    struct PatternNode: Identifiable {
        let id: UUID = UUID() // Unique identifier for each dot
        var number: Int // The number representing the dot
        var dotFrame: CGRect = .zero // the frame of the dot for detecting touches
    }
    
    // DotFrameKey: A preference key to store each dot's frame
    struct DotFrameKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
    }
    
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
    
    struct ShakeEffect: ViewModifier, Animatable {
        var trigger: Bool
        var distance: CGFloat
        var animatableData: CGFloat

        func body(content: Content) -> some View {
            content
                .offset(x: trigger ? sin(animatableData * .pi * 2) * distance : 0)
        }

        init(trigger: Bool, distance: CGFloat) {
            self.trigger = trigger
            self.distance = distance
            self.animatableData = trigger ? 1 : 0
        }
    }
}
