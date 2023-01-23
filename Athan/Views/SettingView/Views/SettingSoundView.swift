//
//  SoundNotificationSetting.swift
//  Athan
//
//  Created by Khalid Alhazmi on 21/01/2023.
//

import AVFoundation
import AVKit
import SwiftUI

struct SettingSoundView: View {
    @EnvironmentObject var env: EnvViewModel
    @State var player: AVAudioPlayer?

    init() {
        if #unavailable(iOS 16.0) {
            UITableView.appearance().backgroundColor = .clear
        }

        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    var body: some View {
        List {
            Group {
                ForEach(CustomNotificationSound.allCases) { audio in
                    Button {
                        if let player, player.isPlaying {
                            player.stop()
                        }
                        guard let url = audio.urlPath else { return }
                        env.audioName = audio
                        do {
                            player = try AVAudioPlayer(contentsOf: url)
                            player?.prepareToPlay()
                            player?.play()

                        } catch {
                            print(error.localizedDescription)
                        }

                    } label: {
                        HStack {
                            Text(audio.localizedStringKey)

                            Spacer()
                            if env.audioName == audio {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .listRowSeparatorTint(.white.opacity(0.3))
            .listRowBackground(AppColors.SettinglistRowBackground)
        }
        .clearListBackground()
        .foregroundColor(.white)
        .padding(.top, 1)
        .navigationTitle("Notifications")
        .toolbar {
            ToolbarItem(placement: .principal) {
                LogoTextStyleView("Notifications")
            }
        }
        .background(AppColors.SettingBackgroundColor.ignoresSafeArea())
        .onDisappear {
            if let player, player.isPlaying {
                player.stop()
            }
        }
    }
}
