//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 29/7/22.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController : UIViewController{
    
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var currentWeatherManager = CurrentWeatherManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    

    
    @IBAction func currentPositionTapped(_ sender: UIButton) {
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
    }
    
}

extension CurrentWeatherViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CurrentWeatherViewController:CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longtitude = location.coordinate.longitude
        
            currentWeatherManager.fetchWeather(latitude: latitude, longtitude: longtitude)
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
}
