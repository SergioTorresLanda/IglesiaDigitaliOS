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
        cell.userImg.borderImgColor(color: UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1), radius: cell.userImg.bounds.width / 2)
        print("%&/$", arrayResults[indexPath.row].relationship)
            if arrayResults[indexPath.row].relationship != nil {
                cell.btnFollow.setImage(UIImage(named: "iconFollow2", in: Bundle.local, compatibleWith: nil), for: .normal)
                cell.btnFollow.tintColor = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
                cell.btnFollow.setTitle("Dejar de seguir   ", for: .normal)
            }else{
                cell.btnFollow.setImage(UIImage(named: "iconFollow", in: Bundle.local, compatibleWith: nil), for: .normal)
                cell.btnFollow.tintColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
                cell.btnFollow.setTitle("Seguir   ", for: .normal)
            }
        cell.btnFollow.tag = indexPath.row
        cell.btnFollow.addTarget(self, action: #selector(TapFollow), for: .touchUpInside)
        cell.selectionStyle = .none
        
//        if isFollowing[indexPath.row] == false {
//            cell.btnFollow.setImage(UIImage(named: "icono-seguir-gris", in: Bundle.local, compatibleWith: nil), for: .normal)
//            cell.btnFollow.tintColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
//            cell.btnFollow.setTitle("Seguir   ", for: .normal)
//        }else{
//            cell.btnFollow.setImage(UIImage(named: "icono-seguir", in: Bundle.local, compatibleWith: nil), for: .normal)
//            cell.btnFollow.tintColor = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
//            cell.btnFollow.setTitle("Dejar de seguir   ", for: .normal)
//        }
        
        return cell
    }
    
    
}
