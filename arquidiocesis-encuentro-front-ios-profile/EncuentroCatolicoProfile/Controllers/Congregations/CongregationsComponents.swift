//
//  CongregationsComponents.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import Foundation
import UIKit

extension CongregationsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isSearch {
        case true:
            return searchList.count
        default:
            return congregationsList.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLCONG", for: indexPath) as! CongregationCell
        cell.selectionStyle = .none
        switch isSearch {
        case true:
            cell.lblName.text = searchList[indexPath.row]
        default:
            cell.lblName.text = congregationsList[indexPath.row].descripcion
        }
        
        
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleton = CongregationsView.singleton
        switch isSearch {
        case true:
            singleton.selectedCong = searchList[indexPath.row]
            singleton.selectedID = searchID[indexPath.row]
            
        default:
            singleton.selectedCong = congregationsList[indexPath.row].descripcion ?? ""
            singleton.selectedID = congregationsList[indexPath.row].id ?? 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
