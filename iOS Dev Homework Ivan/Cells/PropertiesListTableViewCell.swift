//
//  PropertiesListTableViewCell.swift
//  iOS Dev Homework Ivan
//
//  Created by Иван Магда on 24.06.2022.
//

import UIKit

class PropertiesListTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var adresLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
}
    func setupCell (data: PropertyData){
        nameLabel.text = data.name
        adresLabel.text = "\(data.country), " + "\(data.city), " + "\(data.street)"
        typeLabel.text = data.type
        statusLabel.text = data.status
    }
}
