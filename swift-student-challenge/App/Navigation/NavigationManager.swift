//
//  NavigationManager.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 26/01/25.
//

import Foundation

class NavigationManager: ObservableObject {
    @Published var currentView: AppView = .home
}
