//
//  Meteorite.swift
//  Meteorite Blast
//
//  Created by Mirko Mataluni on 08/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

class MeteoriteNode: SKSpriteNode {
    
    //  Meteorite's destination point inside the spaceship's area
    var destinationPoint: CGPoint = CGPoint(x: 0, y: 0)
    
    //  Meteorite's follow action
    private var followAction: SKAction!
    
    convenience init() {
        
        
        
        self.init(
            texture: SKTexture(imageNamed: "Asteroid2"),
            color: UIColor.white,
            size: CGSize(
                width: sceneFrame!.size.width / 8,
                height: sceneFrame!.size.width / 8
            )
        )
        
        //  Setting the node's position to the randomly generated origin point of the
        //  meteorite's path to follow.
        self.position = originPointGenerate(frame: sceneFrame!)
        
        //  Setting the destinationPoint property to the randomly generated destination
        //  point within the spaceship's CGRect area.
        self.destinationPoint = destinationPointGenerate()
        
        //  Defining the "follow action" for the current meteorite's node.
        //  Specifically, the GameScene would be able to access the followAction
        //  property and run the action after the node has been added to the scene's children
        let meteoritePath = UIBezierPath()
        meteoritePath.move(to: self.position)
        meteoritePath.addLine(to: self.destinationPoint)
        followAction = SKAction.follow(meteoritePath.cgPath, asOffset: false, orientToPath: true, speed: meteoritesSpeed)
        
        //  Defining meteorite's physics
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody!.categoryBitMask = PhysicsCategory.categoryMeteorite
        self.physicsBody!.contactTestBitMask = PhysicsCategory.categorySpaceship
        self.physicsBody!.collisionBitMask = PhysicsCategory.none
        self.physicsBody!.affectedByGravity = false
        
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ScreenArea: Int {
        case Left, Center, Right
    }
    
    //  Convenience function that starts meteorite's movement
    func moveToSpaceship() {
        self.run(followAction)
    }
    
    private func originPointGenerate(frame: CGRect) -> CGPoint {
        
        //  Here we are dividing the screen into three sections: left, center, right.
        //  The meteorites are going to spawn along the x and y axis of the three corresponding areas.
        
        //  Choosing the random screen area
        let randomArea = ScreenArea(rawValue: Int.random(in: 0 ... 2))
        
        if randomArea == .Left {
            
            return CGPoint(
                x: 0,
                y: CGFloat.random(in: frame.maxY - frame.maxY / 4 ... frame.maxY)
            )
            
        } else if randomArea == .Center {
            
            return CGPoint(
                x: CGFloat.random(in: 0 ... frame.maxX),
                y: frame.maxY
            )
            
        } else {
            
            return CGPoint(
                x: frame.maxX,
                y: CGFloat.random(in: frame.maxY - frame.maxY / 4 ... frame.maxY)
            )
            
        }
        
    }
    
    //  Randomly generate the destination point for the meteor path to follow
    private func destinationPointGenerate() -> CGPoint {
        
        //  Generating <x, y> tuple along spaceship's square x, y axis
        //  This allows to have a spawnable area within the spaceship's rectangle
        let startX: CGFloat = spaceshipPosition!.x - (spaceshipSize!.width / 2)
        let endX: CGFloat = spaceshipPosition!.x + (spaceshipSize!.width / 2)
        
        let startY: CGFloat = spaceshipPosition!.y - (spaceshipSize!.width / 2)
        let endY: CGFloat = spaceshipPosition!.y + (spaceshipSize!.width / 2)
        
        return CGPoint(
            x: CGFloat.random(in: startX ... endX),
            y: CGFloat.random(in: startY ... endY)
        )
        
    }
    
}
