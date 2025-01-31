//
//  HomeViewModel.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var level: Int
    @Published var highestLevel: Int
    @Published var isNavigate: Bool
    @Published var deviceType: UIUserInterfaceIdiom
    @Published var patterns: [PatternData]
    
    private var user: User
    
    init() {
        user = User()
        level = user.level
        highestLevel = user.highestLevel
        isNavigate = false
        deviceType = UIDevice.current.userInterfaceIdiom
        patterns = []
    }
    
    func refreshView() {
        level = user.level
        highestLevel = user.highestLevel
        
        let numberOfPattern = deviceType == .pad ? 6 : 2
        patterns = generatePatterns(numberOfPattern: numberOfPattern, numberOfLines: 6)
    }
    
    func resetLevel() {
        user.resetLevel()
    }
    
    func navigateToGameplayView() {
        isNavigate = true
    }
}
