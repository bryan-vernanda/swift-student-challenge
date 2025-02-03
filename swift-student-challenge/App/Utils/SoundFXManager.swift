//
//  HanvestSoundFXManager.swift
//  hanvest
//
//  Created by Bryan Vernanda on  01/29/25.
//

import Foundation
import AVKit

//struct SoundFXManager {
//    private static var audioPlayer: AVAudioPlayer?
//    
//    static func playSound(soundFX: HanvestSoundFX) {
//        guard let url = Bundle.main.url(forResource: soundFX.name, withExtension: "mp3") else {
//            print("Sound file not found")
//            return
//        }
//        
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.volume = soundFX.volume
//            audioPlayer?.prepareToPlay()
//            audioPlayer?.play()
//        } catch {
//            print("Error playing sound: \(error.localizedDescription)")
//        }
//    }
//    
//}
