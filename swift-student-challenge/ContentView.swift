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

struct PatternInputView: View {
    // Configuration
    var outerCircleColor: Color = .black // outer circle color of each pattern dot
    var lineColor: Color = .white // line color for drawn pattern
    var skipVerification: Bool = false // flag to disable pattern verification
    var requiredPattern: [PatternSymbol] // required Pattern to unlock
    var onPatternComplete: ((Bool, [PatternSymbol]) -> ())? = nil // completion handler for pattern input
    var isReadOnly: Bool = false // New property to control read-only mode
    var adjustHeight: CGFloat = 100
    
    // view properties
    @State private var availableDots: [PatternNode] = (1...9).compactMap({return PatternNode(number: $0)}) // All pattern dots
    @State private var currentDragLocation: CGPoint = .zero // the current dragging location
    @State private var activePattern: [PatternNode] = [] // the dots connected in the active pattern
    @State private var displayError: Bool = false // trigger to display incorrect pattern animation
    
    var body: some View {
        PatternGridView()
            .background {
                let points = activePattern.map({
                    let frame = $0.dotFrame
                    return CGPoint(x: frame.midX, y: frame.midY)
                })
                ZStack {
                    if !points.isEmpty {
                        PatternDrawingPath(points: points, currentLocation: currentDragLocation)
                            .stroke(
                                displayError ? .red : lineColor,
                                style: StrokeStyle(
                                    lineWidth: 5, lineCap: .round, lineJoin: .round
                                )
                            )
                            .transition(.opacity)
                    }
                }
                .animation(.easeInOut(duration: 0.4), value: points)
            }
            .shakeEffect(trigger: displayError, distance: 10) // default 20
            .onAppear {
                if isReadOnly {
                    // Pre-fill the activePattern with the required pattern
                    activePattern = requiredPattern.compactMap { symbol in
                        availableDots.first { $0.number == symbol.rawValue }
                    }
                }
            }
    }
    //PatternGridView: the view containing the pattern grid dots
    @ViewBuilder
    private func PatternGridView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
            ForEach($availableDots) { $dot in
                GeometryReader { geometry in
                    let frame = geometry.frame(in: .named("PATTERN_GRID"))
                    Circle()
                        .fill(outerCircleColor)
                        .frame(width: 20, height: 20)
                        .overlay {
                            Circle()
                                .fill(displayError ? .red: lineColor)
                                .frame(width: 10, height: 10)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .preference(key: DotFrameKey.self, value: frame)
                        .onPreferenceChange(DotFrameKey.self) {
                            dot.dotFrame = $0
                        }
                }
                .padding(.horizontal, 15) // padding to adjust touch sensitivity
                .frame(height: adjustHeight)
            }
        }
        .frame(height: adjustHeight * 3)
        .frame(maxWidth: 400)
        .padding(.horizontal, 20)
        .coordinateSpace(.named("PATTERN_GRID"))
        .animation(.easeInOut(duration: 0.4), value: displayError)
        .contentShape(.rect)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    let location = gesture.location
                    if let dot = availableDots.first(where: { dot in
                        let center = CGPoint(x: dot.dotFrame.midX, y: dot.dotFrame.midY)
                        return distance(from: location, to: center) < 15 // Adjust hit radius for precision
                    }), !activePattern.contains(where: { $0.id == dot.id }) {
                        activePattern.append(dot)
                    }
                    currentDragLocation = location
                }
                .onEnded { gesture in
                    guard !isReadOnly else { return }
                    currentDragLocation = .zero
                    guard !activePattern.isEmpty else { return }
                    let enteredPattern = activePattern.map({
                        PatternSymbol(rawValue: $0.number)
                    }).compactMap {
                        $0
                    } //ensure non-optional pattern
                    if skipVerification {
                        activePattern = []
                        onPatternComplete?(false, enteredPattern)
                    } else {
                        if enteredPattern == requiredPattern {
                            activePattern = []
                            onPatternComplete?(true, enteredPattern)
                        } else {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                displayError = true
                            } completion: {
                                displayError = false
                                activePattern = []
                                onPatternComplete?(false, enteredPattern)
                            }
                        }
                    }
                }
        )
        .disabled(displayError || isReadOnly)
    }
    
    // Pattern node : represent each dot in the pattern grid
    private struct PatternNode: Identifiable {
        let id: UUID = UUID() // Unique identifier for each dot
        var number: Int // The number representing the dot
        var dotFrame: CGRect = .zero // the frame of the dot for detecting touches
    }
    
    private func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2))
    }

    // DotFrameKey: A preference key to store each dot's frame
    private struct DotFrameKey: PreferenceKey {
        static var defaultValue: CGRect = .zero
        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
    }
    
    // PatternDrawingPath: A shape to draw the path of the pattern
    private struct PatternDrawingPath: Shape {
        var points: [CGPoint] // the point of the connected pattern
        var currentLocation: CGPoint // the current drag location
        func path(in rect: CGRect) -> Path {
            var path = Path()
            for (index, point) in points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            if currentLocation != .zero {
                path.addLine(to: currentLocation)
            }
            return path
        }
    }

}

// PatternSymbol: Represent the numbers in the pattern code (1-9)
enum PatternSymbol: Int {
    case one = 1, two, three, four, five, six, seven, eight, nine
}

extension View {
    // Custom shake effect for wrong patterns
    func shakeEffect(trigger: Bool, distance: CGFloat) -> some View {
        modifier(ShakeEffect(trigger: trigger, distance: distance))
    }
}

struct ShakeEffect: ViewModifier, Animatable {
    var trigger: Bool
    var distance: CGFloat
    var animatableData: CGFloat

    func body(content: Content) -> some View {
        content
            .offset(x: trigger ? sin(animatableData * .pi * 2) * distance : 0)
    }

    init(trigger: Bool, distance: CGFloat) {
        self.trigger = trigger
        self.distance = distance
        self.animatableData = trigger ? 1 : 0
    }
}

extension View {
    func shake(trigger: Bool, distance: CGFloat = 5) -> some View {
        self.modifier(ShakeEffect(trigger: trigger, distance: distance))
            .animation(.default.repeatCount(3, autoreverses: true), value: trigger)
    }
}

struct PatternData: Identifiable {
    let id: UUID = UUID()
    var path: [PatternSymbol]
    var isUnlocked: Bool = false
}
