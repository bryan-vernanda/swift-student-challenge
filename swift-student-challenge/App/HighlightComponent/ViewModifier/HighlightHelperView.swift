//
//  HighlightHelper.swift
//  hanvest
//
//  Created by Bryan Vernanda on 21/01/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func showCase(
        order: Int,
        title: String,
        detail: String,
        cornerRadius: CGFloat = 10,
        style: RoundedCornerStyle = .continuous,
        scale: CGFloat = 1,
        stage: String
    ) -> some View {
        self
        /// storing it in Anchor Preference
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = HighlightModel(anchor: anchor, title: title, detail: detail, cornerRadius: cornerRadius, style: style, scale: scale, stage: stage)
                return [order: highlight]
            }
    }
}

/// showcase root view modifier
struct HighlightHelperView: ViewModifier {
    /// view model
    @ObservedObject var viewModel: HighlightViewModel
    
    /// Namespace ID, for smooth shape transitions (must be attached to view directly)
    @Namespace private var animation
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                viewModel.updateHighlightOrderIfNeeded(from: value)
            }
            .onChange(of: viewModel.stage) { _, newValue in
                // Reset showcase state when `changeShowState` updates
                viewModel.resetHighlightViewState()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if let highlight = viewModel.currentHighlightToShow(from: preferences) {
                    HighlightView(highlight)
                }
            }
    }
    
    @ViewBuilder
     func HighlightView(_ highlight: HighlightModel) -> some View {
         GeometryReader { proxy in
             let highlightRect = proxy[highlight.anchor]
             let safeArea = proxy.safeAreaInsets
             let screenHeight = UIScreen.main.bounds.height
             
             Rectangle()
                 .fill(.black.opacity(0.5))
                 .reverseMask {
                     Rectangle()
                         .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
                         .frame(width: highlightRect.width + 5, height: highlightRect.height + 5)
                         .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                         .scaleEffect(highlight.scale)
                         .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
                 }
                 .ignoresSafeArea()
                 .onChange(of: viewModel.showTitle) { _, newValue in
                     if newValue {
                         viewModel.setNewPopUpPosition(highlightRect: highlightRect, screenHeight: screenHeight)
                     } else {
                         viewModel.updateCurrentHighlight()
                     }
                 }
                 .onAppear {
                     viewModel.setNewPopUpPosition(highlightRect: highlightRect, screenHeight: screenHeight)
                 }
             
             Rectangle()
                 .foregroundColor(.clear)
                 .frame(
                    width: highlightRect.width + (viewModel.isItemCoverThreeQuarterScreen ? 5 : 20),
                    height: highlightRect.height + (viewModel.isItemCoverThreeQuarterScreen ? 5 : 20)
                 )
                 .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                 .popover(
                    isPresented: $viewModel.showTitle,
                    attachmentAnchor: viewModel.getPopoverAttachmentAnchorPosition(),
                    arrowEdge: viewModel.getPopoverArrowEdge()
                 ) {
                     VStack(alignment: .leading, spacing: 8) {
                         Text(highlight.title)
                             .font(.body)
                             .fontWeight(.bold)
                             .accessibilityElement(children: .ignore)
                             .accessibilityLabel("\(highlight.title) popover")
                         
                         Text(highlight.detail)
                             .font(.subheadline)
                             .lineLimit(nil)
                             .fixedSize(horizontal: false, vertical: true)
                             .accessibilityElement(children: .ignore)
                             .accessibilityLabel("\(highlight.detail) popover")
                     }
                     .padding(16)
                     .frame(maxWidth: 277, alignment: .leading)
                     .multilineTextAlignment(.leading)
                     .presentationCompactAdaptation(.popover)
                 }
                 .scaleEffect(highlight.scale)
                 .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
         }
    }
}

/// custom view modifier for inner/reverse mask
extension View {
    @ViewBuilder
    func reverseMask<Content: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content)
    -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}
