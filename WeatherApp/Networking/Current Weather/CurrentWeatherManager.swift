//
//  CurrentWeatherManager.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import Foundation
import CoreLocation

protocol currentWeatherDelegate{
    func fetchWeather(weather: CurrentWeatherModel)
    func errorFetchingWeather(error: Error)
}

class CurrentWeatherManager{
    
    static let shared = CurrentWeatherManager()
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=887423efb2e91bf0b8ce30df56f2ebd0&units=metric"
    
    var currentWeatherDelegate:currentWeatherDelegate? = nil
 
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let UrlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        
        createRequest(urlString: UrlString) // zapusk fukncii url
    }
    
    func fetchWeather(cityName: String){
        let UrlString = "\(weatherURL)&q=\(cityName)"
        
        createRequest(urlString: UrlString) // zapusk fukncii url
    }
    
    func createRequest(urlString: String){
        let url = URL(string: urlString) //sozdanie url
        
        // otkrytie opcionalnogo url
        if let url = url {
            let session = URLSession(configuration: .default)
        
            //sozdanie taska na otkrytie url
            let task = session.dataTask(with: url) { (data, response, error) in
                print("Response: \(response)")
                
                if let error = error {
                    self.currentWeatherDelegate?.errorFetchingWeather(error: error)
                }
                
                if let data = data {
                    if let decodedData = self.parseJson(weatherData: data){
                        self.currentWeatherDelegate?.fetchWeather(weather: decodedData)
                    }
                }
            }
            task.resume() //zapusk taska
        }
    }
    
    func parseJson(weatherData: Data)-> CurrentWeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try
            decoder.decode(CurrentWeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let long = decodedData.coord.lon
            let lat = decodedData.coord.lat
            
            let weather = CurrentWeatherModel(conditionId: id, cityName: name, temperature: temp, long: long, lan: lat)
            
            return weather
            
        } catch{
            currentWeatherDelegate?.errorFetchingWeather(error: error)
            return nil
        }
    }
    
}
