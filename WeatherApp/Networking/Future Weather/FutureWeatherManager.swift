//
//  FutureWeatherManager.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import Foundation
import CoreLocation

protocol FutureWeatherDelegate{
    func fetchWeather(weather: [FutureWeatherModelToShow])
    func errorFetchingWeather(error: Error)
}

class FutureWeatherManager{
    
    static let shared = FutureWeatherManager()
    
    var futureWeatherDelegate:FutureWeatherDelegate?

    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=887423efb2e91bf0b8ce30df56f2ebd0&units=metric"
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees){
        let UrlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        
        print("URL STRING: \(UrlString)")
        createRequest(urlString: UrlString)
    }
    
    func fetchWeather(cityName: String){
        let UrlString = "\(weatherURL)&q=\(cityName)"
        createRequest(urlString: UrlString)
    }
    
    func createRequest(urlString: String){
        guard let url = URL(string: urlString)
        else { return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
          
            if let error = error {
                self.futureWeatherDelegate?.errorFetchingWeather(error: error)
            }
            
            if let data = data {
                if let weatherData = self.parseJson(weatherData: data){
                    self.futureWeatherDelegate?.fetchWeather(weather: weatherData)
                }
            }
        }
        task.resume()
    }
    
    func parseJson(weatherData: Data)-> [FutureWeatherModelToShow]?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try
            decoder.decode(FutureWeatherModel.self, from: weatherData)
            
            var weatherArray: [FutureWeatherModelToShow] = []
            
            for i in decodedData.list{
                let temp = i.main.temp
                let date = i.dt
                let weatherDesc = i.weather.first?.main
                
                let weather = FutureWeatherModelToShow(temp: temp, dateSeconds: date, weatherDesc: weatherDesc ?? "")
                
                weatherArray.append(weather)
            }
            
            print("Array:\(weatherArray)")
            
            return weatherArray
            
        } catch{
//            currentWeatherDelegate?.errorFetchingWeather(error: error)
            return nil
        }
    }
    
}
