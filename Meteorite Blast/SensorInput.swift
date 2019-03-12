//
//  SensorInput.swift
//  Meteorite Blast
//
//  Created by Johnny Bueti on 07/03/2019.
//  Copyright © 2019 Fehniix. All rights reserved.
//

import SpriteKit
import CoreMotion

/// Gyroscope rotation rate of change update interval in Hertz (radians per second)
let updateInterval: Double = 1 / 60

class SensorInput {
    
    /// Singleton shared object.
    ///
    /// This object is instantiated at application launch and is thus
    /// usable by the whole application's scope.
    static var shared = SensorInput()
    
    /// MotionManager private object.
    private var motionManager = CMMotionManager()
    
    private init() {}
    
    /// Start gyroscope sensor.
    func startUpdates() {
        motionManager.gyroUpdateInterval = updateInterval
        motionManager.startGyroUpdates()
    }
    
    /// Reads gyroscope data.
    ///
    /// - Returns: raw gyroscope data.
    func readGyro() -> CGFloat {
        
        guard let data = motionManager.gyroData else {
            return 0
        }
        
        return CGFloat(data.rotationRate.z)
        
    }
}
