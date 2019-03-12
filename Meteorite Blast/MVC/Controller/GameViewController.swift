//
//  GameViewController.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 07/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

//  This is the application entrypoint.
//  The main SKScene GameScene gets created here and bound to the view.

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: view.bounds.size)
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
        
            // Present the scene
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
        }
    }
    
}
