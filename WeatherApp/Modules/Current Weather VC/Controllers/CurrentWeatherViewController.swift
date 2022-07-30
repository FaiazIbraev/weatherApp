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
    @IBOutlet weak var futureWeatherButton: UIButton!
    
    var locationManager = CLLocationManager()
    var cityName: String?
    var currentWeatherManager = CurrentWeatherManager.shared
    
    var long: Double?
    var lat: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextField.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        currentWeatherManager.currentWeatherDelegate = self
    }
    

    
    @IBAction func futureWeatherButtonTapped(_ sender: UIButton) {
        guard let cityName = cityName else {
            return
        }

//        let vc = FutureWeatherVC (cityName: cityName)
//        present(vc, animated: true)
       
        let vc = storyboard?.instantiateViewController(withIdentifier: "FutureWeatherVC") as! FutureWeatherVC
        vc.lat = self.lat
        vc.long = self.long

        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func currentPositionTapped(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchTapped(_ sender: UIButton) {
//        mainTextField.becomeFirstResponder()
        fetchCityWeather()
    }
    

func fetchCityWeather(){
    if let text = mainTextField.text {
        if text.isEmpty{
            mainTextField.placeholder = "Type a city"
        } else{
            currentWeatherManager.fetchWeather(cityName: text)
        }
    }else{
        mainTextField.placeholder = "Type a city"
    }
}

    
}

extension CurrentWeatherViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text.isEmpty{
                textField.placeholder = "Type a city"
            } else{
                currentWeatherManager.fetchWeather(cityName: text)
            }
        }else{
            textField.placeholder = "Type a city"
        }
        
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

extension CurrentWeatherViewController:currentWeatherDelegate{
    
    func fetchWeather(weather: CurrentWeatherModel) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.cityName
            self.cityName = weather.cityName
            self.mainLabel.text = weather.temperatureString
            self.mainImageView.image = UIImage(systemName: weather.conditionName)
            self.lat = weather.lan
            self.long = weather.long
        }
    }
    
    
    func errorFetchingWeather(error: Error) {
        print(error.localizedDescription)
    }
    
    
}
