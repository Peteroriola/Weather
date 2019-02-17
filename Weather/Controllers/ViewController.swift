//
//  ViewController.swift
//  Weather
//
//  Created by Peter Oriola on 12/02/2019.
//  Copyright © 2019 Peter Oriola. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {

    
    let weatherAPIURL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "d517908dbe446bdefe0b1440ba6eee04"
    
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    @IBOutlet weak var tempratureLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
       
        
        
        
        
    }


    //MARK:- LOCATION MANAGER DELEGATE METHODS
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("Longitude = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude) ")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: weatherAPIURL, parameters: params)
        }
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "City Location Unavaliable"
        
    }
    
    
    //MARK:- NETWORKING WITH ALAMOFIRE
    func getWeatherData(url: String, parameters: [String : String]) {
        Alamofire.request(url, method: .get, parameters : parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success. Got the weather data!")
                
                let weatherJSON : JSON = JSON(response.result.value!)
               print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
              
                self.cityLabel.text = "Connection Issues"
                
            }
        }
        
    }
    
    
    //MARK:- WEATHER DATA JSON PARSING
    
    func updateWeatherData(json: JSON) {
        
        if let tempratureResult = json["main"]["temp"].double {
        
        weatherDataModel.temperature = Int(tempratureResult - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"][0]["id"].intValue
        weatherDataModel.weatherDescription = json["weather"][0]["description"].stringValue
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateWithWeatherData()
        }
        
        
        else {
                cityLabel.text = "Weather Unavalible"
                
            }
    }
    
    //MARK:- UI UPDATE
    
    func updateWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        tempratureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        weatherDescriptionLabel.text = weatherDataModel.weatherDescription
    }
    
    
    
    func userEnteredANewCityName(city: String) {
       
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: weatherAPIURL, parameters: params)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGetCityWeather" {
            
            let destinationVC = segue.destination as! GetWeatherViewController
            
            destinationVC.delegate = self
        }
    }
    
    
}

