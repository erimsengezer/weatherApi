//
//  Weather.swift
//  weatherApi
//
//  Created by Erim Şengezer on 17.06.2019.
//  Copyright © 2019 Erim Şengezer. All rights reserved.
//

import Foundation

struct WeatherData:Codable {
    var currently: Currently
    
    struct Currently:Codable {
        var summary:String
        var apperentTemprature: Double
    }
}
