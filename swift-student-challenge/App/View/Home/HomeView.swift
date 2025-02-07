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
        NavigationStack(path: $viewModel.navigationPath) {
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
                                adjustCircleFrame: 13.2,
                                adjustLineWidth: 6,
                                adjustHeight: 60
                            )
                            .frame(width: 240)
                            .rotationEffect(.degrees(position.rotationEffect))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(.bottom, position.paddingBottom)
                            .padding(.leading, position.paddingLeading)
                        }
                    }
                } else {
                    ForEach(Array(viewModel.patterns.enumerated()), id: \.1.id) { index, pattern in
                        PatternInputView(
                            requiredPattern: [pattern],
                            isReadOnly: true,
                            adjustHeight: 50
                        )
                        .frame(width: 200)
                        .padding(.bottom, index % 2 == 0 ? 130 : 80)
                        .rotationEffect(.degrees(index % 2 == 0 ? 11.15 : -11.15))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: index % 2 == 0 ? .bottomLeading : .bottomTrailing)
                    }
                }

                VStack {
                    HStack {
                        VStack {
                            Text("PATTERN")
                                .padding(.leading, viewModel.checkIsIpad() ? -105 : -80)
                            
                            Text("MIND")
                                .padding(.leading, viewModel.checkIsIpad() ? 190 : 165)
                        }
                    }
                    .padding(.bottom)
                    .font(viewModel.checkIsIpad() ? .chalkboard(fontSize: 64): .chalkboard(.XXLTitle))
                    .rotationEffect(.degrees(-11.15))
                    
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(.trophyYellow)
                        
                        Text("Highest Level: \(viewModel.highestLevel)")
                    }
                    .font(.chalkboard(viewModel.checkIsIpad() ? .title1 : .title3))
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                if viewModel.level == 0 {
                    PlayButton(title: "PLAY") {
                        viewModel.navigateToGameplayView()
                    }
                } else {
                    VStack(spacing: viewModel.checkIsIpad() ? 25.6 : 16) {
                        PlayButton(title: "NEW GAME") {
                            viewModel.resetLevel()
                            viewModel.navigateToGameplayView()
                        }
                        
                        PlayButton(title: "CONTINUE") {
                            viewModel.navigateToGameplayView()
                        }
                    }
                    .padding(.top, viewModel.checkIsIpad() ? 120 : 0)
                }
                
                Button {
                    SoundFXManager.playSound(soundFX: SoundFX.click)
                    
                    viewModel.navigateToCreditView()
                } label: {
                    Text("CREDITS")
                        .underline()
                        .font(viewModel.checkIsIpad() ? .chalkboard(.title2) : .chalkboard(.body))
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, viewModel.checkIsIpad() ? 60 : 30)

            }
            .foregroundStyle(.chalkboard)
            .onAppear {
                viewModel.refreshView()
            }
            .navigationDestination(for: DestinationPath.self) { destination in
                switch destination {
                    case .gameplay:
                        GameplayView()
                    case .credits:
                        CreditView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}


