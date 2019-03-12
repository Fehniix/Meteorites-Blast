//
//  SoundController.swift
//  Meteorite Blast
//
//  Created by Mirko Mataluni on 11/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import AVFoundation

class SoundController {
    var clipname: String?
    var fileType: String?
    var volume: Float?
    var audioSource: AVAudioPlayer?
    
    init(clipname: String, fileType: String, volume: Float) {
        self.clipname = clipname
        self.fileType = fileType
        self.volume = volume
    }
    
    // Main function to play our audio files
    func playSound() {
        let path = Bundle.main.path(forResource: self.clipname, ofType: self.fileType)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioSource = try AVAudioPlayer(contentsOf: url)
            audioSource?.volume = self.volume!
            audioSource?.play()
            
            if clipname == "backgroundMusic" {
                audioSource?.numberOfLoops = -1
            }
        } catch {
            
        }
    }
    
    // We can stop file audio with this
    func stopSound(){
        audioSource?.stop()
    }
    
}
