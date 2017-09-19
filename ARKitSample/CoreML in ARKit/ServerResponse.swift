//
//  ServerResponse.swift
//  CoreML in ARKit
//
//  Created by Sebastian Lindenmüller on 19.09.17.
//  Copyright © 2017 CompanyName. All rights reserved.
//
import Foundation

struct DeviceData: Codable {
    let messageId: String
    let deviceDataRawId: String
    let deviceId: String
    let deviceName: String
    let deviceType: String
    let deviceTags: String
    let deviceMessage: [DeviceMessage]
    let timestamp: Date
}

struct DeviceMessage: Codable {
    let move: Int?
    let temp: Int?
    let vol: Int?
    let licht: Int?
}

// Result Example
//[
//    {
//        "messageId":"71d8c0b0-d9f9-4dea-b27b-007db4c55150",
//        "deviceDataRawId":"0c9683eb-e519-40f5-95e3-95f983377e88",
//        "deviceId":"b1b29ae6-9618-4df1-8f34-b565c182e7cc",
//        "deviceName":"CALLIOPE ADG 3",
//        "deviceType":"calliopeMini",
//        "deviceTags":["calliopeMini"],
//        "deviceMessage":{
//            "Bewegung":1
//        },
//        "deviceDataRaw":{
//            "id":"0c9683eb-e519-40f5-95e3-95f983377e88",
//            "v":"0.0.0",
//            "fw":"n.a.",
//            "a":"qsVjS7apbASi+2i3pR3tfh2blQ16fMBQIgzSxxRODDRJfOprXbZoef9OD7Uyl/9TcDYGgZprfM2YL1LgM56IPA==",
//            "did":"8d464dd2",
//            "ts":"2017-09-19T15:02:47.211Z",
//            "mpraw":"00ce8d464dd2d90e7b224265776567756e67223a317d",
//            "p":{
//                "Bewegung":1
//            }
//        },
//        "timestamp":"2017-09-19T15:02:47.211Z"
//    }
//]
