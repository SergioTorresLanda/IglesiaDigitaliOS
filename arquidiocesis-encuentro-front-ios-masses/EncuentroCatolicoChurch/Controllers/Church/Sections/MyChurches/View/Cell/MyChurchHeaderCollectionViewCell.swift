//
//  MyChurchHeaderCollectionViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Cruz on 03/05/21.
//

import UIKit

protocol ChangeChourchButtonDelegate: AnyObject {
    func didPressChangeButton(_ tag: Int)
}
class MyChurchHeaderCollectionViewCell: UICollectionViewCell {
    weak var delegate: ChangeChourchButtonDelegate!
    @IBOutlet weak var changeChurch: UIButton!
    static let reuseIdentifier = "MyChurchHeaderCollectionViewCell"
    @IBOutlet var titleSection: UILabel!
   
    static let nib = UINib(nibName: MyChurchHeaderCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: MyChurchHeaderCollectionViewCell.self))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func changeAction(_ sender: UIButton) {
        self.delegate?.didPressChangeButton(sender.tag)
    }
    
}
