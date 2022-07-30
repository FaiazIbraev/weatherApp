//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import UIKit

struct CurrentWeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let long: Double
    let lan: Double
    
    var temperatureString: String{
        return String (format: "%.0f", temperature) //formatirovanie double v string bez cifr posle tochki
    }
    var conditionName: String{
        switch conditionId{
        case 200...232 :
            return "cloud.bolt"
        case 300...321 :
            return "cloud.drizzle"
        case 801...804 :
            return "cloud.bolt"
        case 500...531 :
            return "cloud.rain"
        case 600...622 :
            return "cloud.snow"
        case 701...781 :
            return "cloud.fog"
        case 800:
            return "sun max"
        default:
            return "cloud"
        }
    }
}

struct FutureWeatherModelToShow{
    let temp: Double
    let dateSeconds: Int
    let weatherDesc: String
}
