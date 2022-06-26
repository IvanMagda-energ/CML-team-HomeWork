//
//  File.swift
//  
//
//  Created by Иван Магда on 25.06.2022.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    func setupDetailController (data: PropertyData){
        nameLabel.text = data.name
        adressLabel.text = "\(data.country), " + "\(data.city), " + "\(data.street)"
        typeLabel.text = data.type
        statusLabel.text = data.status
        
    }
}

