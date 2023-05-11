//
//  WeatherApp++Bundle.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/05/11.
//

import Foundation

extension Bundle {
    var apiKey:String{
        guard let file = self.path(forResource: "KeyList", ofType: "plist")else{
            fatalError("Couldn't find file 'KeyList.plist'.")
        }
        guard let plist = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = plist["OPENWEATHERMAP_KEY"] as? String else {
            fatalError("Couldn't find key 'OPENWEATHERMAP_KEY' in 'KeyLisy.plist'.")
        }
        return key
    }
}
