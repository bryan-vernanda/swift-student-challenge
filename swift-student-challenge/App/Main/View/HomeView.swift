//
//  HomeView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 13/01/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.boardBackground)
                    .ignoresSafeArea()

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
                        viewModel.isNavigate = true
                    }
                } else {
                    VStack {
                        PlayButton(title: "NEW GAME") {
                            viewModel.isNavigate = true
                            viewModel.levelModel.resetLevel()
                        }
                        .padding(.bottom)
                        
                        PlayButton(title: "CONTINUE") {
                            viewModel.isNavigate = true
                        }
                    }
                    .padding(.top)
                }
            }
            .foregroundStyle(.chalkboard)
            .onAppear {
                viewModel.refreshView()
            }
            .navigationDestination(isPresented: $viewModel.isNavigate) {
                CardPlayView()
            }
        }
    }
}

#Preview {
    HomeView()
}


