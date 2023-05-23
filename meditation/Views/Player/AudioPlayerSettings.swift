//
//  AudioPlayerSettings.swift
//  meditation
//
//  Created by Sergio Veliz on 22.05.2023.
//

import SwiftUI
import AVFoundation

/// Audio player settings observable
class AudioPlayerSettings: ObservableObject {

    /// Audio player
    var audioPlayer: AVAudioPlayer?
    /// Is playing
    var playing = false
    /// Time play value
    @Published var playValue: TimeInterval = 0.0
    /// Timer
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    /// Play sound from bundle file
    /// - Parameters:
    ///   - sound: File name
    ///   - type: File type
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                if !playing {
                    if audioPlayer == nil {

                        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                        audioPlayer?.prepareToPlay()

                        audioPlayer?.play()
                        playing = true
                    }
                }
                if !playing {

                    audioPlayer?.play()
                    playing = true
                }
            } catch {
                debugPrint("Could not find and play the sound file.")
            }
        }
    }

    /// Pause sound
    func pauseSound() {
        if playing {
            audioPlayer?.pause()
            playing = false
        }
    }

    /// Change slider value
    func changeSliderValue() {
        if playing {
            pauseSound()
            audioPlayer?.currentTime = playValue
        }

        if !playing {
            audioPlayer?.play()
            playing = true
        }
    }
}
