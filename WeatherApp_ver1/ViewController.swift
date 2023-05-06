//
//  ViewController.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/04/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        // Do any additional setup after loading the view.
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

}

