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
        //cell.userImg.makeRounded()
        cell.index=indexPath.row
        cell.setBtnDesign()
        cell.setUser(user:arrayResults[indexPath.row])
        cell.delegate = self
        cell.btnfollowV.tag = indexPath.row
        //cell.btnFollowV.addTarget(self, action: #selector(TapFollow), for: .touchUpInside)
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
