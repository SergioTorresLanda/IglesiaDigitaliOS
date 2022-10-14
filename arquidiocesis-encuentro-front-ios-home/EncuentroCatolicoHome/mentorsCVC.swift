//
//  mentorsCVC.swift
//  EncuentroCatolicoHome
//
//  Created by Desarrollo on 25/03/21.
//

import UIKit

class mentorsCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgView      : UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var lblRole      : UILabel!
    @IBOutlet weak var lblStudents  : UILabel!
    @IBOutlet weak var lblCourses   : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.makeCircular()
        backgroundImg.layer.cornerRadius = 10
    }

}
