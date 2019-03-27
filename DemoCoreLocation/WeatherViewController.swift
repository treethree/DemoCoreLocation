//
//  WeatherViewController.swift
//  DemoCoreLocation
//
//  Created by SHILEI CUI on 3/26/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import UIKit
import CoreLocation
var lat : Double = 0
var lot : Double = 0

class WeatherViewController: UIViewController ,CLLocationManagerDelegate{

    var locationManager = CLLocationManager()
    var curWeather : Weather?
    
    @IBOutlet weak var tempLbl: UILabel!
    
    @IBOutlet weak var hiLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    
    @IBOutlet weak var sumLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        //callWeatherAPI(lat: lat, lot: lot)
        //print(lat)
    }
    
    
    func setupLocation(){
        
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedAlways{
            locationManager.startUpdatingLocation()
            
            //callWeatherAPI(lat: 41.90364542, lot: -88.33318334)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last{
            //print(loc)
            lat = loc.coordinate.latitude
            lot = loc.coordinate.longitude
            print(lat)
//            print(lot)
            //getCityName(loc: loc)
            
            locationManager.stopUpdatingLocation()
            callWeatherAPI(lat: lat, lot: lot)
            //print(lat)
            
            //print(curWeather?.humidity)
        }
    }
    
    func callWeatherAPI(lat: Double, lot: Double)  {
        Apihandler.sharedInstance.getApiForWeather(lat: lat, lot: lot) { (Weather, error) in
            if Weather != nil{
            self.curWeather = Weather!
            let signTemp = String(format:"%@", "\u{00B0}") as String
            self.curWeather?.currently.temperature
            self.tempLbl.text = "\(String(Int((self.curWeather?.currently.temperature)!)))\(signTemp)"
            self.hiLbl.text = "\(String(Int(self.curWeather!.daily.data[0].temperatureMax)))\(signTemp)"
            self.lowLbl.text = "\(String(Int(self.curWeather!.daily.data[0].temperatureMin)))\(signTemp)"
            self.sumLbl.text = "\(String(Substring((self.curWeather?.currently.summary)!.rawValue)))"
                
                print(String(self.curWeather!.daily.summary))
            }
            print("sdasdas")
            
        }
    }

}
