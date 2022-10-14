//
//  EmptyFavComCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 10/09/21.
//

import UIKit

public protocol addCommunityEmptyFavButtonDelegate: AnyObject {
    
    func didPressaddCommunityEmptyFavButton(_ sender: UIButton)
}

class EmptyFavComCell: UITableViewCell {
    public weak var delegate: addCommunityEmptyFavButtonDelegate?
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnAgregar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        delegate?.didPressaddCommunityEmptyFavButton(sender)
    }
    
}
