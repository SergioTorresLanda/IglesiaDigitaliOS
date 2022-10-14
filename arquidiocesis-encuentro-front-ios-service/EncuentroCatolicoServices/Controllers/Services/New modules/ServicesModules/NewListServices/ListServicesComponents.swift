//
//  ListServicesComponents.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import Foundation
import UIKit

extension ListServicesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if state != "List" {
            
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DATEHISTORYCELL", for: indexPath) as! dateHistoryCell
                
                    cell.selectionStyle = .none
                    // let dat = getDate(str: arrayServices[indexPath.row])
                    let dat = getDate(str: arrayList[indexPath.row].creation_date ?? "Unspecified")
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = .init(identifier: "Es_MX")
                    dateFormatter.dateFormat = "dd MMMM yyyy" //EEEE, MMM d, yyyy
                    if dat != nil {
                        cell.lblDate.text = dateFormatter.string(from: dat ?? Date()).capitalized
                    }
                
                return cell
            default:
                
                if arrayList[indexPath.row].creation_date?.prefix(10) == arrayList[indexPath.row - 1].creation_date?.prefix(10) {
                    
                    let cell2 = tableView.dequeueReusableCell(withIdentifier: "CELLDETAIL", for: indexPath) as! ListDetailCell
                    
                    cell2.selectionStyle = .none
                    cell2.cardView.layer.cornerRadius = 10
                    cell2.cardView.ShadowCard()
                    
                    cell2.lblNameService.text = arrayList[indexPath.row].service?.name
                    cell2.lblName.text = "\(arrayList[indexPath.row].devotee?.name ?? "Unspecified") \(arrayList[indexPath.row].devotee?.fist_surname ?? "")"
                    
                    switch arrayList[indexPath.row].status {
                    case "PENDING_CONFIRMATION":
                        cell2.lblStatus.text = "Por confirmar"
                        
                    case "ACCEPTED":
                        cell2.lblStatus.text = "Aceptado"
                        
                    case "COMPLETED":
                        cell2.lblStatus.text = "Concluido"
                        
                    case "REJECTED" :
                        cell2.lblStatus.text = "Rechazado"
                        
                    case "CANCELLED" :
                        cell2.lblStatus.text = "Cancelado"
                        
                    default:
                        break
                    }
                        
                    return cell2
                    
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DATEHISTORYCELL", for: indexPath) as! dateHistoryCell
                    
                        cell.selectionStyle = .none
                        // let dat = getDate(str: arrayServices[indexPath.row])
                        let dat = getDate(str: arrayList[indexPath.row].creation_date ?? "Unspecified")
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = .init(identifier: "Es_MX")
                        dateFormatter.dateFormat = "dd MMMM yyyy" //EEEE, MMM d, yyyy
                        if dat != nil {
                            cell.lblDate.text = dateFormatter.string(from: dat ?? Date()).capitalized
                        }
                    
                    return cell
                }
            }
            
        }else{
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CELLDETAIL", for: indexPath) as! ListDetailCell
            
            cell2.selectionStyle = .none
            cell2.cardView.layer.cornerRadius = 10
            cell2.cardView.ShadowCard()
            
            cell2.lblNameService.text = arrayList[indexPath.row].service?.name
            cell2.lblName.text = "\(arrayList[indexPath.row].devotee?.name ?? "Unspecified") \(arrayList[indexPath.row].devotee?.fist_surname ?? "")"
            
            switch arrayList[indexPath.row].status {
            case "PENDING_CONFIRMATION":
                cell2.lblStatus.text = "Por confirmar"
                
            case "ACCEPTED":
                cell2.lblStatus.text = "Aceptado"
                
            case "COMPLETED":
                cell2.lblStatus.text = "Concluido"
                
            case "REJECTED" :
                cell2.lblStatus.text = "Rechazado"
                
            case "CANCELLED" :
                cell2.lblStatus.text = "Cancelado"
                
            default:
                break
            }
            return cell2
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrayList[indexPath.row].service?.name ?? "" == "Bendecir casa" {
           // state = "OTHER"
        }
        
        let view = NewDetailServiceRoutrer.createModule(nameService: arrayList[indexPath.row].service?.name ?? "Unspecified", typeV: state, idService: arrayList[indexPath.row].id ?? 0)
        self.navigationController?.pushViewController(view, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        var actions = [UITableViewRowAction]()

        if state != "List" {
            let delete = UITableViewRowAction(style: .destructive, title: "Eliminar") { _, indexPath in

                print("borra esta row \(indexPath.row)")
                self.deleteIndex = indexPath.row
                self.presenter?.makeDelete(servieID: "\(self.arrayList[indexPath.row].id ?? 1)")

            }

            actions.append(delete)

        }

        return actions
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                // Aqui puedes poner codigo para ejecutar cuando termina de cargar la tabla
            }
        }
    }
    
    func getDate(str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: str) // replace Date String
    }
    
}

