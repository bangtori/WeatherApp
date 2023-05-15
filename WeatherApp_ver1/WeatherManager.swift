//
//  WeatherManager.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/05/15.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather:WeatherInfo)
    func didFailWithError(error: ErrorMessage)
}
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Bundle.main.apiKey)"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            session.dataTask(with: url){ data, response, error in
                let successRange = (200..<300)
                guard let data = data, error == nil else{ return }
                let decoder = JSONDecoder()
                if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode){
                    guard let weatherInformation = try? decoder.decode(WeatherInfo.self, from: data) else { return }

                    DispatchQueue.main.async {
                        delegate?.didUpdateWeather(self, weather: weatherInformation)
                    }
                }else{
                    guard let errorMessage = try? decoder.decode(ErrorMessage.self, from: data) else { return }
                    DispatchQueue.main.async {
                        delegate?.didFailWithError(error: errorMessage)
                    }
                }
                
            }.resume()
        }
    }
}
