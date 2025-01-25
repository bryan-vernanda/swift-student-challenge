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
    }
}

#Preview {
    HomeView()
}


