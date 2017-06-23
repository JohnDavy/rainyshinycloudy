//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by John Yockey on 6/19/17.
//  Copyright © 2017 PracticeRuns. All rights reserved.
//

// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}

//http://api.openweathermap.org/data/2.5/weather?lat=-36&lon=123&appid=43e216a19d84823b594ecc8da19e5635
//api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let BASE_FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "43e216a19d84823b594ecc8da19e5635"
let FORECAST_CNT = "&cnt=10"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
let CURRENT_FORECAST_URL = "\(BASE_FORECAST_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(FORECAST_CNT)&mode=json\(APP_ID)\(API_KEY)"
