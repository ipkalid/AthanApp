//
//  SoundManager.swift
//  Athan
//
//  Created by Khalid Alhazmi on 20/10/2021.
//

import AVKit
import Foundation

class SoundManager {
    static let instance = SoundManager()

    var player: AVAudioPlayer?

    func playSound() {
        guard let url = URL(string: "") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            debugPrint("Error: " + error.localizedDescription)
        }
    }

    // func playSound
}
