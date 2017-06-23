//
//  Location.swift
//  rainyshinycloudy
//
//  Created by John Yockey on 6/20/17.
//  Copyright © 2017 PracticeRuns. All rights reserved.
//

import CoreLocation

// Singleton Class
class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
