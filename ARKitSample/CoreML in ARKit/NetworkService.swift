//
//  NetworkService.swift
//  CoreML in ARKit
//
//  Created by Frederik Ikemann on 19.09.17.
//  Copyright © 2017 CompanyName. All rights reserved.
//

import Foundation
import Alamofire
import CodableAlamofire

final class DeviceNetworkService {
    
    typealias DevicesResponse = [String: [DeviceData]]
    private var fullfilledData: DevicesResponse = [:]
    
    func fetchDataFromAllDevices(completion: @escaping (DevicesResponse) -> Void) {
        fullfilledData.removeAll()
        Endpoint.devices.forEach { (device) in
            
            Alamofire.request(device).responseDecodableObject { (response: DataResponse<[DeviceData]>) in
                guard let result = response.result.value else {
                    return
                }
                self.fullfill(devices: result, completion: completion)
            }
        }
    }
    
    private func fullfill(devices: [DeviceData], completion: @escaping (DevicesResponse) -> Void) {
        guard let deviceID = devices.first?.deviceId else {
            return
        }
        
        fullfilledData[deviceID] = devices
        if fullfilledData.count == Endpoint.devices.count {
            completion (fullfilledData)
        }
    }
}

enum Endpoint: URLConvertible, URLRequestConvertible {
    
    case Device1
    case Device2
    case Device3
    
    var deviceID: String {
        switch self {
        case .Device1:
            return "b1b29ae6-9618-4df1-8f34-b565c182e7cc"
        case .Device2:
            return "9b551c27-2499-4f21-8081-664e3647646f"
        case .Device3:
            return "9f435eff-9d06-4429-81d7-25f271ef5705"
        }
    }
    
    static var devices: [Endpoint] = [.Device1,.Device2,.Device3]
    
    var token: String {
        switch self {
        case .Device1, .Device2:
            return "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlS1ZZVFV5dWNQcHg0OU1WSGhHb2RfR2wyV3YtNEFibEV2SXlWQTBiWDdvIn0.eyJqdGkiOiIxNzRkMWNmNC0yNGVkLTRjOGItOWM2Mi04NmE1MWU2MmRmZWEiLCJleHAiOjE1MDU4MzA0NzYsIm5iZiI6MCwiaWF0IjoxNTA1ODMwMTc2LCJpc3MiOiJodHRwczovL2lkLmRldi51YmlyY2guY29tL2F1dGgvcmVhbG1zL3ViaXJjaCIsImF1ZCI6InViaXJjaC1hZG1pbi11aS1kZW1vIiwic3ViIjoiMTA5ODQyNzQtOWExOC00MTExLTlmOTQtZDJmNGRiMzNjNzcwIiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidWJpcmNoLWFkbWluLXVpLWRlbW8iLCJhdXRoX3RpbWUiOjE1MDU4MzAxNzMsInNlc3Npb25fc3RhdGUiOiJiYTA2YmQ2ZS0yNDA5LTQwZjctYjFiYS00MjY2MjE5ODUyZTQiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHBzOi8vdWJpcmNoLmRlbW8udWJpcmNoLmNvbSJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJuYW1lIjoiQWxleGFuZGVyIGRlIEdyZWlmZiIsInByZWZlcnJlZF91c2VybmFtZSI6ImFkZWdyZWlmZiIsImdpdmVuX25hbWUiOiJBbGV4YW5kZXIiLCJmYW1pbHlfbmFtZSI6ImRlIEdyZWlmZiIsImVtYWlsIjoiYWxleGFuZGVyQGRlZ3JlaWZmLmNvbSJ9.O_dHYEYHkTP67PzyaPH7OKRSe60EdmzCPlfhBqhUGLpzFDqxUVwTgJkkTI4Q-ovskCZSDbjR9EYcPns6qM-wPbG9_hUpuUtqhN30S40EYiWwWEG00242uC6N61E6vpVqcSXjxVi5k9_Ur5jPKnLkuNUulocy8cyFwGhTiZy1FYgwwr6ulSnwP4uV2gHpFlQbSuWWh135MexxrN-dQfMP3RErpXzR3Gbyw__M7DkCH3kaVsppgHRwATjSOcjp_4ywGsM1mHhd1Mg7fI4tVzkw0UOnKCbRypQTW1yXq7Djr4XXd384JUMnHPehgCRvz8CTZk2eFVh5pSj2pRljbHfW3w"
        case .Device3:
            return "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJlS1ZZVFV5dWNQcHg0OU1WSGhHb2RfR2wyV3YtNEFibEV2SXlWQTBiWDdvIn0.eyJqdGkiOiJjYjlkODBkYi1kNTAyLTRhZGQtYmFjOC01YzgxNGNmYjUzMzkiLCJleHAiOjE1MDU4MjMxNzUsIm5iZiI6MCwiaWF0IjoxNTA1ODIyODc1LCJpc3MiOiJodHRwczovL2lkLmRldi51YmlyY2guY29tL2F1dGgvcmVhbG1zL3ViaXJjaCIsImF1ZCI6InViaXJjaC1hZG1pbi11aS1kZW1vIiwic3ViIjoiMGYxNjZkNmEtZDExZC00MmQxLWFiOGEtZDA3Y2ZjZDQxZjk1IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoidWJpcmNoLWFkbWluLXVpLWRlbW8iLCJhdXRoX3RpbWUiOjE1MDU4MjI4NzQsInNlc3Npb25fc3RhdGUiOiIzZDQyZWNkYi0yNWYyLTRiNjctODZmYS0xZjAwMzVhMDk4NDkiLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbImh0dHBzOi8vdWJpcmNoLmRlbW8udWJpcmNoLmNvbSJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJuYW1lIjoiTHVrIE5pZXN3YW5kdCIsInByZWZlcnJlZF91c2VybmFtZSI6Imx1ayIsImdpdmVuX25hbWUiOiJMdWsiLCJmYW1pbHlfbmFtZSI6Ik5pZXN3YW5kdCIsImVtYWlsIjoibHVrQG5pZXN3YW5kdC5jb20ifQ.BOP1wPKT4ZVe82-zkbdwbDXqe4wbJS63cNeUm_XREkCybDcjnSpzKMLGt_jlfz6dYnZO5XbXl6De075-NeETrG2d2i6eUvzQKDgiTQA6qK9472TnkN3Cou63D3dRdXmBvt7aiYljETZjNAkHkTFNZB3vwBS2y3g5ab1sRUsdfb_d_h03lYO7lrGJsyahWfMVc6uoloFeY1uDiIw1xK35VSzwyI3S-2fUhsE5dkT04FBUXcksfmFYpFw16We1ki7xEKZhgI6QnlBFiWmBLavGRQxM66kcbatUWsi8nMDTrn4ssIRYPk7U4kt7Zuy-daxUzlJvQ21AeuefZBuO4GsusA"
        }
    }
    
    var host: String {
        return "https://api.ubirch.demo.ubirch.com"
    }
    
    var path: String {
        return "/api/avatarService/v1/device/\(self.deviceID)/data/history/0/10"
    }
    
    func asURL() throws -> URL {
        var urlComponents = URLComponents(string: self.host)!
        urlComponents.path = self.path
        return try urlComponents.asURL()
    }
    
    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: try self.asURL())
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        let encoding = URLEncoding(destination: .queryString)
        
        // create a URLRequest with encoded parameters
        return try encoding.encode(request, with: nil)
    }
}
