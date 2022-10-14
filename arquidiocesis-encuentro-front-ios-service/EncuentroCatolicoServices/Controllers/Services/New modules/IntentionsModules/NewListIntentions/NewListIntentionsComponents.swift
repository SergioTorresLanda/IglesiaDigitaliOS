//
//  NewListIntentionsComponents.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

extension NewListIntentionsView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch arrayIntentions.count {
        case 0:
            return 1
        default:
            return arrayIntentions.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "CELLDATEI", for: indexPath) as! CellIntentionDate
            cell1.cardDateCell.layer.cornerRadius = 10
            cell1.cardDateCell.ShadowCard()
            
            if arrayIntentions.count != 0 {
                let strDate = getDate(str: arrayIntentions[0].date ?? "Unspecified")
                let dateFormatter = DateFormatter()
                dateFormatter.locale = .init(identifier: "Es_MX")
                dateFormatter.dateFormat = "dd MMMM yyyy" //EEEE, MMM d, yyyy
                if strDate != nil {
                    cell1.lblDate.text = dateFormatter.string(from: strDate ?? Date()).capitalized
                }
            }else{

               // let current = Date()
                let singleton = IntentionCalendarView.singleton
                let strDate = getDate(str: singleton.passDate)
                let dateFormatter = DateFormatter()
                dateFormatter.locale = .init(identifier: "Es_MX")
                dateFormatter.dateFormat = "dd MMMM yyyy" //EEEE, MMM d, yyyy
                cell1.lblDate.text = dateFormatter.string(from: strDate ?? Date()).capitalized
                
            }
            
            // cell1.lblDate.text = arrayIntentions[0].date
            cell1.selectionStyle = .none
            
            return cell1
            
        default:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "CELLDATAI", for: indexPath) as! CellIntentionData
            cell2.cardDataCell.layer.cornerRadius = 10
            cell2.cardDataCell.ShadowCard()
            let hour = arrayIntentions[indexPath.row].start_time?.prefix(5)
            cell2.lblTime.text = "\(hour ?? "Unspecified")"
            cell2.lblName.text = "\(arrayIntentions[indexPath.row].priest?.name ?? "Unspecified") \(arrayIntentions[indexPath.row].priest?.first_surname ?? "")"
            cell2.selectionStyle = .none
            
            return cell2
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let view = IntentionCalendarRouter.createModule()
            view.modalPresentationStyle = .overFullScreen
            view.view.backgroundColor = .clear
            view.transitioningDelegate = self
            present(view, animated: true, completion: nil)
           // self.navigationController?.pushViewController(view, animated: true)
            
        }else{
            let view = DetailIntetnionRouter.createModule(date: arrayIntentions[indexPath.row].date ?? "", hour: arrayIntentions[indexPath.row].start_time ?? "")
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        
    }
    
    func getDate(str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: str) // replace Date String
    }
    
}

extension NewListIntentionsView: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        print("Delegate is working")
        let singleton = IntentionCalendarView.singleton
        if singleton.passDate != "" && singleton.passDate != "Unspecified" {
            print(singleton.passDate)
            self.arrayIntentions.removeAll()
            self.mainTable.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.present(self.alertLoader, animated: true, completion: nil)
                print(self.locationID)
                self.presenter?.callRequestList(locationID: "\(self.deafults.integer(forKey: "locationModule"))", dateStr: singleton.passDate)
            }
           
        }else{
            print("Vamos pa atras")
            self.navigationController?.popViewController(animated: true)
        }
      
        return transition
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
