//
//  HomeViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var level: Int
    @Published var highestLevel: Int
    @Published var isNavigate: Bool
    @Published var patterns: [PatternData]
    
    private var user: User
    
    init() {
        user = User()
        level = user.level
        highestLevel = user.highestLevel
        isNavigate = false
        patterns = []
    }
    
    func refreshView() {
        level = user.level
        highestLevel = user.highestLevel
        patterns = generatePatterns(numberOfPattern: 2, numberOfLines: 6)
    }
    
    func resetLevel() {
        user.resetLevel()
    }
    
    func navigateToGameplayView() {
        isNavigate = true
    }
}
