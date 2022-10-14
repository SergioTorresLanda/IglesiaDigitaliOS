//
//  HomeComponents.swift
//  EncuentroCatolicoHome
//
//  Created by Diego Martinez on 23/02/21.
//

import UIKit
import EncuentroCatolicoProfile
import EncuentroCatolicoPrayers
import EncuentroCatolicoServices
import EncuentroCatolicoMasses
import EncuentroCatolicoNews
import EncuentroCatolicoLive
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoChurch
import EncuentroCatolicoMyChurch
import EncuentroCatolicoNewFormation

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: Distribution
        
        switch indexPath.row {
        case 0:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Red Social"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8615", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8615", in: Bundle.local, compatibleWith: nil)
            }
            
            cell.containerButton.layer.cornerRadius = 10
            //  cell.containerButton.addShadow()
            
            return cell
        case 1:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Mi Iglesia"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8611", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8611", in: Bundle.local, compatibleWith: nil)
            }
            cell.containerButton.layer.cornerRadius = 10
            // cell.containerButton.addShadow()
            
            return cell
        case 2:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Comunidades"
            cell.lblFrameworkName.adjustsFontSizeToFitWidth = true
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8612", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8612", in: Bundle.local, compatibleWith: nil)
            }
            cell.containerButton.layer.cornerRadius = 10
            // cell.containerButton.addShadow()
            return cell
        case 3:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            
            cell.lblFrameworkName.text = "Servicios"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8613", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8613", in: Bundle.local, compatibleWith: nil)
            }
            cell.containerButton.layer.cornerRadius = 10
            // cell.containerButton.addShadow()
            return cell
        case 4:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Oraciones"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8616", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8616", in: Bundle.local, compatibleWith: nil)
            }
            cell.containerButton.layer.cornerRadius = 10
            // cell.containerButton.addShadow()
            
            return cell
        case 5:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Biblioteca Virtual"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8614", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8614", in: Bundle.local, compatibleWith: nil)
            }
            
            cell.containerButton.layer.cornerRadius = 10
            // cell.containerButton.addShadow()
            
            return cell
        case 6:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Cadena de oración"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8617", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8617", in: Bundle.local, compatibleWith: nil)
            }
            
            cell.containerButton.layer.cornerRadius = 10
            //  cell.containerButton.addShadow()
            return cell
        default:
            let cell = homeCV.dequeueReusableCell(withReuseIdentifier: "HomeCV", for: indexPath) as! HomeCV
            
            cell.lblFrameworkName.text = "Oraciones"
            
            cell.imageMenu.image  = UIImage(named:"oraciones", in: Bundle.local, compatibleWith: nil)
            cell.containerButton.layer.cornerRadius = 10
            //  cell.containerButton.addShadow()
            
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let instance = SocialNetworkConstant.shared.instance
            let view =  SocialNetworkNews.openSocialNetowrk(firebaseApp: instance)
            self.navigationController?.pushViewController(view, animated: true)
            
//            let view = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Esta sección se trabajara con la gente de Banco Azteca")
//            self.present(view, animated: true, completion: nil)
        case 1:
            let view = MyChurchesWireFrame.getController()
            self.navigationController?.pushViewController(view, animated: true)
        case 2:
            let view = MyCommunitiesMainViewwWireFrame.getController()
            self.navigationController?.pushViewController(view, animated: true)
            
        case 3:
            let view = HomeServiceWireFrame.createModule()
            self.navigationController?.pushViewController(view, animated: true)
            
        case 4:
            if #available(iOS 13.0, *) {
                let view = OracionesRouter.getController()
                self.navigationController?.pushViewController(view, animated: true)
            } else {
                // Fallback on earlier versions
            }
        case 5:
            DispatchQueue.main.async {
                let view = FirstMan_Route.createView(navigation: self.navigationController!)
                self.navigationController?.pushViewController(view, animated: true)
            }
        case 6:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.local)
            let vc = storyboard.instantiateViewController(withIdentifier: "prayerChainFeed") as! prayerChain
            vc.userName = nombrePersona.text!
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthScreen = UIScreen.main.bounds.width
        
        return CGSize(width: 83, height: 124)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRowsT = 0
        switch flagState {
        case "PENDING_COMPLETION", "PENDING_VICARAGE_APPROVAL":
            numberOfRowsT = 1
        default:
            numberOfRowsT = allSections.count//saintOfDay.count + realesesPost.count + 1
        }
        return numberOfRowsT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch flagState {
        case "PENDING_COMPLETION":
            let cellAlert = tableView.dequeueReusableCell(withIdentifier: "ALERTCELL", for: indexPath) as! AlertTableCell
            cellAlert.selectionStyle = .none
            cellAlert.cardView.layer.cornerRadius = 10
            cellAlert.cardView.ShadowCard()
            cellAlert.btnIr.layer.cornerRadius = 8
            cellAlert.cellDelegate = self
            heightMainTable.constant = cellAlert.frame.height
            
            return cellAlert
            
        case "PENDING_VICARAGE_APPROVAL":
            let cellAlert2 = tableView.dequeueReusableCell(withIdentifier: "ALERTCELL", for: indexPath) as! AlertTableCell
            cellAlert2.selectionStyle = .none
            cellAlert2.cardView.layer.cornerRadius = 10
            cellAlert2.cardView.ShadowCard()
            cellAlert2.btnIr.layer.cornerRadius = 8
            cellAlert2.btnIr.alpha = 0
            heightMainTable.constant = cellAlert2.frame.height
            cellAlert2.lblTitle.text = "Tu solicitud está en proceso de revisión"
            
            return cellAlert2
            
        default:
                        
            if let section = allSections[indexPath.row] as? [HomeSaintOfDay] {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HOMECELLT", for: indexPath) as! HomeMainCell
                print("&&&", allSections, allSections.count)
                cell.subCardView.layer.cornerRadius = 10
                cell.subCardView.ShadowCard()
                cell.contentCardView.layer.cornerRadius = 10
                cell.contentCardView.clipsToBounds = true
                cell.selectionStyle = .none
                
                cell.imgCard.DownloadStaticImageH(section[0].image_url ?? "")
                cell.lblCard.adjustsFontSizeToFitWidth = true
                cell.lblCard.text = section[0].title ?? ""
                
                return cell
                
            }else{
                
                let cellSlider = tableView.dequeueReusableCell(withIdentifier: "SLIDERCELL", for: indexPath) as! HomeSliderCell
                cellSlider.delegate = self
                cellSlider.setupSlider(data: suggestions)
                cellSlider.subCardView.layer.cornerRadius = 10
                cellSlider.subCardView.ShadowCard()
                cellSlider.contentCardView.layer.cornerRadius = 10
                cellSlider.contentCardView.clipsToBounds = true
                cellSlider.selectionStyle = .none
               
                let count = allSections.count
                heightMainTable.constant = cellSlider.frame.height * CGFloat(count)
                
                return cellSlider
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch flagState {
        case "PENDING_VICARAGE_APPROVAL", "PENDING_COMPLETION":
            print("Tap")
            break
            
        default:
            if let section = allSections[indexPath.row] as? [HomeSaintOfDay] {
                let view = ModalWebViewController.showWebModal(url: section[0].publish_url ?? "Unspecified", type: "OTHER")
                self.present(view, animated: true, completion: nil)
            }
        }
        
    }
    
}
