//
//  ViewController.swift
//  weatherApi
//
//  Created by Erim Şengezer on 17.06.2019.
//  Copyright © 2019 Erim Şengezer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

let stringUrl = "https://api.darksky.net/forecast/2c42268ff4b26ad8a8b8a554c808bd44/37.8267,-122.4233?lang=tr"
//let stringUrl = "https://api.openweathermap.org/data/2.5/weather?q=London&appid=f96b6eca94b78167711e89a709d55545"



class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    var latitude = ""
    var longitude = ""

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
      
//       https://api.darksky.net/forecast/2c42268ff4b26ad8a8b8a554c808bd44/\(String(describing: locationManager.location!.coordinate.latitude)),\(String(describing: locationManager.location!.coordinate.longitude))?lang=tr
        
        super.viewDidLoad()
        //MARK: API
        Alamofire.request("https://api.darksky.net/forecast/2c42268ff4b26ad8a8b8a554c808bd44/\(String(describing: locationManager.location!.coordinate.latitude)),\(String(describing: locationManager.location!.coordinate.longitude))?lang=tr", method: .get).validate().responseJSON { response in
//                print("gelen data: \(response)")
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    
                
                    
                    let temp = json["currently"]
                    let currentTemp = temp["apparentTemperature"].doubleValue
                    let currentTransform = ((currentTemp-32)*5/9).round(step: 2)
                    let timezone = json["timezone"]
//                    print(json)
                    print(timezone)
                    
                    self.label.text  = temp["summary"].stringValue
                    self.tempratureLabel.text = "\(String(currentTransform)) derece"
                    self.cityLabel.text = json["timezone"].stringValue
//                    self.cityLabel.text = timezone.stringValue

                case .failure(let error):
                    print(error)
                }
            }
        //MARK: Location
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
//            print(location.coordinate.latitude)
            latitude = String(location.coordinate.latitude)
            longitude = String(location.coordinate.longitude)
        }
    }
    
    
    
    
    
    }

extension Double{
    func round(step:Int) -> Double {
        let carpan = pow(10.0, Double(step))
        return (self*carpan).rounded()/carpan
    }
}



