//
//  LevelViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import Foundation

class LevelViewModel: ObservableObject {
    @Published var level: Int = 0
    
    private var levelModel = Level()
    
    init() {
        self.level = levelModel.level
    }
    
    func updateLevel(to newLevel: Int) {
        level = newLevel
        levelModel.level = newLevel
    }
    
    func resetLevel(to defaultLevel: Int = 1) {
        level = defaultLevel
        levelModel.resetLevel(to: defaultLevel)
    }
}
