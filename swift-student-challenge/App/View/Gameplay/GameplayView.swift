//
//  GameplayView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

struct GameplayView: View {
    @StateObject private var viewModel = GameplayViewModel()
    @StateObject private var highlightViewModel = HighlightViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.boardBackground
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        Button {
                            viewModel.refreshLevel()
                        } label: {
                            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                                .resizable()
                                .frame(width: 42, height: 35)
                                .rotationEffect(.degrees(viewModel.rotationAngle))
                        }
                        .showCase(
                            order: OnboardingShowcase.refresh.index,
                            title: OnboardingShowcase.refresh.title,
                            detail: OnboardingShowcase.refresh.detail,
                            stage: HighlightStage.onboarding.stringValue
                        )
                        
                        Spacer()
                        
                        Button {
                            viewModel.isSettingOpen = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                        .showCase(
                            order: OnboardingShowcase.settings.index,
                            title: OnboardingShowcase.settings.title,
                            detail: OnboardingShowcase.settings.detail,
                            stage: HighlightStage.onboarding.stringValue
                        )
                    }
                    .padding([.horizontal, .top])
                    
                    Text("Level \(viewModel.level)")
                        .showCase(
                            order: OnboardingShowcase.level.index,
                            title: OnboardingShowcase.level.title,
                            detail: OnboardingShowcase.level.detail,
                            stage: HighlightStage.onboarding.stringValue
                        )
                        .font(.chalkboard(.title1))
                }
                
                if !HighlightStage.allCases.contains(where: { $0.stringValue == highlightViewModel.stage })  {
                    CardCombinationView(patternData: viewModel.patterns, time: viewModel.time) {
                        viewModel.isAnimationRunning = false
                    }
                    .id(viewModel.cardViewID)
                } else {
                    CardView(backRotation: 90, returnRotation: 0, isFlipped: false)
                        .showCase(
                            order: OnboardingShowcase.patternCard.index,
                            title: OnboardingShowcase.patternCard.title,
                            detail: OnboardingShowcase.patternCard.detail,
                            stage: HighlightStage.onboarding.stringValue
                        )
                }
                
                Spacer()
                
                if viewModel.patterns.firstIndex(where: { !$0.isUnlocked }) != nil {
                    Text("Pattern:")
                        .font(.chalkboard(.title1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    PatternInputView(
                        requiredPattern: viewModel.patterns,
                        adjustHeight: 62.5
                    ) { status, pattern in
                        if status {
                            withAnimation(.spring(response: 0.45)) {
                                if let matchedIndex = viewModel.patterns.firstIndex(where: { $0.path == pattern || $0.path.reversed() == pattern }) {
                                    viewModel.patterns[matchedIndex].isUnlocked = true
                                }
                            }
                        }
                    }
                    .frame(width: 250)
                    .disabled(viewModel.isAnimationRunning)
                    .showCase(
                        order: OnboardingShowcase.patternInput.index,
                        title: OnboardingShowcase.patternInput.title,
                        detail: OnboardingShowcase.patternInput.detail,
                        stage: HighlightStage.onboarding.stringValue
                    )
                } else {
                    PlayButton(title: "NEXT LEVEL") {
                        viewModel.goToNextLevel()
                        viewModel.loadLevel()
                    }
                    .padding(.bottom, 40)
                }
            }
            .foregroundStyle(.chalkboard)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if viewModel.level == 0 {
                    highlightViewModel.stage = HighlightStage.onboarding.stringValue
                }
                
                viewModel.loadLevel()
            }
        }
        .navigationBarBackButtonHidden(true)
        .modifier(HighlightHelperView(viewModel: highlightViewModel))
        .overlay {
            if viewModel.isSettingOpen {
                overlayView(
                    title: "Game Paused!",
                    buttons: [
                        OverlayButtonData(label: "Restart Level", action: {
                            viewModel.isSettingOpen = false
                            viewModel.resetLevel()
                        }),
                        OverlayButtonData(label: "Continue", action: {
                            viewModel.isSettingOpen = false
                            
                            if !viewModel.patterns.allSatisfy({ $0.isUnlocked }) {
                                viewModel.loadLevel()
                            }
                        }),
                        OverlayButtonData(label: "Exit", action: {
                            if viewModel.patterns.allSatisfy({ $0.isUnlocked }) {
                                viewModel.goToNextLevel()
                            }
                            
                            dismiss()
                        })
                    ]
                )
            }
        }
        .overlay {
            if highlightViewModel.stage == HighlightStage.isDone.stringValue {
                overlayView(
                    title: "Ready To Play?",
                    buttons: [
                        OverlayButtonData(label: "I'm Ready!", action: {
                            withAnimation(.easeInOut) {
                                highlightViewModel.stage = ""
                            }
                        })
                    ]
                )
            }
        }
    }
}

#Preview {
    GameplayView()
}
