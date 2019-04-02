//
//  ChoosenDateController.swift
//  Example
//
//  Created by Antony Kolesynskyi on 2/5/19.
//  Copyright © 2019 Luis Padron. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ChoosenDateController : UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTempLabel: UILabel!
    
    var choosenDate = String()
    var choosenDescription = String()
    
    @IBOutlet var choosenDateLabel: UILabel!
    @IBOutlet var choosenDescriptionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var localValue: CLLocationCoordinate2D!
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        print("\(dateFormatter.string(from: date!)) some text bleat'")
        return  dateFormatter.string(from: date!)
        
    }
    let emojiIcons = [
        "clear-day" : "☀️",
        "clear-night" : "🌙",
        "rain" : "☔️",
        "snow" : "❄️",
        "sleet" : "🌨",
        "wind" : "🌬",
        "fog" : "🌫",
        "cloudy" : "☁️",
        "partly-cloudy-day" : "🌤",
        "partly-cloudy-night" : "🌥"
    ]

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            DarkSkyService.weatherForLocation(latitude: latitude ,longitude: longitude, time: convertDateFormater(choosenDate)) { weatherData, error in
                if let weatherData = weatherData {
                    print(weatherData)
                    DispatchQueue.main.async {
                        self.view.reloadInputViews()
                    }
                    self.updateLabels(with: weatherData as! WeatherData, at: location)
                } else if let _ = error {
                    self.handleError(message: "Unable to load the forecast for your location")
                }
            }
        
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        handleError(message: "Unable to load your location.")
    }
    
    func handleError(message: String) {
        let alert = UIAlertController(title: "Error Loading Forecast", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateLabels(with data: WeatherData, at location: CLLocation) {
        self.temperatureLabel.text = data.temperature
        self.appearentTempLabel.text = data.summary
        self.weatherIconLabel.text = emojiIcons[data.icon] ?? "😭"
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            let locationName = placemarks?.first?.locality ?? " Unknown Location"
            self.locationLabel.text = locationName
            print("\(locationName)")
        }
        
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        choosenDateLabel.text = choosenDate
        choosenDescriptionLabel.text = choosenDescription
        }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

}
