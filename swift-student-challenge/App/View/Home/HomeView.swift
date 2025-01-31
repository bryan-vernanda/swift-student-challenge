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
                Color.boardBackground
                    .ignoresSafeArea()
                
                if viewModel.checkIsIpad() {
                    ForEach(Array(viewModel.patterns.enumerated()), id: \.1.id) { index, pattern in
                        let position = PatternPosition.allCases[index % PatternPosition.allCases.count]
                        VStack {
                            PatternInputView(
                                requiredPattern: [pattern],
                                isReadOnly: true,
                                adjustHeight: 60
                            )
                            .frame(width: 240)
                            .padding(.bottom, position.paddingBottom)
                            .rotationEffect(.degrees(position.rotationEffect))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: index % 2 == 0 ? .bottomLeading : .bottomTrailing)
                        }
                        .padding(index % 2 == 0 ? .leading : .trailing, position.paddingLeadTrail)
                    }
                } else {
                    ForEach(Array(viewModel.patterns.enumerated()), id: \.1.id) { index, pattern in
                        PatternInputView(
                            requiredPattern: [pattern],
                            isReadOnly: true,
                            adjustHeight: 50
                        )
                        .frame(width: 200)
                        .padding(.bottom, index % 2 == 0 ? 100 : 20)
                        .rotationEffect(.degrees(index % 2 == 0 ? 11.15 : -11.15))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: index % 2 == 0 ? .bottomLeading : .bottomTrailing)
                    }
                }

                VStack {
                    HStack {
                        VStack {
                            Text("PATTERN")
                                .padding(.leading, viewModel.checkIsIpad() ? -85 : -80)
                            
                            Text("MIND")
                                .padding(.leading, viewModel.checkIsIpad() ? 170 : 165)
                        }
                    }
                    .padding(.bottom)
                    .font(.chalkboard(viewModel.checkIsIpad() ? .ExtraXLTitle : .XXLTitle))
                    .rotationEffect(.degrees(-11.15))
                    
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(.trophyYellow)
                        
                        Text("Highest Level: \(viewModel.highestLevel)")
                    }
                    .font(.chalkboard(viewModel.checkIsIpad() ? .title2half : .title3))
                }
                .padding(.top, viewModel.checkIsIpad() ? 60 : 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                if viewModel.level == 0 {
                    PlayButton(title: "PLAY") {
                        viewModel.navigateToGameplayView()
                    }
                } else {
                    VStack {
                        PlayButton(title: "NEW GAME") {
                            viewModel.resetLevel()
                            viewModel.navigateToGameplayView()
                        }
                        .padding(.bottom)
                        
                        PlayButton(title: "CONTINUE") {
                            viewModel.navigateToGameplayView()
                        }
                    }
                    .padding(.top, viewModel.checkIsIpad() ? 100 : 0)
                }
            }
            .foregroundStyle(.chalkboard)
            .onAppear {
                viewModel.refreshView()
            }
            .navigationDestination(isPresented: $viewModel.isNavigate) {
                GameplayView()
            }
        }
    }
}

#Preview {
    HomeView()
}


