//
//  PatternInputViewHelper.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

extension PatternInputView {
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

extension View {
    // Custom shake effect for wrong patterns
    func shakeEffect(trigger: Bool, distance: CGFloat) -> some View {
        modifier(ShakeEffect(trigger: trigger, distance: distance))
    }
}
