//
//  newPrayerCell.swift
//  EncuentroCatolicoHome
//
//  Created by Branchbit on 23/03/21.
//

import UIKit
import EncuentroCatolicoProfile
import AlamofireImage

class newPrayerCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImg  : UIImageView!
    @IBOutlet weak var btnNewPrayer: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.makeCircular()
        btnNewPrayer.layer.cornerRadius = 10
        let profile = EditionPromisseDataManager.shareInstance.findByEmail(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
        if #available(iOS 13.0, *) {
            let url = UserDefaults.standard.string(forKey: "imageUrl")
            guard let fileUrl = URL(string: url ?? "") else { return  }
            profileImg.af.setImage(withURL: fileUrl)
            profileImg.image = profile.count > 0 ? HttpRequestSingleton.shareManager.convertBase64StringToImage(imageBase64String:  profile[0].image ?? "") : UIImage(named: "userImage",in: Bundle.local, with: nil)
        } else {
            // Fallback on earlier versions
        }
        profileImg.contentMode = .scaleAspectFill
    }

}
