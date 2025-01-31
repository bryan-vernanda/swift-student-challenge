//
//  Highlight.swift
//  hanvest
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
}
