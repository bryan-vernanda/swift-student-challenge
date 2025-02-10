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
                        
                        ZStack {
                            PatternInputView(
                                requiredPattern: [pattern],
                                isReadOnly: true,
                                adjustCircleFrame: 13.2,
                                adjustLineWidth: 6,
                                adjustHeight: 60
                            )
                            .frame(width: 240)
                            .rotationEffect(.degrees(position.rotationEffect))

                            Rectangle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.clear)
                                .contentShape(Rectangle())
                                .rotationEffect(.degrees(position.rotationEffect))
                                .onTapGesture {
                                    viewModel.regeneratePattern(at: index)
                                }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.bottom, position.paddingBottom)
                        .padding(.leading, position.paddingLeading)
                    }
                } else {
                    ForEach(Array(viewModel.patterns.enumerated()), id: \.1.id) { index, pattern in
                        
                        ZStack {
                            PatternInputView(
                                requiredPattern: [pattern],
                                isReadOnly: true,
                                adjustCircleFrame: 8.8,
                                adjustLineWidth: 4,
                                adjustHeight: 40
                            )
                            .frame(width: 160)
                            .rotationEffect(.degrees(index % 2 == 0 ? 11.15 : -11.15))
                            
                            Rectangle()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.clear)
                                .contentShape(Rectangle())
                                .rotationEffect(.degrees(index % 2 == 0 ? 11.15 : -11.15))
                                .onTapGesture {
                                    viewModel.regeneratePattern(at: index)
                                }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding(.bottom, index % 2 == 0 ? -400 : -500)
                        .padding(index % 2 == 0 ? .leading : .trailing, -182.5)
                    }
                }

                VStack {
                    HStack {
                        VStack {
                            Text("PATTERN")
                                .padding(.leading, viewModel.checkIsIpad() ? -105 : -60)
                            
                            Text("MIND")
                                .padding(.leading, viewModel.checkIsIpad() ? 190 : 145)
                        }
                    }
                    .padding(.bottom)
                    .font(.chalkboard(fontSize: viewModel.checkIsIpad() ? 64 : 42.667))
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
                    PlayButton(title: "Play") {
                        viewModel.navigateToGameplayView()
                    }
                } else {
                    VStack(spacing: viewModel.checkIsIpad() ? 24 : 16) {
                        PlayButton(title: "New Game") {
                            viewModel.resetLevel()
                            viewModel.navigateToGameplayView()
                        }
                        
                        PlayButton(title: "Continue") {
                            viewModel.navigateToGameplayView()
                        }
                    }
                    .padding(.top, viewModel.checkIsIpad() ? 120 : 0)
                }
                
                Button {
                    SoundFXManager.playSound(soundFX: SoundFX.click)
                    
                    viewModel.navigateToCreditView()
                } label: {
                    Text("Credits")
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


