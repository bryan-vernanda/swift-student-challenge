//
//  MainView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

struct CardPlayView: View {
    @StateObject private var viewModel = CardPlayViewModel()
    @Environment(\.dismiss) private var dismiss
    
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
                    }
                    .padding([.trailing, .top], 16)
                    
                    Text("Level: \(viewModel.level)")
                }
                .foregroundStyle(.white)
                
                CardCombinationView(patternData: viewModel.patterns, time: viewModel.time) {
                    viewModel.isAnimationRunning = false
                }
                .id("CardCombinationView-\(viewModel.level)")
                
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
                } else {
                    Button(action: {
                        viewModel.goToNextLevel()
                        viewModel.isAnimationRunning = true
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
            viewModel.loadLevel()
        }
        .navigationBarBackButtonHidden(true)
        .overlay {
            if viewModel.isSettingOpen {
                GeometryReader { _ in
                    Rectangle()
                        .fill(.black)
                        .opacity(0.7)
                        .ignoresSafeArea()
                    
                    // Card-like background with VStack content
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.orange)
                            .background(.black)
                            .frame(width: 275, height: 275)
                        
                        VStack {
                            Text("Game Paused!")
                                .font(.title2)
                                .padding(.bottom)
                            
                            Button(action: {
                                viewModel.isSettingOpen = false
                                viewModel.resetLevel()
                            }) {
                                Text("Restart Level")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                viewModel.isSettingOpen = false
                                viewModel.loadLevel()
                            }) {
                                Text("Continue")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                dismiss()
                            }) {
                                Text("Exit")
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 250)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    CardPlayView()
}
