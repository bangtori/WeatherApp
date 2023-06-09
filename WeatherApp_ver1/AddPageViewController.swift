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
    var weatherManager = WeatherManager()
    
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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            city.remove(at: indexPath.row)
        }
    }
}

extension AddPageViewController : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherInfo) {
        //결과값이 있다면 데이터 저장
        let data = weather.name
        city.append(data)
        cityInputTextField.text = ""
        tableView.reloadData()
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
