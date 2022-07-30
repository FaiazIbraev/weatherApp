//
//  CurrentWeatherData.swift
//  WeatherApp
//
//  Created by Faiaz Ibraev on 30/7/22.
//

import UIKit

struct CurrentWeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coordinates
}

struct Coordinates: Decodable{
    let lon: Double
    let lat: Double
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let id: Int
}
