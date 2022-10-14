//
//  FeedTVC.swift
//  EncuentroCatolicoMasses
//
//  Created by Diego Martinez on 26/02/21.
//

import UIKit

class FeedTVC: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerImage: UIView!
    @IBOutlet weak var lblContent: CustomLabel!
    @IBOutlet weak var imageLive: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        containerImage.layer.masksToBounds = true
        containerImage?.layer.cornerRadius = 10
        lblContent.text = "Misa dominical vespertina"
        lblName.text = "Basílica de Guadalupe"
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
