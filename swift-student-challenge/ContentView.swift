//
//  ContentView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 13/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var patternData: [PatternData] = [
        PatternData(path: [.three, .two, .four, .eight, .nine]),
        PatternData(path: [.two, .three, .five, .nine, .eight]),
        PatternData(path: [.three, .six, .nine, .eight, .seven])
    ]
    
    var body: some View {
        NavigationStack {
            MainView() // main home when unlocked
        }
        .overlay {
            if let index = patternData.firstIndex(where: { !$0.isUnlocked }) {
                GeometryReader { _ in
                    Rectangle()
                        .fill(.black)
                        .ignoresSafeArea()
                    VStack(spacing: 20) {
                        Text("the pattern: \(index + 1)")
                            .font(.largeTitle)
                            .fontWidth(.condensed)
                            .foregroundStyle(.white)
                        Text("Draw the pattern to Unlock")
                            .font(.largeTitle)
                            .fontWidth(.condensed)
                            .foregroundStyle(.white)
                        PatternInputView(
                            requiredPattern: patternData[index].path
                        ) { status, pattern in
                            if status {
                                withAnimation(.spring(response: 0.45)) {
                                    patternData[index].isUnlocked = true
                                }
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                .transition(.slide)
            }
        }
    }
}

#Preview {
    ContentView()
}

struct MainView: View {
    var body: some View {
        Text("Welcome to Home View")
            .navigationTitle("Main Screen")
    }
}


