//
//  HomeView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 13/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var navManager: NavigationManager
    
    var body: some View {
        ZStack {
            Color(.boardBackground)
                .ignoresSafeArea()
            
            ForEach(Array(viewModel.patterns.enumerated()), id: \.1.id) { index, pattern in
                PatternInputView(
                    requiredPattern: pattern.path,
                    isReadOnly: true,
                    adjustHeight: 50
                )
                .frame(width: 200)
                .padding(.bottom, index % 2 == 0 ? 100 : 20)
                .rotationEffect(.degrees(index % 2 == 0 ? 11.15 : -11.15))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: index % 2 == 0 ? .bottomLeading : .bottomTrailing)
            }

            VStack {
                HStack {
                    VStack {
                        Text("PATTERN")
                            .padding(.leading, -80)
                        
                        Text("MATCH")
                            .padding(.leading, 130)
                    }
                }
                .padding(.bottom)
                .font(.chalkboard(.XXLTitle))
                .rotationEffect(.degrees(-11.15))
                
                HStack {
                    Image(systemName: "trophy.fill")
                        .foregroundStyle(.trophyYellow)
                    
                    Text("Highest Level: ")
                        
                }
                .font(.chalkboard(.title3))
            }
            .padding(.top, 40)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            if viewModel.level == 0 {
                PlayButton(title: "PLAY") {
                    navManager.currentView = .play
                }
            } else {
                VStack {
                    PlayButton(title: "NEW GAME") {
                        viewModel.levelModel.resetLevel()
                        navManager.currentView = .play
                    }
                    .padding(.bottom)
                    
                    PlayButton(title: "CONTINUE") {
                        navManager.currentView = .play
                    }
                }
                .padding(.top)
            }
        }
        .foregroundStyle(.chalkboard)
        .onAppear {
            viewModel.refreshView()
        }
    }
}

#Preview {
    MainView()
}


