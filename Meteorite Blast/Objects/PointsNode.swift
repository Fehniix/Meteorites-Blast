//
//  Meteorite.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 10/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

class PointsNode: SKLabelNode {
    
    //  Pretty self-explanatory.
    //  I would guess this class does not need commenting.
    
    override init() {
        super.init()
        
        self.position = CGPoint(x: sceneFrame!.midX, y: sceneFrame!.midY * 1.7)
        self.fontName = "Minecraft"
        self.color = .white
        
        self.fontSize = 65
        self.text = String(points)
        
        self.createShadow(shadowColour: UIColor.black, offset: CGPoint(x: 4, y: -4), alpha: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        self.text = String(points)
        (self.childNode(withName: "shadowNode") as! SKLabelNode).text = String(points)
    }
    
}

extension SKLabelNode {
    
    func createShadow(shadowColour shadow: UIColor, offset: CGPoint, alpha: CGFloat) {
        let shadowNode = SKLabelNode(fontNamed: self.fontName)
        shadowNode.name = "shadowNode"
        shadowNode.text = self.text
        shadowNode.zPosition = self.zPosition - 1
        shadowNode.fontColor = shadow
        // Just create a little offset from the main text label
        shadowNode.position = CGPoint(x: offset.x, y: offset.y)
        shadowNode.fontSize = self.fontSize
        shadowNode.alpha = alpha
        
        self.addChild(shadowNode)
    }
    
}
