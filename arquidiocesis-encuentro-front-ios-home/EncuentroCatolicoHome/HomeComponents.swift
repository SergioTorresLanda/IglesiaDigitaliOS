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
extension Home_Home: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: Distribution
        
        switch indexPath.row {
        case 0:
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
            
            cell.lblFrameworkName.text = "Biblioteca Virtual"
            
            if arraySelectedCell[indexPath.item] == false {
                cell.imageMenu.image  = UIImage(named:"Grupo(gris) 8614", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.imageMenu.image = UIImage(named: "Grupo 8614", in: Bundle.local, compatibleWith: nil)
            }
            
            cell.containerButton.layer.cornerRadius = 10
            // cell.containerButton.addShadow()
            
            return cell
            
        case 3:
            
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
            
        case 4:
            
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
            
        case 5:
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
            
            
        case 6:
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
extension Home_Home: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.local)
            let vc = storyboard.instantiateViewController(withIdentifier: "prayerChainFeed") as! Home_CadenaOracion
            vc.userName = nombrePersona.text!
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let view = MyChurchesWireFrame.getController()
            self.navigationController?.pushViewController(view, animated: true)
        case 2:
            let view = YoungView_Route.createView(navigation: self.navigationController!)
            self.navigationController?.pushViewController(view, animated: true)
        case 3:
            let view = OracionesRouter.getController()
            self.navigationController?.pushViewController(view, animated: true)
        case 4:
            let view = HomeServiceWireFrame.createModule()
            self.navigationController?.pushViewController(view, animated: true)
        case 5:
            let instance = SocialNetworkConstant.shared.instance
            let view =  SocialNetworkNews.openSocialNetowrk(firebaseApp: instance)
            self.navigationController?.pushViewController(view, animated: true)
        case 6:
            let view = MyCommunitiesMainViewwWireFrame.getController()
            self.navigationController?.pushViewController(view, animated: true)
        default:
            break
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension Home_Home: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthScreen = UIScreen.main.bounds.width
        return CGSize(width: 83, height: 124) //height: 124)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension Home_Home: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRowsT = 0
        switch flagState {
        case "PENDING_COMPLETION", "PENDING_VICARAGE_APPROVAL":
            numberOfRowsT = 1
        default:
            numberOfRowsT = allSections.count  //saintOfDay.count + realesesPost.count + 1
        }
        print(":::NORIS:::"+String(numberOfRowsT))
        if numberOfRowsT == 2 {
            SVheight.constant=855
            tableHeight.constant=600
        }else{
            SVheight.constant=1155
            tableHeight.constant=900
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
            let cellSlider = tableView.dequeueReusableCell(withIdentifier: "SLIDERCELL", for: indexPath) as! HomeSliderCell
            cellSlider.delegate = self
            cellSlider.contentCardView.layer.cornerRadius = 10
            cellSlider.contentCardView.clipsToBounds = true
            cellSlider.selectionStyle = .none
            let count = allSections.count
            heightMainTable.constant = cellSlider.frame.height * CGFloat(count)
            //cellSlider.subCardView.layer.cornerRadius = 10
            //cellSlider.subCardView.ShadowCard()
            print(":::ALL SECTIONS::: ")
            print(String(allSections.count))
            if indexPath.row >= allSections.startIndex && indexPath.row < allSections.endIndex {
                if allSections[indexPath.row] is [HomeSaintOfDay] {
                    print(":::SETUPP SAINT::: ")
                    cellSlider.setupSlider3(data: saintOfDay)
                    print(String(indexPath.row))
                }
                if allSections[indexPath.row] is [HomePosts] {
                    print(":::SETUPP Desde la Fe::: ")
                    print(String(indexPath.row))
                    cellSlider.setupSlider2(data: realesesPost)
                }
                if allSections[indexPath.row] is [HomeSuggestions] {
                    print(":::SETUPP Sugerencias:::")
                    print(String(indexPath.row))
                    cellSlider.setupSlider(data: suggestions)
                }
            }else{
                print("ERROR INDEX PATH: "+String(indexPath.row))
            }
            return cellSlider
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch flagState {
        case "PENDING_VICARAGE_APPROVAL", "PENDING_COMPLETION":
            print("Tap")
            break
            
        default:
            /*
            if let section = allSections[indexPath.row] as? [HomeSaintOfDay] {
                let view = ModalWebViewController.showWebModal(url: section[0].publish_url ?? "Unspecified", type: "OTHER")
                self.present(view, animated: true, completion: nil)
            }*/
            break
        }
        
    }
    
}
 /*Antes Seccion Desde la fe
  
  /*let cell = tableView.dequeueReusableCell(withIdentifier: "HOMECELLT", for: indexPath) as! HomeMainCell
  print("&&&", allSections, allSections.count)
  cell.subCardView.layer.cornerRadius = 10
  cell.subCardView.ShadowCard()
  cell.contentCardView.layer.cornerRadius = 10
  cell.contentCardView.clipsToBounds = true
  cell.selectionStyle = .none
  
  cell.imgCard.DownloadStaticImageH(section[0].image_url ?? "")
  cell.lblCard.adjustsFontSizeToFitWidth = true
  cell.lblCard.text = section[0].title ?? ""
  
  return cell*/
  
  */
