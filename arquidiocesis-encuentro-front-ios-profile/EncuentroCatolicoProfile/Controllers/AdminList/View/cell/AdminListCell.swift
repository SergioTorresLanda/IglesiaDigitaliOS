//
//  AdminListCell.swift
//  EncuentroCatolicoProfile
//
//  Created by 4n4rk0z on 06/05/21.
//

import UIKit

class AdminListCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAdmin: UILabel!
    @IBOutlet weak var imgDelete: UIImageView!
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var starImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 0
//                                   , right: 0)
//        contentView.frame = contentView.frame.inset(by: margins)
//    }
    
    private func initUI() {
        imgDelete.isHidden = true
        containerView.roundCorners(radius: 5, cornersToRound: .allCorners)
        nextImage.image = UIImage(named: "arrow_right", in: Bundle.local, compatibleWith: nil)
        lblName.adjustsFontSizeToFitWidth = true
        lblAdmin.adjustsFontSizeToFitWidth = true
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
