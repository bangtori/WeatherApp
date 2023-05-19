//
//  City.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/05/19.
//

import Foundation

let userDefaults = UserDefaults.standard
var city:[String] = [String](){
    didSet{
        saveData()
    }
}
func loadData(){
    guard let data = userDefaults.stringArray(forKey: "city") else { return }
    city = data
}
func saveData(){
    userDefaults.set(city, forKey: "city")
}
