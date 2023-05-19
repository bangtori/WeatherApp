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
    @IBOutlet weak var pageControl: UIPageControl!
    
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
        loadData()
        setPageController()
        
    }

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
    func setPageController(){
        print(city)
        pageControl.numberOfPages = city.count + 1
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.green
    }
    @IBAction func pageChange(_ sender: UIPageControl) {
        if pageControl.currentPage != 0 {
            print(pageControl.currentPage)
            weatherManager.fetchWeather(cityName: city[pageControl.currentPage-1])
        }else{
            locationManger.requestLocation()
        }
    }
}
    
extension ViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherInfo) {
        DispatchQueue.main.async {
            let url = URL(string: "https://openweathermap.org/img/wn/\(weather.weather.first?.icon ?? "00")@2x.png")
            let data = try? Data(contentsOf: url!)
            if let data = data {
                self.weatherIcon.image = UIImage(data: data)
            }
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
