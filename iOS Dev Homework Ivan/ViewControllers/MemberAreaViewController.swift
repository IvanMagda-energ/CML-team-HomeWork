//
//  MemberAreaViewController.swift
//  iOS Dev Homework Ivan
//
//  Created by Иван Магда on 25.06.2022.
//

import Foundation
import UIKit
import Alamofire

class MemberAreaViewController: UIViewController {
    @IBOutlet weak var propertiesTableView: UITableView!
    
    var propertyDataArray: [PropertyData] = []
    
    let networkClient = NetworkClient.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.propertiesTableView.delegate = self
        self.propertiesTableView.dataSource = self
        
        let cellNib = UINib(nibName: "PropertiesListTableViewCell", bundle: nil)
        propertiesTableView.register(cellNib, forCellReuseIdentifier: "PropertiesListTableViewCell")
        
        networkClient.getCurrentUserRequest { result in
            switch result {
            case .success(let user):
                self.networkClient.getAllPropertiesRequest(accountId: user.accountId) { result in
                    switch result {
                    case .success(let propertiesModel):
                        DispatchQueue.main.async {
                            self.propertyDataArray = propertiesModel.data
                            self.propertiesTableView.reloadData()
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Attention", message: "Error response from server", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Attention", message: "Error response from server", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
extension MemberAreaViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = propertiesTableView.dequeueReusableCell(withIdentifier: "PropertiesListTableViewCell") as? PropertiesListTableViewCell{
            let data = self.propertyDataArray[indexPath.row]
            cell.setupCell(data: data)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController{
            let data = self.propertyDataArray[indexPath.row]
            detailsViewController.data = data
            navigationController?.pushViewController(detailsViewController, animated: true)
            
        }
    }
}
