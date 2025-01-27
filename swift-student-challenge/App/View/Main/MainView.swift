//
//  MainView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 26/01/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var navManager = NavigationManager()
    @Namespace private var transitionNamespace

    var body: some View {
        ZStack {
            if navManager.currentView == .home {
                HomeView()
                    .matchedGeometryEffect(id: "transition", in: transitionNamespace)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else if navManager.currentView == .play {
                GameplayView()
                    .matchedGeometryEffect(id: "transition", in: transitionNamespace)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.easeInOut, value: navManager.currentView)
        .environmentObject(navManager)
    }
}

#Preview {
    MainView()
}
