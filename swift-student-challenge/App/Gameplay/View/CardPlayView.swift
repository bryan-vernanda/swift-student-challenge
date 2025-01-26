//
//  CardPlayView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

struct CardPlayView: View {
    @StateObject private var viewModel = CardPlayViewModel()
    @StateObject private var highlightViewModel = HighlightViewModel()
    @EnvironmentObject var navManager: NavigationManager
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            viewModel.isSettingOpen = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .showCase(
                            order: OnboardingShowcase.settings.index,
                            title: OnboardingShowcase.settings.title,
                            detail: OnboardingShowcase.settings.detail,
                            stage: HighlightStage.onboarding.stringValue
                        )
                    }
                    .padding([.trailing, .top], 16)
                    
                    Text("Level: \(viewModel.level)")
                        .showCase(
                            order: OnboardingShowcase.level.index,
                            title: OnboardingShowcase.level.title,
                            detail: OnboardingShowcase.level.detail,
                            stage: HighlightStage.onboarding.stringValue
                        )
                }
                .foregroundStyle(.white)
                
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
                    
                    Spacer()
                }
                
                if let index = viewModel.patterns.firstIndex(where: { !$0.isUnlocked }) {
                    PatternInputView(
                        requiredPattern: viewModel.patterns[index].path
                    ) { status, pattern in
                        if status {
                            withAnimation(.spring(response: 0.45)) {
                                viewModel.patterns[index].isUnlocked = true
                            }
                        }
                    }
                    .disabled(viewModel.isAnimationRunning)
                    .showCase(
                        order: OnboardingShowcase.patternInput.index,
                        title: OnboardingShowcase.patternInput.title,
                        detail: OnboardingShowcase.patternInput.detail,
                        stage: HighlightStage.onboarding.stringValue
                    )
                } else {
                    Button(action: {
                        viewModel.goToNextLevel()
                        viewModel.loadLevel()
                    }) {
                        Text("Next Level")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .onAppear {
            if viewModel.level == 0 {
                highlightViewModel.stage = HighlightStage.onboarding.stringValue
            }
            
            viewModel.loadLevel()
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
                            
                            navManager.currentView = .home
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
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    highlightViewModel.stage = ""
                                }
                            }
                        })
                    ]
                )
            }
        }
    }
}

#Preview {
    MainView()
}
