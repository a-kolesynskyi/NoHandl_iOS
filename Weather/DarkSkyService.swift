//
//  DarkSkyService.swift
//  Example
//
//  Created by Antony Kolesynskyi on 3/9/19.
//  Copyright © 2019 Luis Padron. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

public class DarkSkyService {
    
    static func weatherForLocation(latitude: String, longitude: String, time: String, completion: @escaping (Any?, Error?) -> ()) {
        
        let baseURL = "https://api.darksky.net/forecast/"
        let apiKey = "102c976bcb168d808b0714b867807761"
        
        let url = baseURL + apiKey + "/\(latitude),\(longitude)," + time
        print("\(url) - url session")
        
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let result):
                completion(WeatherData(data: result), nil)
            case .failure(let error):
                completion(nil, error)
                
            }
        }
    }
    
    
}
