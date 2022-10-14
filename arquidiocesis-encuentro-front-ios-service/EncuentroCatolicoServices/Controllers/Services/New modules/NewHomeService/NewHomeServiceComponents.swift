//
//  NewHomeServiceComponents.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import Foundation
import UIKit

//CELLHOMESERVICE
extension NewHomeServiceView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLHOMESERVICE", for: indexPath) as! HomeServiceTableCell
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.ShadowCard()
        cell.lblSection.text = arraySections[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if arraySections[indexPath.row] == "Servicios" {
            let view = ListServiceRouter.createModule()
            self.navigationController?.pushViewController(view, animated: true)
        }else{
            let view = NewListIntentionsRouter.createModule()
            self.navigationController?.pushViewController(view, animated: true)
        }
        
    }
    
    
}
