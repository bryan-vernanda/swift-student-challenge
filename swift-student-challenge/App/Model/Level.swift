//
//  Level.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import Foundation

struct Level {
    private let levelKey = "levelKey"
    private let defaults = UserDefaults.standard

    var level: Int {
        get {
            return defaults.integer(forKey: levelKey)
        }
        set {
            defaults.set(newValue, forKey: levelKey)
        }
    }
    
    func resetLevel(to defaultLevel: Int = 1) {
        defaults.set(defaultLevel, forKey: levelKey)
    }
}
