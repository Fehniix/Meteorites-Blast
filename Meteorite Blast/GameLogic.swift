//
//  GameLogic.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 08/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit

///  Accessible across the entire app's scope,
///  the below method defines the current game's difficulty
var currentDifficulty: Difficulty = .Easy

///  Depending on the current difficulty, the spawn frequency
///  of meteorites gets updated.
var meteoritesFrequency: TimeInterval = 2

///  Seconds passed since the last time a meteorite was spawned
var lastSpawned: TimeInterval = 0

///  Depending on the difficulty, the speed of the meteorites
///  gets updated.
var meteoritesSpeed: CGFloat = 500

/// Bullets' speed.
var bulletsSpeed: CGFloat = 800

///  Current points!
var points: Int = 0


/// Contains all difficulties.
///
/// - Easy: meteorites spawn with lower frequency.
/// - Normal: meteorites spawn with a bit higher frequency.
/// - Hard: meteorites spawn with higher frequency.
/// - Hardest: meteorites spawn at highest frequency.
enum Difficulty: Double {
    case Easy = 2
    case Normal = 1.5
    case Hard = 1.0
    case Hardest = 0.7
}

class GameLogic {
    
    
    /// Determines whether the meteorite is spawnable or not.
    ///
    /// - Parameter currentTime: time passed since startup.
    /// - Returns: Bool
    static func isMeteoriteSpawnable(_ currentTime: TimeInterval) -> Bool {
        
        //  Time rule.
        //
        //  The meteorite will be spawned only if more time has passed than the meteorite's spawn frequency.
        if (currentTime - lastSpawned < meteoritesFrequency) {
            return false
        } else {
            lastSpawned = currentTime
            return true
        }

    }
    
    /// Add points depending on difficulty.
    static func meteoriteDestroyed() {
        points += Int((1 / (currentDifficulty.rawValue * currentDifficulty.rawValue)) * 22)
    }
    
    /// Reset points.
    static func spaceshipDestroyed() {
        points = 0
        
        currentDifficulty = .Easy
    }
    
    /// Update difficulty depending on points earned.
    static func updateDifficulty() {
        
        if points >= 80 {
            currentDifficulty = .Normal
        }
        
        if points >= 350 {
            currentDifficulty = .Hard
        }
        
        if points >= 900 {
            currentDifficulty = .Hardest
        }
        
        //  Update meteorites' spawn frequency depending on difficulty
        meteoritesFrequency = currentDifficulty.rawValue
        
    }
    
}
