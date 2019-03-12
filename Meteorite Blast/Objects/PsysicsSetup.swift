//
//  PsysicsSetup.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 08/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

//  This one is pretty complex.
//  Each node, so each physics body, has a unique identifier used for most (maybe all) physics events.
//  A "category bitmask", strictly of type UInt32 of course, thus allows you to know which bodies collided.
//  During a collision, for example, the category bitmasks of the two bodies are (logic) OR'd and the result is passed to the didBegin(_: SKPhysicsContact) function.

/// Category bitmasks.
enum PhysicsCategory {
    static let none: UInt32                 = 0x0
    static let categorySpaceship: UInt32    = 0x1
    static let categoryBullet: UInt32       = 0x1 << 1
    static let categoryMeteorite: UInt32    = 0x1 << 2
}

//  Collision bitmasks.
let contactSpaceshipMeteorite = PhysicsCategory.categorySpaceship | PhysicsCategory.categoryMeteorite
let contactBulletMeteorite = PhysicsCategory.categoryBullet | PhysicsCategory.categoryMeteorite
