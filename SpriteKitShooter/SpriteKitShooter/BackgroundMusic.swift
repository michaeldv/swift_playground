//
//  BackgroundMusic.swift
//  SpriteKitShooter
//
//  Created by Michael Dvorkin on 1/9/15.
//  Copyright (c) 2015 Michael Dvorkin. All rights reserved.
//

import AVFoundation

var musicPlayer: AVAudioPlayer?

func playMusic(filename: String) {
    let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
    if url != nil {
        var error: NSError? = nil
        musicPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        if musicPlayer != nil {
            musicPlayer!.numberOfLoops = -1
            musicPlayer!.prepareToPlay()
            musicPlayer!.play()
        }
    }
}
