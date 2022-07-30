//
//  FutureWeatherModel.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import Foundation

struct FutureWeatherModel:Decodable{
    let lists: [weatherModel]
}

struct weatherModel:Decodable{
    let dt: Int
    let main: MainTemp
    let weather: [WeatherDescriptionModel]
}

struct MainTemp:Decodable{
    let temp: Double
}

struct WeatherDescriptionModel: Decodable{
    let main: String
}
