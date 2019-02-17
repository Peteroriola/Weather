//
//  GetWeatherViewController.swift
//  Weather
//
//  Created by Peter Oriola on 12/02/2019.
//  Copyright © 2019 Peter Oriola. All rights reserved.
//

import UIKit

//MARK:-

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class GetWeatherViewController: UIViewController {

    
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var getCityTextField: UITextField!
    
    @IBAction func getCityWeatherPressed(_ sender: AnyObject) {
        
        let cityName = getCityTextField.text!
        
        delegate?.userEnteredANewCityName(city: cityName)
        
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
