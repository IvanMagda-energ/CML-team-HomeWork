//
//  MemberAreaViewController.swift
//  iOS Dev Homework Ivan
//
//  Created by Иван Магда on 25.06.2022.
//

import Foundation
import UIKit

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
                        print("error")
                    }
                }
            case .failure(let error):
                print("error")
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
        return 157.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
            let data = self.propertyDataArray[indexPath.row]
            detailViewController.data = data
            navigationController?.pushViewController(detailViewController, animated: true)
            
        }
    }
}
