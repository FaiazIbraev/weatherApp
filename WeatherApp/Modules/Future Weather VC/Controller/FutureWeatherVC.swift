//
//  FutureWeatherVC.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import UIKit
import CoreLocation

class FutureWeatherVC : UIViewController{
    
//    init(cityName:String){
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    var cityName: String?
    var manager = FutureWeatherManager.shared
    var locationManager = CLLocationManager()
    
    var weather: [FutureWeatherModelToShow] = []
    
    var long: Double?
    var lat: Double?
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        tableViewOutlet.separatorStyle = .none

        locationManager.delegate = self
        locationManager.requestLocation()
        
        guard let latDouble = self.lat, let longDouble = self.long
        else {
            print("No doubles")
            return
        }
        
        manager.futureWeatherDelegate = self
            manager.fetchWeather(latitude: CLLocationDegrees(Float(latDouble)), longtitude: CLLocationDegrees(Float(longDouble)))
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension FutureWeatherVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longtitude = location.coordinate.longitude
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}

extension FutureWeatherVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        
        let item = weather[indexPath.row]
        cell.label1.text = item.weatherDesc
        cell.label2.text = String(item.temp)
        cell.label3.text = String(item.dateSeconds)
        
        let myTimeInterval = TimeInterval(item.dateSeconds)
        let time = NSDate (timeIntervalSince1970: TimeInterval(myTimeInterval))
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-DD HH:mm a"
        
        let myString = formatter.string(from: time as Date)
        let yourData = formatter.date(from: myString)
        
    return cell
    }
}

extension FutureWeatherVC:FutureWeatherDelegate{
    func fetchWeather(weather: [FutureWeatherModelToShow]) {
        print("weather: \(weather)")
        self.weather = weather
        DispatchQueue.main.async {
            self.tableViewOutlet.reloadData()
        }
        
    }
    
    func errorFetchingWeather(error: Error) {
        print("error: \(error)")
    }
    
    
}
