//
//  HighlightModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

struct HighlightModel: Identifiable, Equatable {
    var id: UUID = .init()
    var anchor: Anchor<CGRect>
    var title: String
    var detail: String
    var cornerRadius: CGFloat
    var style: RoundedCornerStyle
    var scale: CGFloat
    var stage: String

    static func == (lhs: HighlightModel, rhs: HighlightModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.detail == rhs.detail &&
        lhs.cornerRadius == rhs.cornerRadius &&
        lhs.style == rhs.style &&
        lhs.scale == rhs.scale &&
        lhs.stage == rhs.stage
    }
}
