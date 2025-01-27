//
//  OverlayButtonData.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 27/01/25.
//

import Foundation

extension CardPlayView {
    struct OverlayButtonData: Identifiable {
        let id = UUID()
        let label: String
        let action: () -> Void
    }
}
