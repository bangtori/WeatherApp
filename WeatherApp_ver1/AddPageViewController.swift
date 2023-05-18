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
    
    var city:[String] = ["Seoul"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    @IBAction func addBtnClicked(_ sender: UIButton) {
    }
    
}
extension AddPageViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("dd")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)

        cell.textLabel?.text = city[indexPath.row]
        return cell
    }
}
