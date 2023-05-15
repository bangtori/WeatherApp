//
//  WeatherInfo.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/05/11.
//

import Foundation

struct WeatherInfo:Codable{
    let weather:[Weather]
    let temp: Temp
    let name:String
    
    enum CodingKeys:String, CodingKey{
        case weather
        case temp = "main"
        case name
    }
}

struct Weather:Codable{
    let id:Int
    let main:String
    let description:String
    let icon:String
}
struct Temp:Codable{
    let temp:Double
    let feelsLike:Double
    let minTemp:Double
    let maxTemp:Double
    
    enum CodingKeys:String, CodingKey{
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}


struct ErrorMessage:Codable{
    let message:String
}
