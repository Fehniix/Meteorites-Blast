//
//  PsysicsSetup.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 08/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

enum PhysicsCategory {
    static let none: UInt32                 = 0x0
    static let categorySpaceship: UInt32    = 0x1
    static let categoryBullet: UInt32       = 0x1 << 1
    static let categoryMeteorite: UInt32    = 0x1 << 2
}

let contactSpaceshipMeteorite = PhysicsCategory.categorySpaceship | PhysicsCategory.categoryMeteorite
let contactBulletMeteorite = PhysicsCategory.categoryBullet | PhysicsCategory.categoryMeteorite
