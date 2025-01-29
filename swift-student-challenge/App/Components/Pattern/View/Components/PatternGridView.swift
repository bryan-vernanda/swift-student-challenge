//
//  PatternGridView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 20/01/25.
//

import SwiftUI

extension PatternInputView {
    //PatternGridView: the view containing the pattern grid dots
    @ViewBuilder
    func PatternGridView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 3), spacing: 0) {
            ForEach($availableDots) { $dot in
                GeometryReader { geometry in
                    let frame = geometry.frame(in: .named("PATTERN_GRID"))
                    Circle()
                        .fill(outerCircleColor)
                        .frame(width: 11, height: 11)
                        .overlay {
                            Circle()
                                .fill(displayError ? .red: lineColor)
                                .frame(width: 11, height: 11)
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
        .animation(.easeInOut, value: displayError)
        .contentShape(.rect)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    let location = gesture.location
                    if let dot = availableDots.first(where: { dot in
                        let center = CGPoint(x: dot.dotFrame.midX, y: dot.dotFrame.midY)
                        return distance(from: location, to: center) < 15
                    }) {
                        if let lastDot = activePattern.last, lastDot.id != dot.id {
                            // Add intermediate nodes between the last dot and the current dot
                            addIntermediateDots(from: lastDot, to: dot)
                        }
                        if !activePattern.contains(where: { $0.id == dot.id }) {
                            activePattern.append(dot)
                        }
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
                        let matchedPattern = requiredPattern.first { patternData in
                            enteredPattern == patternData.path || enteredPattern == patternData.path.reversed()
                        }
                        
                        if matchedPattern != nil {
                            activePattern = []
                            onPatternComplete?(true, enteredPattern)
                        } else {
                            withAnimation(.easeInOut) {
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
    
    func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2))
    }
    
    func addIntermediateDots(from start: PatternNode, to end: PatternNode) {
        // Determine the row and column for start and end dots
        let startRow = (start.number - 1) / 3
        let startCol = (start.number - 1) % 3
        let endRow = (end.number - 1) / 3
        let endCol = (end.number - 1) % 3

        // Check if the movement is diagonal, vertical, or horizontal
        if abs(startRow - endRow) == abs(startCol - endCol) || startRow == endRow || startCol == endCol {
            // Calculate the step for rows and columns
            let rowStep = (endRow - startRow).signum()
            let colStep = (endCol - startCol).signum()

            // Iterate through the intermediate nodes
            var currentRow = startRow + rowStep
            var currentCol = startCol + colStep
            while currentRow != endRow || currentCol != endCol {
                let intermediateNumber = currentRow * 3 + currentCol + 1
                if let intermediateDot = availableDots.first(where: { $0.number == intermediateNumber }),
                   !activePattern.contains(where: { $0.id == intermediateDot.id }) {
                    activePattern.append(intermediateDot)
                }
                currentRow += rowStep
                currentCol += colStep
            }
        }
    }
}
