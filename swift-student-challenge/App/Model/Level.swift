//
//  Level.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import Foundation

struct User {
    private let levelKey = "levelKey"
    private let highestLevelKey = "highestLevelKey"
    private let defaults = UserDefaults.standard

    var level: Int {
        get {
            defaults.integer(forKey: levelKey)
        }
        set {
            defaults.set(newValue, forKey: levelKey)
        }
    }
    
    var highestLevel: Int {
        get {
            defaults.integer(forKey: highestLevelKey)
        }
        set {
            defaults.set(newValue, forKey: highestLevelKey)
        }
    }
    
    func resetLevel(to defaultLevel: Int = 52) {
        defaults.set(defaultLevel, forKey: levelKey)
    }
    
    func resetHighestLevel(to defaultHighestLevel: Int = 0) {
        defaults.set(defaultHighestLevel, forKey: highestLevelKey)
    }
}

