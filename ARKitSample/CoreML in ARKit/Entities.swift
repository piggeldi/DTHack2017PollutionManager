//
//  Device.swift
//  CoreML in ARKit
//
//  Created by Frederik Ikemann on 19.09.17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import Foundation
import SceneKit

struct DeviceCoord: Codable {
    let x: Float
    let y: Float
    let z: Float
    init(vector: SCNVector3) {
        x = vector.x
        y = vector.y
        z = vector.z
    }
}

typealias DeviceCoords = [DeviceCoord]

class CoordStorage {
    
    let userDefaultsKey = "coordinatesStore"
    
    func fetchAll() -> DeviceCoords? {
        let jsonEncodedData = UserDefaults.standard.string(forKey: userDefaultsKey)
        return nil
    }
    
    func add(coord: DeviceCoord) {
        
        
    }
    
    func remove(coord: DeviceCoord) {
        
    }
}
