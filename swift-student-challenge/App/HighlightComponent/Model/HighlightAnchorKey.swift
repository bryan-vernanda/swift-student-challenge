//
//  HighlightAnchorKey.swift
//  hanvest
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

/// anchor key
struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int: HighlightModel] = [:]
    
    static func reduce(value: inout [Int: HighlightModel], nextValue: () -> [Int: HighlightModel]) {
        value.merge(nextValue()) { $1 }
    }
    
    
}
