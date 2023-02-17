//
//  SocialSearchComponents.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
extension SocialSearchView: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FOLLOWCELL", for: indexPath) as! followCell
        cell.lblName.text = arrayResults[indexPath.row].name ?? ""
        cell.lblName.adjustsFontSizeToFitWidth = true
        cell.userImg.loadS(urlS: arrayResults[indexPath.row].image ?? "")
        //cell.userImg.layer.borderWidth = 1
        let blueEncuentro = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)

        cell.userImg.borderImgColor(color: blueEncuentro, radius: cell.userImg.bounds.width / 2)
        //print("%&/$", arrayResults[indexPath.row].relationship)
            if arrayResults[indexPath.row].relationship != nil {
                cell.fll=true
                cell.btnFollow.setImage(UIImage(named: "iconFollow2", in: Bundle.local, compatibleWith: nil), for: .normal)
                cell.btnFollow.tintColor = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
                cell.btnFollow.setTitle(" Siguiendo ", for: .normal)
            }else{
                cell.fll=false
                cell.btnFollow.setImage(UIImage(named: "iconFollow", in: Bundle.local, compatibleWith: nil), for: .normal)
                cell.btnFollow.tintColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
                cell.btnFollow.setTitle(" Seguir ", for: .normal)
            }
        cell.btnFollow.tag = indexPath.row
        cell.btnFollow.addTarget(self, action: #selector(TapFollow), for: .touchUpInside)
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var bool=false
        if arrayResults[indexPath.row].relationship != nil {
         bool=true
        }
        let user = UserBasic(id: arrayResults[indexPath.row].id, name: arrayResults[indexPath.row].name, image: arrayResults[indexPath.row].image, follow:bool, type:arrayResults[indexPath.row].type)
        self.navigationController?.pushViewController(FollowersWireFrame.createFollowersModule(user: user), animated: false)
    }
}
