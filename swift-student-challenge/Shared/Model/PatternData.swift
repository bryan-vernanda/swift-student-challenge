//
//  PatternData.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import Foundation

struct PatternData: Identifiable {
    let id: UUID = UUID()
    var path: [PatternSymbol]
    var isUnlocked: Bool = false
}
