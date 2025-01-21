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
    
    var levelModel: Level
    
    init() {
        levelModel = Level()
        isNavigate = false
        level = levelModel.level
    }
    
    func refreshLevel() {
        level = levelModel.level
    }
}
