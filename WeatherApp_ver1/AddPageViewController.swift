//
//  AddPageViewController.swift
//  WeatherApp_ver1
//
//  Created by 방유빈 on 2023/05/17.
//

import UIKit

class AddPageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var cityInputTextField: UITextField!
    let userDefaults = UserDefaults.standard
    var weatherManager = WeatherManager()
    
    var city:[String] = []{
        didSet{
            self.saveData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        weatherManager.delegate = self
        loadData()
    }
    @IBAction func addBtnClicked(_ sender: UIButton) {
        guard let searchCity = cityInputTextField.text else { return }
        weatherManager.fetchWeather(cityName: searchCity)
    }
    private func loadData(){
        guard let data = userDefaults.stringArray(forKey: "city") else { return }
        city = data
    }
    private func saveData(){
        userDefaults.set(city, forKey: "city")
        tableView.reloadData()
    }
}
extension AddPageViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        cell.textLabel?.text = city[indexPath.row]
        return cell
    }
}

extension AddPageViewController : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherInfo) {
        //결과값이 있다면 데이터 저장
        let data = weather.name
        city.append(data)
        cityInputTextField.text = ""
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
