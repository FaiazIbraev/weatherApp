//
//  FutureWeatherModel.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import Foundation

struct FutureWeatherModel:Codable{
    let list: [WeatherModel]
}

struct WeatherModel:Codable{
    let dt: Int
    let main: MainTemp
    let weather: [WeatherDescriptionModel]
}

struct MainTemp:Codable{
    let temp: Double
}

struct WeatherDescriptionModel: Codable{
    let main: String
}
