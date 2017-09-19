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
        let decoder = JSONDecoder()
        guard let JSONString = UserDefaults.standard.string(forKey: userDefaultsKey),
            let JSONData = JSONString.data(using: .utf8),
            let coords = try? decoder.decode(DeviceCoords.self, from: JSONData) else {
            return nil
        }
        return coords
    }
    
    func add(coord: DeviceCoord) {
        var deviceCoords = fetchAll() ?? []
        deviceCoords.append(coord)
        let encoder = JSONEncoder()
        let JSONString = try? encoder.encode(deviceCoords)
        UserDefaults.standard.set(JSONString, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
    func remove(coord: DeviceCoord) {
        
        
    }
}
