//
//  HomeViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isNavigate: Bool
    @Published var level: Int
    @Published var patterns: [PatternData]
    
    var levelModel: Level
    
    init() {
        levelModel = Level()
        isNavigate = false
        level = levelModel.level
        patterns = []
    }
    
    func refreshView() {
        level = levelModel.level
        patterns = generatePatterns(numberOfPattern: 6, numberOfLines: 6)
    }
}
