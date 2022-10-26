//
//  NewDonationsComponents.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 22/02/22.
//

import Foundation
import UIKit

extension NewDontaionsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count = 0
        
        switch collectionView {
        case menuCollection:
            count = 5
            
        case radioBtnYesCollection:
            count = itemsRadioBtn.count
            
        default:
            break
        }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case menuCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MENUCELL", for: indexPath) as! MenuCollectionCell
            
            switch indexPath.item {
            case 0, 2, 4:
                cell.contentView.alpha = 0
            default:
                cell.nameItem.text = menuItems[indexPath.item]
                
                if #available(iOS 13.0, *) {
                    cell.imgItem.image = UIImage(systemName: menuIcons[indexPath.item])
                } else {
                  break
                }
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RADIOBTNYES", for: indexPath) as! radioBtnYesCollectionCell
            
            if isActive[indexPath.item] == true {
                cell.fillCircle.isHidden = false
            }else{
                cell.fillCircle.isHidden = true
            }
            
            cell.btnRadio.tag = indexPath.item
            cell.btnRadio.addTarget(self, action: #selector(selectRadioButton), for: .touchUpInside)
            cell.lblText.text = itemsRadioBtn[indexPath.item]
            
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 1:
            let statixMinX = menuCollection.frame.minX
            var axisX = 61 * indexPath.item
            axisX += Int(statixMinX)
            UIView.animate(withDuration: 0.3) {
                self.menuLine.frame = CGRect(x: CGFloat(axisX), y: self.menuCollection.frame.maxY, width: 61, height: 3)
            }
            detailChurchStack.isHidden = true
            addDataContainerView.isHidden = true
            searchContent.isHidden = false
            lblContainerView.isHidden = false
            churchListStack.isHidden = false
            flowId = 0
            
        case 3:
            let statixMinX = menuCollection.frame.minX
            var axisX = 61 * indexPath.item
            axisX += Int(statixMinX)
            UIView.animate(withDuration: 0.3) {
                self.menuLine.frame = CGRect(x: CGFloat(axisX), y: self.menuCollection.frame.maxY, width: 61, height: 3)
            }
            showLoading()
            churchListStack.isHidden = true
            searchContent.isHidden = true
            lblContainerView.isHidden = true
            detailChurchStack.isHidden = false
            cardDetailContainerView.isHidden = true
            conceptContainerView.isHidden = true
            radioButtonContainer.isHidden = true
            containerBtnsAccept.isHidden = true
            addDataContainerView.isHidden = false
            lblDataBillingNew.isHidden = true
            self.presenter?.requestBillingData()
            flowId = 1
        default:
            break
        }
       
    }
    
}

extension NewDontaionsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 61.0, height: collectionView.frame.height)
    }
}

extension NewDontaionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch tableView {
        case mainChurchComTable:
            count = listMainLocations.count
        case favoriteChurchTable:
            count = listFavoritesLocations.count
        case suggestionsChurchTable:
            count = churchSuggestedList.count
        default:
            break
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLCHURCHCOMM", for: indexPath) as! MainChurchCommTableCell

        cell.imgChurch.layer.cornerRadius = 6
        cell.btnGo.setTitle("", for: .normal)
        cell.btnGo.tag = indexPath.row
        cell.btnGo.addTarget(self, action: #selector(tapChurchList), for: .touchUpInside)
        cell.selectionStyle = .none
        
        switch tableView {
        case favoriteChurchTable:
            cell.lblNameChurch.text = listFavoritesLocations[indexPath.row].name ?? ""
            cell.imgChurch.DownloadImage(listFavoritesLocations[indexPath.row].image_url ?? "")
            cell.btnGo.accessibilityIdentifier = "FAV"
            heightFavoriteChurch.constant = cell.frame.height * CGFloat(listFavoritesLocations.count) + 20
            
        case suggestionsChurchTable:
            cell.lblNameChurch.text = churchSuggestedList[indexPath.row].name ?? ""
            cell.imgChurch.DownloadImage(churchSuggestedList[indexPath.row].image_url ?? "")
            cell.btnGo.accessibilityIdentifier = "SUGG"
            heightSuggestionsChurch.constant = cell.frame.height * CGFloat(churchSuggestedList.count) + 60
            
        case mainChurchComTable:
            cell.lblNameChurch.text = listMainLocations[indexPath.row].name
            cell.imgChurch.DownloadImage(listMainLocations[indexPath.row].image_url ?? "")
            cell.btnGo.accessibilityIdentifier = "MAIN"
            heightMainChurchComm.constant = cell.frame.height * CGFloat(listMainLocations.count) + 10
            
        default:
            print("default")
        }
        
        return cell 
    }
    
}

