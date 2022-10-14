//
//  PrincipalComponentsSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

extension PrincipalViewSOS: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "SOSCELLP", for: indexPath) as! PrincipalSOSCell
        cell.cardView.layer.cornerRadius = 15
        //        cell.lblTitle1.text = dataSource[indexPath.row].name ?? ""
        //        cell.lblSubtitle.text = dataSource[indexPath.row].description ?? ""
        
        cell.lblTitle.text = titlesArray[indexPath.row]
        cell.lblSubTitle.text = subTitArray[indexPath.row]
        cell.cardView.ShadowCard()
        cell.cardView.backgroundColor = .white
        cell.circleFill.alpha = 0
        print("Este es el index: ", indexPath.row, indexCircle)
        
        if cleanAll == false {
            if indexPath.row == indexCircle {
                stateCell[indexPath.row] = true
                cell.circleFill.alpha = 1
                selctedCell = indexPath.row
                
            }
            
        }else{
            print("El clan all es true")
            selctedCell = 100
            
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            if selctedCell == indexPath.row {
                cleanAll = true
            }else{
                cleanAll = false
            }
        
        tableView.deselectRow(at: indexPath, animated: false)
        stateCell[0] = false
        stateCell[1] = false
        print(stateCell)

        indexCircle = indexPath.row
        mainTable.reloadData()        
        alert2 = InputAlertController.showAlertInput(index: indexPath.row, controller: self)
        let singleton = PrincipalViewSOS.singleton
        singleton.nameService = titlesArray[indexPath.row]
        singleton.serviceID = idServices[indexPath.row]
        singleton.globalIndex = indexPath.row
        selectedId = idServices[indexPath.row]
        print(idServices[indexPath.row])

    }
    
}
