//
//  HanvestSoundFXManager.swift
//  hanvest
//
//  Created by Bryan Vernanda on  01/29/25.
//

import AVFoundation

struct SoundFXManager {
    private static var audioPlayers: [String: AVAudioPlayer] = [:]
    
    static func playSound(soundFX: SoundFX) {
        guard let url = Bundle.main.url(forResource: soundFX.name, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.volume = 0.25
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            
            audioPlayers[soundFX.name] = audioPlayer
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

