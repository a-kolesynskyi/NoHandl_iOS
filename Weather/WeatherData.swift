//
//  WeatherData.swift
//  Example
//
//  Created by Antony Kolesynskyi on 3/9/19.
//  Copyright © 2019 Luis Padron. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherData {
    let summary:String
    let icon:String
    let temperature: String

    init(data: Any)  {
        let json = JSON(data)
        let currentWeather = json["currently"]
        
        
        if let temperature = currentWeather["temperature"].float {
            self.temperature = String(format: "%.0f", temperature) + " *F"
        } else {
            self.temperature = "Niestety"
        }
        self.icon = currentWeather["icon"].string ?? "--"

        self.summary = currentWeather["summary"].string ?? "Ale jeszcze nie widać!"

}
    
    
}
