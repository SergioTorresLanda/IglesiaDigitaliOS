//
//  prayerCell.swift
//  Cadena de Oracion
//
//  Created by Branchbit on 22/03/21.
//

import UIKit
import EncuentroCatolicoProfile

class prayerCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName  : UILabel!
    @IBOutlet weak var lblTime  : UILabel!
    @IBOutlet weak var lblPrayer: UILabel!
    @IBOutlet weak var btnPeople: UIButton!
    @IBOutlet weak var imgIcon  : UIImageView!
    @IBOutlet weak var cellView : UIView!
    @IBOutlet weak var loading : UIActivityIndicatorView!
    @IBOutlet public weak var reactionImage: UIImageView!
    @IBOutlet public weak var reactionImage2: UIImageView!
    @IBOutlet public weak var prayLabel: UILabel!
    @IBOutlet public weak var lblStatus: UILabel!
    @IBOutlet weak var btnPersonsPraying: UIButton!
    @IBOutlet weak var btnPray: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loading.isHidden = true
        imgIcon.makeCircular()
        let profile = EditionPromisseDataManager.shareInstance.findByEmail(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
        if #available(iOS 13.0, *) {
            imgIcon.image = profile.count > 0 ? HttpRequestSingleton.shareManager.convertBase64StringToImage(imageBase64String:  profile[0].image ?? "") : UIImage(named: "userImage",in: Bundle.local, with: nil)
        } else {
            // Fallback on earlier versions
        }
        imgIcon.contentMode = .scaleAspectFill
    }

}
