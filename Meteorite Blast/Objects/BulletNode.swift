//
//  Meteorite.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 10/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

class BulletNode: SKSpriteNode {
    
    private var destinationPoint: CGPoint!
    private var followAction: SKAction!
    
    convenience init() {
        
        self.init(
            texture: nil,
            color: UIColor.white,
            size: CGSize(
                width: sceneFrame!.size.width / 20,
                height: sceneFrame!.size.width / 20
            )
        )
        
        //  Through the power of trigonometry, let's define the origin position of the bullet.
        let radius = spaceshipSize!.width / 2
        let nonOriginPoint = CGPoint(
            x: spaceshipPosition!.x + cos(spaceshipAngle!) * radius,
            y: spaceshipPosition!.y + sin(spaceshipAngle!) * radius
        )
        
        self.position = nonOriginPoint
        self.destinationPoint = calculateTrajectory()
        
        //  Defining the "follow action" for the current bullet's node.
        //  Specifically, the GameScene would be able to access the followAction
        //  property and run the action after the node has been added to the scene's children
        let bulletPath = UIBezierPath()
        bulletPath.move(to: self.position)
        bulletPath.addLine(to: self.destinationPoint)
        followAction = SKAction.sequence([
            SKAction.follow(bulletPath.cgPath, asOffset: false, orientToPath: true, speed: bulletsSpeed),
            SKAction.removeFromParent()
        ])
        
        //  Defining bullet's physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody!.categoryBitMask = PhysicsCategory.categoryBullet
        self.physicsBody!.contactTestBitMask = PhysicsCategory.categoryMeteorite
        self.physicsBody!.collisionBitMask = PhysicsCategory.none
        self.physicsBody!.affectedByGravity = false
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Start shoot action.
    func shoot() {
        self.run(self.followAction)
    }
    
    /// Calculates the destination point for the bullet.
    /// This algorithm calculates exactly the minimum distance for the projectile to travel so that it gets removed from the scene as quickly as possible to optimise performance.
    /// Warning: lots of trigonometry.
    ///
    /// - Returns: point on the scene's frame border.
    private func calculateTrajectory() -> CGPoint {
        
        let functionalAngle = abs(.pi / 2 - spaceshipAngle!)
        var minDistanceToFrame = sceneFrame!.maxY - spaceshipPosition!.y
        var computedDistanceToFrame = minDistanceToFrame / cos(functionalAngle)
        
        var dx = cos(spaceshipAngle!) * computedDistanceToFrame
        var dy = sin(spaceshipAngle!) * computedDistanceToFrame
        
        let relativePosition = dx + spaceshipPosition!.x
        if  relativePosition <= 0 {
            
            minDistanceToFrame = spaceshipPosition!.x
            computedDistanceToFrame = minDistanceToFrame / sin(functionalAngle)
            
            dx = -spaceshipPosition!.x
            dy = sin(spaceshipAngle!) * computedDistanceToFrame
            
        } else if relativePosition >= sceneFrame!.maxX {
            
            minDistanceToFrame = spaceshipPosition!.x
            computedDistanceToFrame = minDistanceToFrame / sin(functionalAngle)
            
            dx = spaceshipPosition!.x
            dy = sin(spaceshipAngle!) * computedDistanceToFrame
            
        }
        
        return CGPoint(x: dx + spaceshipPosition!.x, y: dy + spaceshipPosition!.y)
        
    }
    
}

