//
//  CreditView.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 07/02/25.
//

import SwiftUI

struct CreditView: View {
    let deviceType = UIDevice.current.userInterfaceIdiom
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.boardBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Button {
                    SoundFXManager.playSound(soundFX: SoundFX.click)
                    
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .frame(width: deviceType == .pad ? 56 : 35, height: deviceType == .pad ? 56 : 35)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("CREDITS")
                    .font(deviceType == .pad ? .chalkboard(fontSize: 64): .chalkboard(.XXLTitle))
                    .padding(.bottom, 24)
                
                VStack(spacing: 8) {
                    Text("Sound Effects:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                    
                    ForEach(CreditType.allCases, id: \.self) { creditType in
                        ForEach(Array(zip(creditType.items.indices, zip(creditType.items, creditType.itemDetails))), id: \.0) { index, pair in
                            let (item, detail) = pair
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(index + 1). \(item)")
                                
                                Link(destination: URL(string: detail)!) {
                                    Text(detail)
                                        .underline()
                                        .foregroundStyle(.blue)
                                        .padding(.leading, deviceType == .pad ? 40 : 24)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(deviceType == .pad ? .chalkboard(fontSize: 30) : .chalkboard(fontSize: 18))
                        }
                    }
                }
                .font(.chalkboard(deviceType == .pad ? .title1 : .title3))
            }
            .foregroundStyle(.chalkboard)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, deviceType == .pad ? 40 : 16)
            .padding(.top, 16)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CreditView()
}
