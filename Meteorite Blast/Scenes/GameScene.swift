//
//  GameScene.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 07/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit
import CoreMotion

///  Useful properties to be accessed elsewhere in the project
///  avoiding the need to pass redundant data.
var sceneFrame: CGRect?

class GameScene: SKScene {
    
    /// MotionManager object to handle motion sensors.
    var motionManager = CMMotionManager()
    
    //  Declaration of game nodes.
    var spaceship: SpaceshipNode!
    var pointsLabel: PointsNode!
    
    ///  Giving a convienience name to the SensorInput singleton instance.
    var sensorInput: SensorInput = SensorInput.shared
    
    /// Music object. Provides methods for handling background soundtrack.
    var music: SoundController?
    
    /// Music object. Provides methods for handling the shooting sound.
    var shootAudio: SoundController?
    
    //  Help: ⌥ + click
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        sceneFrame = frame
        
        setupBackground()
        setupScene()
        setupAudio()
        
        sensorInput.startUpdates()
        
    }
    
    /// Sets up the scene: instantiates nodes and adds children.
    private func setupScene() {
        
        spaceship = SpaceshipNode()
        pointsLabel = PointsNode()
        
        addChild(spaceship)
        addChild(pointsLabel)
        
    }
    
    /// Describes itself: sets up the GameScene's audio.
    private func setupAudio() {
        
        music = SoundController(clipname: "backgroundMusic", fileType: "mp3", volume: 1.0)
        music?.playSound()
        
        shootAudio = SoundController(clipname: "shootSound", fileType: "wav", volume: 1.0)
        
    }
    
    /// Describes itself: sets up the GameScene's background with lowered zPosition.
    private func setupBackground() {
        
        let background = SKSpriteNode(imageNamed: "8bitbg")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1
        addChild(background)
        
    }
    
    //  Help: ⌥ + click
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        //  The difficulty gets updated depending on how many meteorites have been
        //  shot down and, thus, on the overall points earned and on the time passed
        GameLogic.updateDifficulty()
        
        //  Update the pointsLabel
        pointsLabel.update()
        
        //  Update the spaceship's zRotation property based on the gyroscope's input
        spaceship.positionUpdate(gyroData: sensorInput.readGyro())
        
        //  Spawn the meteorite
        self.spawnMeteorite(currentTime)
        
    }
    
    /// Spawn a meteorite if the GameLogic allows it.
    ///
    /// - Parameter currentTime: time passed since app launch.
    func spawnMeteorite(_ currentTime: TimeInterval) {
        
        if !GameLogic.isMeteoriteSpawnable(currentTime) {
            return
        }
        
        let meteorite = MeteoriteNode()
        addChild(meteorite)
        meteorite.moveToSpaceship()
        
    }
    
    
    /// Debug function to draw a line on the Scene. Useful to show projectile's trajectory.
    ///
    /// - Parameters:
    ///   - p1: Starting point of the line.
    ///   - p2: Ending point of the line.
    private func drawLine(p1: CGPoint, p2: CGPoint) {
        let line = SKShapeNode()
        let path = CGMutablePath()
        
        path.move(to: p1)
        path.addLine(to: p2)
        
        line.path = path
        line.strokeColor = SKColor.white
        
        addChild(line)
    }
    
    //  Help: ⌥ + click
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let bullet = BulletNode()
        addChild(bullet)
        bullet.shoot()
        
        shootAudio?.playSound()
        
    }
    
}

//  Science bi**h!
extension GameScene: SKPhysicsContactDelegate {
    
    //  Help: ⌥ + click
    func didBegin(_ contact: SKPhysicsContact) {
        
        //  When two bodies enter in contact with each other, the logic OR'd bitmasks of the two bitmasks
        //  returns the object identity and thus which objects actually entered in contact.
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //  Spaceship and meteorite entered contact - spaceship is destroyed and game's over.
        if contactMask == contactSpaceshipMeteorite {
            
            let meteorite = contact.bodyA.categoryBitMask == PhysicsCategory.categoryMeteorite ? contact.bodyA.node! : contact.bodyB.node!
            
            meteorite.removeFromParent()
            
            GameLogic.spaceshipDestroyed()
            
        }
        
        //  Bullet and meteorite entered contact - meteorite is destroyed and points are earned.
        if contactMask == contactBulletMeteorite {
            
            var meteorite: SKNode
            var bullet: SKNode
            
            if contact.bodyA.categoryBitMask == PhysicsCategory.categoryMeteorite {
                meteorite = contact.bodyA.node!
                bullet = contact.bodyB.node!
            } else {
                meteorite = contact.bodyB.node!
                bullet = contact.bodyA.node!
            }
            
            meteorite.removeFromParent()
            bullet.removeFromParent()
            
            GameLogic.meteoriteDestroyed()
            
        }
        
    }
    
}
