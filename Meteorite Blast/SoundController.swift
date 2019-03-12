//
//  SoundController.swift
//  Meteorite Blast
//
//  Created by Mirko Mataluni on 11/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import AVFoundation

class SoundController {
    
    //  Private shared methods.
    private var clipname: String?
    private var fileType: String?
    private var volume: Float?
    private var audioSource: AVAudioPlayer?
    
    init(clipname: String, fileType: String, volume: Float) {
        self.clipname = clipname
        self.fileType = fileType
        self.volume = volume
    }
    
    /// Play sound.
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
        } catch {}
        
    }
    
    /// Stops sound.
    func stopSound(){
        audioSource?.stop()
    }
    
}
