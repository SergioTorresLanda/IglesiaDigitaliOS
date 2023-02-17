//
//  FollowersTableViewCell.swift
//  Followers
//
//  Created by Billy on 25/01/22.
//

import UIKit

protocol FollowersCellProtocol: AnyObject{
    func actionSelected(follower: Followers?, and index: Int)
}

class FollowersTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var viewFollow: UIView!
    @IBOutlet weak var lblFollow: UILabel!
    @IBOutlet weak var iconFollow: UIImageView!
    
    weak var delegate: FollowersCellProtocol?
    
    var follower: Followers?
    var index: Int?
    
    func setData(follower: Followers, and index: Int){
        self.follower = follower
        self.index = index
        print("EL NOMBRE ES:::")
        print(follower.name)
        nameProfile.text = follower.name
        changeFollowed(isFollow: follower.isFollow)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(unFollow))
        viewFollow.addGestureRecognizer(tap)
        viewFollow.layer.cornerRadius = 10
        viewFollow.layer.shadowColor = UIColor.gray.cgColor
        viewFollow.layer.shadowOpacity = 0.5
        viewFollow.layer.shadowOffset = CGSize(width: 0, height: 3)
        viewFollow.layer.shadowRadius = 1
        
        imageProfile.layer.borderWidth = 0.5
        imageProfile.layer.borderColor = UIColor.black.cgColor
        imageProfile.clipsToBounds = true
        imageProfile.makeRounded()
        imageProfile.image = UIImage(named: "iconProfile", in: Bundle.local, compatibleWith: nil)
        imageProfile.loadS(urlS: follower.image)
    }
    
    @objc func unFollow(){
        print("unfollow")
        print("SE DEBERIA DE CAMBIAR EL ESTATUS")
        if follower?.isFollow ?? false{
            print("originalmente true")
            changeFollowed(isFollow: false)
            follower?.isFollow = false
            delegate?.actionSelected(follower: follower, and: index ?? 0)
        }else{
            print("originalmente false")
            changeFollowed(isFollow: true)
            follower?.isFollow = true
            delegate?.actionSelected(follower: follower, and: index ?? 0)
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
}
