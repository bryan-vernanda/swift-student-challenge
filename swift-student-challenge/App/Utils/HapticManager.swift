//
//  HanvestHapticManager.swift
//  hanvest
//
//  Created by Bryan Vernanda on 01/29/25.
//

import SwiftUI

struct HapticManager {
    static func notif(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}
