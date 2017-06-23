//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by John Yockey on 6/16/17.
//  Copyright © 2017 PracticeRuns. All rights reserved.
//



import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
// MARK: Main View Outlets
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var topWeatherImage: UIImageView!
    @IBOutlet weak var weatherDescriptionLbl: UILabel!
    
// MARK: Table View Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VIEW DID LOAD")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VIEW DID APPEAR")
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            // SIMULATOR BUG            print(self.currentLocation.coordinate.latitude,self.currentLocation.coordinate.longitude)
            Location.sharedInstance.latitude = self.currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = self.currentLocation.coordinate.longitude
//            Location.sharedInstance.latitude = -37
//            Location.sharedInstance.longitude = 125
            self.currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                    print("updated UI")
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        // Downloading forecast data for tableview
        Alamofire.request(CURRENT_FORECAST_URL).responseJSON { response in
            let result = response.result
            //print(response)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    //self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
            }
            completed()
        }
        
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationAuthStatus()
    }
    
    func updateMainUI() {
        dateLbl.text = currentWeather.date
        temperatureLbl.text = "\(currentWeather.currentTemp)°"
        locationLbl.text = currentWeather.cityName
        weatherDescriptionLbl.text = currentWeather.weatherType
        topWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
}

