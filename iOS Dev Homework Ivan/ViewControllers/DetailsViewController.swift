//
//  File.swift
//  
//
//  Created by Иван Магда on 25.06.2022.
//

import Foundation
import UIKit
class DetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
     
    var data: PropertyData?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDetailsController()
    }
    
    func setupDetailsController (){
        guard let data = data else {
            return
        }
        nameLabel.text = data.name 
        adressLabel.text = "\(data.country), " + "\(data.city), " + "\(data.street)"
        typeLabel.text = data.type
        statusLabel.text = data.status
        
    }
}

