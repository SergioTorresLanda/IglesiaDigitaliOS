//
//  SliderCellView.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 18/10/21.
//

import UIKit
import EncuentroCatolicoProfile

protocol MyProtocolAction: AnyObject {
    func delete()
}

class SliderCellView: UICollectionViewCell {
        
//MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPray: UILabel!
    @IBOutlet weak var lblNumberPersons: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var handsIcon: UIImageView!
    @IBOutlet weak var btnOptions: UIButton!
    
    weak var delegate: MyProtocolAction?
    
// MARK: LIFE CYCLE CELL -
    override func awakeFromNib() {
        super.awakeFromNib()
        let profile = EditionPromisseDataManager.shareInstance.findByEmail(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
                if #available(iOS 13.0, *) {
                    userImg.image = profile.count > 0 ? HttpRequestSingleton.shareManager.convertBase64StringToImage(imageBase64String:  profile[0].image ?? "") : UIImage(named: "userImage",in: Bundle.local, with: nil)
                } else {
                    // Fallback on earlier versions
                }
    }
    
    func setupUIMenu(button: UIButton) {
        if #available(iOS 13.0, *) {
            let interaction = UIContextMenuInteraction(delegate: self)
            button.addInteraction(interaction)
        } else {
            // Fallback on earlier versions
        }
    }

}
