//
//  ShowCaseRootViewModel.swift
//  hanvest
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

class HighlightViewModel: ObservableObject {
    /// View properties
    @Published var stage: String
    @Published var highlightOrder: [Int]
    @Published var showView: Bool
    @Published var currentHighlight: Int
    /// popover
    @Published var showTitle: Bool
    @Published var isItemInUpperScreenPart: Bool
    @Published var isItemCoverThreeQuarterScreen: Bool
    
    init() {
        self.stage = ""
        self.highlightOrder = []
        self.showView = true
        self.currentHighlight = 0
        self.showTitle = true
        self.isItemInUpperScreenPart = true
        self.isItemCoverThreeQuarterScreen = true
    }
    
    func resetCurrectHighlightValue() {
        currentHighlight = 0
    }
    
    func markStageStringValue() {
        withAnimation(.easeInOut) {
            self.stage = HighlightStage.isDone.stringValue
        }
    }
    
    func resetHighlightViewState() {
        resetCurrectHighlightValue()
        showView = true
        showTitle = true
    }
    
    func setNewPopUpPosition(highlightRect: CGRect, screenHeight: CGFloat) {
        isItemInUpperScreenPart = highlightRect.midY < screenHeight / 2
        isItemCoverThreeQuarterScreen = highlightRect.height > (screenHeight * 7 / 10)
//        debugPrint("\(highlightRect.height), \(screenHeight)")
    }
    
    func updateHighlightOrderIfNeeded(from preferences: [Int: HighlightModel]) {
        // Filter and sort highlights based on the current stage
        let newHighlightOrder = preferences
            .filter { $0.value.stage == stage }
            .map { $0.key }
            .sorted()
        
        // Update only if there's a difference
        if newHighlightOrder != highlightOrder {
            highlightOrder = newHighlightOrder
        }
    }
    
    func currentHighlightToShow(from preferences: [Int: HighlightModel]) -> HighlightModel? {
        guard highlightOrder.indices.contains(currentHighlight), showView else {
            return nil
        }
        return preferences[highlightOrder[currentHighlight]]
    }
    
    func updateCurrentHighlight() {
        if currentHighlight >= highlightOrder.count - 1 {
            withAnimation(.easeInOut) {
                showView = false
            }
            resetCurrectHighlightValue()
            markStageStringValue()
        } else {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                currentHighlight += 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.showTitle = true
            }
        }
    }
    
    func getPopoverAttachmentAnchorPosition() -> PopoverAttachmentAnchor {
        if isItemCoverThreeQuarterScreen || isItemInUpperScreenPart {
            return .point(.bottom)
        } else {
            return .point(.top)
        }
    }

    func getPopoverArrowEdge() -> Edge {
        if isItemCoverThreeQuarterScreen || !isItemInUpperScreenPart {
            return .bottom
        } else {
            return .top
        }
    }
    
}
