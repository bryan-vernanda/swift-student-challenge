//
//  CreditType.swift
//  swift-student-challenge
//
//  Created by Bryan Vernanda on 07/02/25.
//

enum CreditType: CaseIterable {
    case soundEffects
    
    var items: [String] {
        switch self {
            case .soundEffects:
                return [
                    "Tap button",
                    "Flipping card",
                    "Level up"
                ]
        }
    }
    
    var itemDetails: [String] {
        switch self {
            case .soundEffects:
                return [
                    "https://pixabay.com/sound-effects/happy-pop-2-185287/",
                    "https://pixabay.com/sound-effects/flipcard-91468/",
                    "https://pixabay.com/sound-effects/level-up-289723/"
                ]
        }
    }
}
