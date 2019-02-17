//
//  WeatherDataModel.swift
//  Weather
//
//  Created by Peter Oriola on 12/02/2019.
//  Copyright © 2019 Peter Oriola. All rights reserved.
//

import UIKit

class WeatherDataModel: UIViewController {

    
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- WEATHER ID CODE TO WEATHER ICON
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
        case 0...300:
            return "11dthunderstorm"
            
        case 301...500 :
            return "09dshowerrainanddrizzle"
            
        case 501...600 :
            return "10drain"
            
        case 601...700 :
            return "13dSnow"
            
        case 701...799 :
            return "50dMist"
 
        case 800 :
            return "01dClearSky"
            
        case 801 :
            return "02dFewClouds"
            
        case 802  :
            return "03dscatteredclouds"
            
        case 803 :
            return "04dBrokenCloudsandovercastclouds"
            
        case 804 :
            return "04dBrokenCloudsandovercastclouds"
            
        default :
            return "01dClearSky"
        
        }
        
    }
    
    

}
