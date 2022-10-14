//
//  GlobalFunctions.swift
//  Cadena de Oracion
//
//  Created by Branchbit on 22/03/21.
//

import Foundation
import UIKit

extension UIView{
    func addSmallShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
}

extension UILabel{
    func makeCircular(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}

extension UIImageView{
    func makeCircular(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
}

extension Date {
    
    func timeAgoDisplay() -> String {

        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let monthAgo = calendar.date(byAdding: .weekOfMonth, value: -1, to: Date())!
        
        var time = ""

        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            if diff == 1 {
                time = "segundo"
            }else{
                time = "segundos"
            }
            return "hace \(diff) \(time)"
            
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            if diff == 1 {
                time = "minuto"
            }else{
                time = "minutos"
            }
            return "hace \(diff) \(time)"
            
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            if diff == 1 {
                time = "hora"
            }else{
                time = "horas"
            }
            return "hace \(diff) \(time)"
            
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            if diff == 1 {
                time = "día"
            }else{
                time = "días"
            }
            return "hace \(diff) \(time)"
            
        }else if monthAgo > self {
            let diff = Calendar.current.dateComponents([.weekOfMonth], from: self, to: Date()).weekOfMonth ?? 0
            if diff == 1 {
                time = "semana"
            }else{
                time = "semanas"
            }
            return "hace \(diff) \(time)"
        }
        let diff = Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0
        if diff == 1 {
            time = "mes"
        }else{
            time = "meses"
        }
        return "hace \(diff) \(time)"

    }
    
}

// MARK: - UIContextMenuInteractionDelegate
extension SliderCellView: UIContextMenuInteractionDelegate {
    @available(iOS 13.0, *)
    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint)
    -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { _ in
                // let rateMenu = self.makeRemoveRatingAction()
                // let deleteMenu = self.makeRemoveRatingAction2()
                let menu = self.makeEditMenu()
                let children = [menu]
                return UIMenu(title: "", children: children)
            })
    }
    
    @available(iOS 13.0, *)
    func makeEditMenu() -> UIMenu {
        let copyAction = UIAction(title: "Editar",
                                  image: UIImage(named: ""),
                                  identifier: nil,
                                  state: .off) { _ in
            print("Edit Action")
           
        }
        
        let deleteAction = UIAction(title: "Eliminar",
                                    image: UIImage(named: ""),
                                    identifier: nil,
                                    state: .off) { _ in
            print("Delete Action")
        }
        
        return UIMenu(title: "Edit",
                      image: UIImage(named: ""),
                      options: [.displayInline], // [], .displayInline, .destructive
                      children: [copyAction, deleteAction])//[editImageAction, copyAction, shareAction, removeAction, deleteAction])
    }
    
}

extension UIImageView {
    func borderButtonColor(color: UIColor, radius: CGFloat) {
        self.layer.cornerRadius = radius
        let colorBorde = color
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.borderColor = colorBorde.cgColor
       
    }
}

extension UIButton {
    func borderButtonColor(color: UIColor, radius: CGFloat) {
        self.layer.cornerRadius = radius
        let colorBorde = color
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.borderColor = colorBorde.cgColor
       
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
        
        let finalWidth = toInfoView.view.bounds.width
        let finalHeight = toInfoView.view.bounds.height
        
        if isPresenting {
            
            containerView.addSubview(toInfoView.view)
            toInfoView.view.frame = CGRect(x: 0, y: fromInfoView.view.frame.height, width: finalWidth, height: finalHeight)
            
        }
        
        let transform = {
            
            toInfoView.view.transform = CGAffineTransform(translationX: 0, y: -finalHeight)
            
        }
            let identity = {
                fromInfoView.view.transform = .identity
            }
            
            let duration = self.transitionDuration(using: transitionContext)
            let isCancelled = transitionContext.transitionWasCancelled
            UIView.animate(withDuration: duration, animations: {
                self.isPresenting ? transform() : identity()
            }) { (_) in
                transitionContext.completeTransition(!isCancelled)
            }
            
        }
        
    }
