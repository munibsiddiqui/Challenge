//
//  NetworkManager.swift
//  FlashScooterChallenge
//
//  Created by Munib Siddiqui on 09/07/2019.
//  Copyright © 2019 Munib Siddiqui. All rights reserved.
//

import Foundation

extension Formatter {
  static let iso8601: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
  }()
}
class NetworkManager {
  
  let baseURL = "https://my-json-server.typicode.com/FlashScooters/Challenge/"
  
  static let sharedInstance = NetworkManager()
  static let getPostsEndpoint = "/posts/"
  static let getVehicles = "/vehicles/"
  
  func getAllVehical(onSuccess:@escaping([Vehicle])-> Void, onFailure: @escaping(Error)-> Void){
    
    let url : String = baseURL + NetworkManager.getVehicles
    let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "GET"
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
      
      if(error != nil){
        onFailure(error!)
      } else{
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)

        if let result = try? decoder.decode([Vehicle].self, from: data!){
          onSuccess(result)

        }
      }
      
    })
    
    task.resume()
    
  }
  
  func getAllVehicalById(vehicleId: Int,onSuccess:@escaping(Vehicle)-> Void, onFailure: @escaping(Error)-> Void){
    
    let url : String = baseURL + NetworkManager.getVehicles + String(vehicleId)
    let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
    request.httpMethod = "GET"
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
      
      if(error != nil){
        onFailure(error!)
      } else{
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
        
        if let result = try? decoder.decode(Vehicle.self, from: data!){
          onSuccess(result)
        }
        
      }
      
    })
    
    task.resume()
    
  }
  
}
