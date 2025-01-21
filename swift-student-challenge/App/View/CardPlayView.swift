//
//  MainView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

struct CardPlayView: View {
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            Text("Level: \(viewModel.level)")
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
        .background(.black)
        .onAppear {
            viewModel.resetLevel()
            viewModel.newLevelSetup()
        }
    }
}

//    .onChange(of: viewModel.patterns) { _,newValue in
//        if newValue.allSatisfy({ $0.isUnlocked }) {
//            viewModel.goToNextLevel()
//        }
//    }

#Preview {
    CardPlayView()
}
