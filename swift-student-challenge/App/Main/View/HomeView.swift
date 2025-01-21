//
//  HomeView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 13/01/25.
//

import SwiftUI

struct HomeView: View {
//    @State private var patternData: [PatternData] = [
//        PatternData(path: [.three, .two, .four, .eight, .nine]),
//        PatternData(path: [.two, .three, .five, .nine, .eight]),
//        PatternData(path: [.three, .six, .nine, .eight, .seven])
//    ]
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    if viewModel.level == 0 {
                        Button(action: {
                            viewModel.isNavigate = true
                        }) {
                            Text("Play")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        Button(action: {
                            viewModel.isNavigate = true
                            viewModel.levelModel.resetLevel()
                        }) {
                            Text("New Game")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            viewModel.isNavigate = true
                        }) {
                            Text("Continue")
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
                viewModel.refreshLevel()
            }
            .navigationDestination(isPresented: $viewModel.isNavigate) {
                CardPlayView()
            }
        }
//        NavigationStack {
//            CardPlayView() // main home when unlocked
//        }
//        .overlay {
//            if let index = patternData.firstIndex(where: { !$0.isUnlocked }) {
//                GeometryReader { _ in
//                    Rectangle()
//                        .fill(.black)
//                        .ignoresSafeArea()
//                    VStack(spacing: 20) {
//                        Text("the pattern: \(index + 1)")
//                            .font(.largeTitle)
//                            .fontWidth(.condensed)
//                            .foregroundStyle(.white)
//                        Text("Draw the pattern to Unlock")
//                            .font(.largeTitle)
//                            .fontWidth(.condensed)
//                            .foregroundStyle(.white)
//                        PatternInputView(
//                            requiredPattern: patternData[index].path
//                        ) { status, pattern in
//                            if status {
//                                withAnimation(.spring(response: 0.45)) {
//                                    patternData[index].isUnlocked = true
//                                }
//                            }
//                        }
//                    }
//                    .frame(maxHeight: .infinity)
//                }
//                .transition(.slide)
//            }
//        }
    }
}

#Preview {
    HomeView()
}


