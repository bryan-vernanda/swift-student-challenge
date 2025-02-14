//
//  CreditView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 07/02/25.
//

import SwiftUI

struct CreditView: View {
    @StateObject private var viewModel = CreditViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.boardBackground
                .ignoresSafeArea()
            
            ForEach(Array(viewModel.patterns.enumerated()), id: \.1.id) { index, pattern in
                let item: PatternPositionProtocol = viewModel.checkIsIpad()
                ? CreditPatternIpadPosition.allCases[index % CreditPatternIpadPosition.allCases.count]
                : CreditPatternIphonePosition.allCases[index % CreditPatternIphonePosition.allCases.count]
                
                ZStack {
                    PatternInputView(
                        requiredPattern: [pattern],
                        isReadOnly: true,
                        adjustCircleFrame: item.circleFrame,
                        adjustLineWidth: item.lineWidth,
                        adjustHeight: item.height
                    )
                    .frame(width: item.frameWidth)
                    .rotationEffect(.degrees(item.rotationEffect))

                    Button {
                        viewModel.regeneratePattern(at: index)
                    } label: {
                        Rectangle()
                            .frame(width: item.overlayAdjust, height: item.overlayAdjust)
                            .foregroundColor(.clear)
                            .contentShape(Rectangle())
                            .rotationEffect(.degrees(item.rotationEffect))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .padding(.bottom, item.paddingBottom)
                .padding(.leading, item.paddingLeading)
            }
            
            VStack(spacing: 0) {
                Button {
                    SoundFXManager.playSound(soundFX: SoundFX.click)
                    
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: viewModel.checkIsIpad() ? 32 : 20, height: viewModel.checkIsIpad() ? 48 : 30)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("CREDITS")
                    .font(.chalkboard(fontSize: viewModel.checkIsIpad() ? 64 : 42.667))
                    .padding(.bottom, 24)
                
                VStack(spacing: 8) {
                    Text("Sound Effects:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    ForEach(CreditType.allCases, id: \.self) { creditType in
                        ForEach(Array(zip(creditType.items.indices, zip(creditType.items, creditType.itemDetails))), id: \.0) { index, pair in
                            let (item, detail) = pair
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(index + 1). \(item)")
                                
                                Link(destination: URL(string: detail)!) {
                                    Text(detail)
                                        .underline()
                                        .foregroundStyle(.blue)
                                        .padding(.leading, viewModel.checkIsIpad() ? 40 : 24)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.chalkboard(fontSize: viewModel.checkIsIpad() ? 27 : 18))
                        }
                    }
                }
                .font(.chalkboard(viewModel.checkIsIpad() ? .title1 : .title3))
            }
            .foregroundStyle(.chalkboard)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, viewModel.checkIsIpad() ? 40 : 16)
            .padding(.top, 16)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.refreshPattern()
        }
    }
}

#Preview {
    CreditView()
}
