//
//  PriestPSOSComponents.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

extension PriestPSOSView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segementControl.selectedSegmentIndex {
        case 0:
            return listRequests.count
        default:
            return listRequests.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLPRIEST", for: indexPath) as! PriestPTableCell
        cell.backgroundColor = .clear
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.ShadowCard()
        
        switch segementControl.selectedSegmentIndex {
        case 0:
            
            cell.lblServiceTitle.text = listRequests[indexPath.row].service?.name
            cell.lblFaithfulName.text = listRequests[indexPath.row].devotee?.name
            if listRequests[indexPath.row].sub_status == nil {
                
                switch listRequests[indexPath.row].status {
                case "PENDING_CONFIRMATION":
                    cell.lblStatusService.text = "POR ACEPTAR"
                    
                case "SUCCESSFULLY":
                    cell.lblStatusService.text = "CON ÉXITO"
                    
                case "UNSUCCESSFULLY":
                    cell.lblStatusService.text = "SIN ÉXITO"
                    
                case "ACCEPTED":
                    cell.lblStatusService.text = "ACEPTADO"
                    
                case "REJECTED":
                    cell.lblStatusService.text = "RECHAZADO"
                    
                case "COMPLETED":
                    cell.lblStatusService.text = "COMPLETADO"
                    
                case "CANCELLED":
                    cell.lblStatusService.text = "CANCELADO"
                    
                case "CALL_WAITING":
                    cell.lblStatusService.text = "ESPERANDO LLAMADA"
                    
                case "CALL_FINISHED":
                    cell.lblStatusService.text = "LLAMADA TERMINADA"
                    
                case "LOOKING_FOR_ASSISTANCE":
                    cell.lblStatusService.text = "BUSCANDO AYUDA"
                    
                case "HELP_ON_THE_WAY":
                    cell.lblStatusService.text = "AYUDA EN CAMINO"
                    
                    
                default:
                    print("def")
                }
                
            }else{
                
                switch listRequests[indexPath.row].sub_status {
                case "PENDING_CONFIRMATION":
                    cell.lblStatusService.text = "POR ACEPTAR"
                    
                case "SUCCESSFULLY":
                    cell.lblStatusService.text = "CON ÉXITO"
                    
                case "UNSUCCESSFULLY":
                    cell.lblStatusService.text = "SIN ÉXITO"
                    
                case "ACCEPTED":
                    cell.lblStatusService.text = "ACEPTADO"
                    
                case "REJECTED":
                    cell.lblStatusService.text = "RECHAZADO"
                    
                case "COMPLETED":
                    cell.lblStatusService.text = "COMPLETADO"
                    
                case "CANCELLED":
                    cell.lblStatusService.text = "CANCELADO"
                    
                case "CALL_WAITING":
                    cell.lblStatusService.text = "ESPERANDO LLAMADA"
                    
                case "CALL_FINISHED":
                    cell.lblStatusService.text = "LLAMADA TERMINADA"
                    
                case "LOOKING_FOR_ASSISTANCE":
                    cell.lblStatusService.text = "BUSCANDO AYUDA"
                    
                case "HELP_ON_THE_WAY":
                    cell.lblStatusService.text = "AYUDA EN CAMINO"
                    
                    
                default:
                    print("def")
                }
                
            }
           
            
            return cell
            
        default:
            cell.lblServiceTitle.text = listRequests[indexPath.row].service?.name
            cell.lblFaithfulName.text = listRequests[indexPath.row].devotee?.name
            if listRequests[indexPath.row].sub_status == nil {
                switch listRequests[indexPath.row].status {
                case "PENDING_CONFIRMATION":
                    cell.lblStatusService.text = "POR ACEPTAR"
                    
                case "SUCCESSFULLY":
                    cell.lblStatusService.text = "CON ÉXITO"
                    
                case "UNSUCCESSFULLY":
                    cell.lblStatusService.text = "SIN ÉXITO"
                    
                case "ACCEPTED":
                    cell.lblStatusService.text = "ACEPTADO"
                    
                case "REJECTED":
                    cell.lblStatusService.text = "RECHAZADO"
                    
                case "COMPLETED":
                    cell.lblStatusService.text = "COMPLETADO"
                    
                case "CANCELLED":
                    cell.lblStatusService.text = "CANCELADO"
                    
                case "CALL_WAITING":
                    cell.lblStatusService.text = "ESPERANDO LLAMADA"
                    
                case "CALL_FINISHED":
                    cell.lblStatusService.text = "LLAMADA TERMINADA"
                    
                case "LOOKING_FOR_ASSISTANCE":
                    cell.lblStatusService.text = "BUSCANDO AYUDA"
                    
                case "HELP_ON_THE_WAY":
                    cell.lblStatusService.text = "AYUDA EN CAMINO"
                    
                    
                default:
                    print("def")
                }
            }else{
                
                switch listRequests[indexPath.row].sub_status {
                case "PENDING_CONFIRMATION":
                    cell.lblStatusService.text = "POR ACEPTAR"
                    
                case "SUCCESSFULLY":
                    cell.lblStatusService.text = "CON ÉXITO"
                    
                case "UNSUCCESSFULLY":
                    cell.lblStatusService.text = "SIN ÉXITO"
                    
                case "ACCEPTED":
                    cell.lblStatusService.text = "ACEPTADO"
                    
                case "REJECTED":
                    cell.lblStatusService.text = "RECHAZADO"
                    
                case "COMPLETED":
                    cell.lblStatusService.text = "COMPLETADO"
                    
                case "CANCELLED":
                    cell.lblStatusService.text = "CANCELADO"
                    
                case "CALL_WAITING":
                    cell.lblStatusService.text = "ESPERANDO LLAMADA"
                    
                case "CALL_FINISHED":
                    cell.lblStatusService.text = "LLAMADA TERMINADA"
                    
                case "LOOKING_FOR_ASSISTANCE":
                    cell.lblStatusService.text = "BUSCANDO AYUDA"
                    
                case "HELP_ON_THE_WAY":
                    cell.lblStatusService.text = "AYUDA EN CAMINO"
                    
                    
                default:
                    print("def")
                }
            }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let singlto = UncionSOSView.singleton
        if segementControl.selectedSegmentIndex == 0 {
            let singleton = PriestPSOSView.singleton
            singleton.idService = listRequests[indexPath.row].id ?? 0//singlto.newServiceID//379
            print("Este es le:", singleton.idService)
            let module = PriestContactRouter.createModule()
            self.navigationController?.pushViewController(module, animated: true)
//            let module = PriestDetailRouter.createModule()
//            self.navigationController?.pushViewController(module, animated: true) // Testing
            
        }else{

            let singleton = PriestPSOSView.singleton
            singleton.idService = listRequests[indexPath.row].id ?? 0//379//listHistory[indexPath.row].service?.id ?? 0
            let module = PriestDetailRouter.createModule()
            self.navigationController?.pushViewController(module, animated: true)
        }

    }
    
}
