//
//  AddressTableViewCell.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 05/10/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import UIKit
import MapKit

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    static let reuseIdentifier = "AddressTableViewCell"
    static let nib = UINib(nibName: AddressTableViewCell.reuseIdentifier, bundle: Bundle(for: AddressTableViewCell.self))
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(with address: MKLocalSearchCompletion) {
        titleLabel.text = address.title
        subtitleLabel.text = address.subtitle
    }
    
    func fill(with address: MKMapItem) {
        titleLabel.text = address.placemark.name
        subtitleLabel.text = address.placemark.title
    }
    
}
