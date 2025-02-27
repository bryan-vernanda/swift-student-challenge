//
//  HighlightHelperView.swift
//  swift-student-challenge
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
        cornerRadius: CGFloat = 10.0,
        style: RoundedCornerStyle = .continuous,
        scale: CGFloat = 1.0,
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
                     if !newValue {
                         viewModel.updateCurrentHighlight()
                     }
                 }
             
             Rectangle()
                 .foregroundStyle(.clear)
                 .frame(
                    width: highlightRect.width + 20,
                    height: highlightRect.height + 20
                 )
                 .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                 .popover(
                    isPresented: $viewModel.showTitle
                 ) {
                     VStack(alignment: .leading, spacing: UIDevice.current.userInterfaceIdiom == .pad ? 9.6 : 6) {
                         Text(highlight.title)
                             .font(.chalkboard(fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 27.2 : 17))
                             .fontWeight(.bold)
                         
                         Text(highlight.detail)
                             .font(.chalkboard(fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 22.4 : 14, .regular))
                             .lineLimit(nil)
                             .fixedSize(horizontal: false, vertical: true)
                     }
                     .padding(UIDevice.current.userInterfaceIdiom == .pad ? 38.4 : 24)
                     .frame(maxWidth: UIDevice.current.userInterfaceIdiom == .pad ? 440 : 275, alignment: .leading)
                     .multilineTextAlignment(.leading)
                     .foregroundStyle(.textBlack)
                     .background(.chalkboard)
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

extension View {
    /// Applies a modifier conditionally.
    @ViewBuilder
    func modifierIf<T: ViewModifier>(_ condition: Bool, _ modifier: T) -> some View {
        if condition {
            self.modifier(modifier)
        } else {
            self
        }
    }
}
