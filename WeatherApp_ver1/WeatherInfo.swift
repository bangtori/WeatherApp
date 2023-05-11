//
//  WeatherInfo.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/05/11.
//

import Foundation

struct WeatherInfo:Codable{
    let weather : [Weatehr]
    let temp : Temp
    let name : String
    
    enum CodingKeys:String, CodingKey{
        case weather
        case temp = "main"
        case name
    }
}

struct Weatehr:Codable{
    let id : Int
    let main : String
    let descriptoin : String
    let icon : String
}

struct Temp:Codable{
    let temp : Double
    let minTemp : Double
    let maxTemp : Double
    
    enum CodingKeys : String, CodingKey{
        case temp
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

struct ErrorMessage:Codable{
    let message:String
}
