//
//  ViewController.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/04/30.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    var locationManger = CLLocationManager()
    var lat:Double = 37.541
    var lon:Double = 126.986
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        // 위치 정보 받아오기
        locationManger.delegate = self
        // 거리 정확도 설정
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        // 사용자에게 허용 받기 alert 띄우기
        locationManger.requestWhenInUseAuthorization()
        // 아이폰 설정에서의 위치 서비스가 켜진 상태라면
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManger.startUpdatingLocation() //위치 정보 받아오기 시작
        } else {
            print("위치 서비스 Off 상태")
        }
    }
    func setBackground(){
        var formatter = DateFormatter()
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
    // 위치 정보 계속 업데이트 -> 위도 경도 받아옴
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            print("위도: \(lat)")
            print("경도: \(lon)")
            
        }
    }
    // 위도 경도 받아오기 에러
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

}

