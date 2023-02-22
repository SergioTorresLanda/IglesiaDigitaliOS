//
//  followCell.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import UIKit
protocol followCellProtocol: AnyObject{
    func actionSelected(index: Int)
}

class followCell: UITableViewCell {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnFollow: UIButton!
    @IBOutlet weak var btnfollowV: UIView!
    @IBOutlet weak var iconFollow: UIImageView!
    @IBOutlet weak var lblFollow: UILabel!
    
    weak var delegate: followCellProtocol?
    var fll = false
    var index: Int?
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func followClick(_ sender: Any) {
        print("BB")
    }
    
    func setBtnDesign(){
        btnfollowV.layer.cornerRadius = 10
        btnfollowV.layer.shadowColor = UIColor.gray.cgColor
        btnfollowV.layer.shadowOpacity = 0.5
        btnfollowV.layer.shadowOffset = CGSize(width: 0, height: 3)
        btnfollowV.layer.shadowRadius = 1
        let tap = UITapGestureRecognizer(target: self, action: #selector(unFollow))
        btnfollowV.addGestureRecognizer(tap)
    }
    
    func setUser(user:ResultsSearch){
        if user.relationship != nil{
            print("RELATIONSHIP NO niL")
            print(user.relationship?.statusId ?? 5)
            if user.relationship?.statusId == 1 || user.relationship?.statusId == 3 {
                fll=true
                changeFollowed(isFollow:true)
            }else{
                fll=false
                changeFollowed(isFollow:false)
            }
        }else{
            print("RELATIONSHIP niL")
            fll=false
            changeFollowed(isFollow:false)
        }
        userImg.loadS(urlS: user.image ?? "")
        lblName.text = user.name ?? ""
        lblName.adjustsFontSizeToFitWidth = true
    }
    
    @objc func unFollow(){
        print("unfollow")
        print("SE DEBERIA DE CAMBIAR EL ESTATUS")
        if fll{
            print("originalmente true")
            changeFollowed(isFollow: false)
            fll = false
            delegate?.actionSelected(index:index ?? 0)
        }else{
            print("originalmente false")
            fll = true
            changeFollowed(isFollow: true)
            delegate?.actionSelected(index:index ?? 0)
        }
    }
    
    func changeFollowed(isFollow: Bool){
        print("changefollowed")
 
        if !isFollow{
            lblFollow.text = "Seguir"
            lblFollow.textColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1.0)
            iconFollow.image = UIImage(named: "iconFollow", in: Bundle.local, compatibleWith: nil)
        }else{
            lblFollow.text = "Siguiendo"
            lblFollow.textColor = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1.0)
            iconFollow.image = UIImage(named: "iconFollow2", in: Bundle.local, compatibleWith: nil)
        }
   
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