extension NewDontaionsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
        case pickerDontaion:
            count = conceptType.count
            
        case pickerAmount:
            count = amountList.count
            
        default:
            break
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case pickerDontaion:
            return conceptType[row]
            
        default:
            return amountList[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pickerDontaion:
            conceptField.text = conceptType[row]
            
            if conceptType[row] == "Otro" {
                specifyField.isHidden = false
                lineSpecify.isHidden = false
            }else{
                specifyField.isHidden = true
                lineSpecify.isHidden = true
            }
            
        default:
            amountField.text = "$\(amountList[row])"
            if amountList[row] == "Otra" {
                amountField.text = "Otra"
                bottomArrowConstraint.constant = -80
                otherAmountField.isHidden = false
                lineOtherAmount.isHidden = false
                
            }else{
                bottomArrowConstraint.constant = -35
                otherAmountField.isHidden = true
                lineOtherAmount.isHidden = true
            }
        }
        
    }
}

// MARK: TEXT FIELD EXTENSION -
extension NewDontaionsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
               let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                   return false
           }
           let substringToReplace = textFieldText[rangeOfTextToReplace]
           let count = textFieldText.count - substringToReplace.count + string.count
        
        switch textField {
        case specifyField:
            return count <= 20
            
        case otherAmountField:
            return count <= 6
            
        case FormularyFieldCollection[1]:
            return count <= 30
            
        case FormularyFieldCollection[3]:
            return count <= 15
            
        case FormularyFieldCollection[4]:
            return count <= 5
            
        case FormularyFieldCollection[5]:
            return count <= 40
            
        default:
            return count <= 80
        }
          
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case conceptField:
            conceptField.text = "Selecciona"
            
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case FormularyFieldCollection[0]:
            FormularyFieldCollection[1].becomeFirstResponder()
            
        case FormularyFieldCollection[1]:
            FormularyFieldCollection[2].becomeFirstResponder()
            
        case FormularyFieldCollection[2]:
            FormularyFieldCollection[3].becomeFirstResponder()
            
        case FormularyFieldCollection[3]:
            FormularyFieldCollection[4].becomeFirstResponder()
            
        case FormularyFieldCollection[5]:
            FormularyFieldCollection[6].becomeFirstResponder()
            
        case FormularyFieldCollection[6]:
            self.view.endEditing(true)
        default:
            break
        }
        return true
    }
}

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
     guard let toInfoView = transitionContext.viewController(forKey: .to),
        let fromInfoView = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
       // let finalWidth = toInfoView.view.bounds.width * 0.76
        let finalWidth = toInfoView.view.bounds.width
        let finalHeight = toInfoView.view.bounds.height
        
        if isPresenting {
            
            // add menu view controller to container
            containerView.addSubview(toInfoView.view)
            
            // init frame off the screen
           // toInfoView.view.frame = CGRect(x: fromInfoView.view.frame.width, y: 0, width: finalWidth, height: finalHeight)
            toInfoView.view.frame = CGRect(x: 0, y: fromInfoView.view.frame.height, width: finalWidth, height: finalHeight)
            //toInfoView.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
            
        }
        
        // Animate on screen
        let transform = {
            
           // toInfoView.view.transform = CGAffineTransform(translationX: -finalWidth, y: 0)
            toInfoView.view.transform = CGAffineTransform(translationX: 0, y: -finalHeight)
            
        }
       // Animate off screen
            
            let identity = {
                fromInfoView.view.transform = .identity
                
            }
            
         // Animation of the transition
            let duration = self.transitionDuration(using: transitionContext)
            let isCancelled = transitionContext.transitionWasCancelled
            UIView.animate(withDuration: duration, animations: {
                self.isPresenting ? transform() : identity()
            }) { (_) in
                transitionContext.completeTransition(!isCancelled)
            }
            
        }
        
    }
