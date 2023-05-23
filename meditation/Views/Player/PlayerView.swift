//
//  PlayerView.swift
//  meditation
//
//  Created by Sergio Veliz on 22.05.2023.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var audiosettings = AudioPlayerSettings()
    @State private var playerPaused = true
    
    var body: some View {
        VStack(spacing: 16) {
            Image("album_cover")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            
            Text("Purnamadah")
                .font(.headline)
                .padding(.top, 8)
            
            Text("By: Tribu-Tulum")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            audioPlayerView()
            
        }
        .padding()
    }
    
    
    private func audioPlayerView() -> some View {
        VStack {
            Slider(value: $audiosettings.playValue,
                   in: TimeInterval(0.0)...(audiosettings.audioPlayer?.duration ?? 0.0),
                   onEditingChanged: { _ in
                self.audiosettings.changeSliderValue()
            })
            .foregroundColor(Color.white.opacity(0.16))
            .accentColor(Color.blue)
            .frame(width: 350, alignment: .center)
            .onReceive(audiosettings.timer) { _ in
                
                if self.audiosettings.playing {
                    if let currentTime = self.audiosettings.audioPlayer?.currentTime {
                        self.audiosettings.playValue = currentTime
                        
                        if currentTime == TimeInterval(0.0) {
                            self.audiosettings.playing = false
                            togglePlayPause()
                        }
                    }
                } else {
                    self.audiosettings.playing = false
                    self.audiosettings.timer.upstream.connect().cancel()
                }
            }
            
            HStack(spacing: 20) {
                Button(action: {
                    // Handle "List Songs" button action
                }) {
                    Image(systemName: "list.bullet")
                }
                
                Button(action: {
                    // Handle "Previous" button action
                }) {
                    Image(systemName: "backward.end.fill")
                }
                
                Button(action: togglePlayPause) {
                    HStack {
                        Image(systemName: playerPaused ? "play.fill" : "pause.fill")//.foregroundColor(.black)
                    }
                    .padding(15.0)
                    .font(.title)
                    .overlay(
                        Circle()
                            .stroke(lineWidth: 2.0)
                            .foregroundColor(Color.blue)
                    )
                } // Button play/pause
                
                Button(action: {
                    // Handle "Next" button action
                }) {
                    Image(systemName: "forward.end.fill")
                }
                
                Button(action: {
                    // Handle "Repeat Song" button action
                }) {
                    Image(systemName: "repeat")
                }
            }
            .font(.title)
            .padding(.top, 16)
        }
        .cornerRadius(15)
    }
    
    private func togglePlayPause() {
        pausePlayer(!playerPaused)
    }
    
    private func pausePlayer(_ pause: Bool) {
        playerPaused = pause
        if playerPaused {
            self.audiosettings.pauseSound()
        } else {
            self.audiosettings.playSound(sound: "Tribu-Tulum-Purnamadah", type: "wav")
            self.audiosettings.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
