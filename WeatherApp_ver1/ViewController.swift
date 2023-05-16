//
//  ViewController.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/04/30.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    var locationManger = CLLocationManager()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        locationManger.delegate = self
        weatherManager.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestLocation()
        locationManger.requestWhenInUseAuthorization()

        func setBackground(){
            let formatter = DateFormatter()
            formatter.dateFormat = "HH"
            let hourString = formatter.string(from: Date())
            let hourInt = Int(hourString)!
            if (6 <= hourInt) && (hourInt <= 18){
                //light background
                background.image = UIImage(named: "lightBackground")
            }else{
                background.image = UIImage(named: "darkBackground")
            }
        }
    }
}
    
extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherInfo) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.name
            self.temperatureLabel.text = "\(Int(weather.temp.temp - 273.15))°C"
            self.tempMaxLabel.text = "최고: \(Int(weather.temp.maxTemp - 273.15))°C"
            self.tempMinLabel.text = "최저: \(Int(weather.temp.minTemp - 273.15))°C"
        }
    }
    func didFailWithError(error: ErrorMessage) {
        DispatchQueue.main.async {
            self.showAlert(message: error.message)
        }
    }
    func showAlert(message:String){
        let alert = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
