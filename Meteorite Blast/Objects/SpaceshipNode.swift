//
//  Spaceship.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 07/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

//  Global variables to access the Spaceship's position and size.
var spaceshipPosition: CGPoint?
var spaceshipSize: CGSize?
var spaceshipAngle: CGFloat?

class SpaceshipNode: SKSpriteNode {
    
    //  Maximum angle the spaceship can rotate
    let maximumRotationAngle: CGFloat = .pi / 4
    
    //  Raw gyroscope input is way too much to change the spaceship's zRotation based on it.
    //  Dividing by raw input by a limiting factor.
    let limitingFactor: CGFloat = 20.0
    
    //  Defining spaceship orientation
    enum Orientation: Int {
        case Up, Down
    }
    
    //  Current spaceship orientation
    let currentOrientation: Orientation = .Up
    
    //  Swift doesn't like convenience inits used to call superclass designated inits,
    //  so it necessary to define a self.init that overrides the superclass designated init
    //  and call it through the convenience init. Why? I don't know. Apple design.
    
    //  Below are the convenience initialiser, the overridden designated init and the coder init that Xcode
    //  complains about.
    convenience init() {
        
        self.init(
            texture: SKTexture(imageNamed: "SS2Fix"),
            color: UIColor.red,
            size: CGSize(
                width: sceneFrame!.size.width / 5,
                height: sceneFrame!.size.width / 5
            )
        )
        
        self.position = CGPoint(x: sceneFrame!.midX, y: sceneFrame!.midY / 2)
        self.zRotation = .pi / 2
        
        spaceshipPosition = self.position
        spaceshipSize = self.size
        
        //  Physics body setup
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody!.categoryBitMask = PhysicsCategory.categorySpaceship
        self.physicsBody!.isDynamic = false
        
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    //  Xcode complains if this init isn't implemented; it is necessary for old Obj-C purposes: code/decode data
    //  to read/write in memory and/or disk.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  Function that provides rotation update functionality for the Spaceship node taking in gyroscope data.
    func positionUpdate(gyroData: CGFloat) {
        
        let rotationRate = gyroData / limitingFactor
        
        self.zRotation = !maximumRotationExceeded(rotationRate: rotationRate) ? self.zRotation + rotationRate : self.zRotation
        spaceshipAngle = self.zRotation
        
    }
    
    //  This function provides a way to check whether the spaceship's zRotation would exceed the given limit.
    private func maximumRotationExceeded(rotationRate: CGFloat) -> Bool {
        return abs(self.zRotation + rotationRate - .pi / 2) > maximumRotationAngle
    }
}
