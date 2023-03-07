//
//  UILoader.swift
//  Conectanos
//
//  Created by Daniel Isaac Mora Osorio on 20/04/20.
//  Copyright © 2020 UPAX. All rights reserved.
//

import Foundation
import UIKit

protocol DelegateActionLoaderProtocol {
    func cencelActionLoader()
}

class UILoader: NSObject {
    
    static var activityIndicator =  UIActivityIndicatorView()
    static var delegateAction : DelegateActionLoaderProtocol?
    
    static var cancelButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancelar", for: UIControl.State.normal)
        button.layer.cornerRadius = 20
        var color = UIColor.black
        if #available(iOS 13.0, *) {
            //color = UIColor.label
        }
        button.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        button.setTitleColor(color, for: UIControl.State.normal)
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 40, bottom: 10, right: 40)
        return button
    }()
    
    public static func show() {
     
        var mainView : UIView?
        let dialogLoading: UIView = UIView()
        
        cancelButton.addTarget(self, action: #selector(UILoader.setActionButton), for: UIControl.Event.touchUpInside)
        
        //ContainerView
        mainView = UIView()
        mainView?.translatesAutoresizingMaskIntoConstraints = false
        mainView?.backgroundColor = .clear
        mainView?.tag = -99999
        
        dialogLoading.translatesAutoresizingMaskIntoConstraints = false
        dialogLoading.backgroundColor = UIColor.white
        dialogLoading.layer.cornerRadius = 10
        dialogLoading.layer.masksToBounds = true
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp -30 = 115
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle().getBundle(), compatibleWith: nil)
        let lbl_placeholder = UILabel()
        lbl_placeholder.translatesAutoresizingMaskIntoConstraints = false
        lbl_placeholder.text = "Cargando..."
        lbl_placeholder.textAlignment = NSTextAlignment.center
        lbl_placeholder.font = UIFont.systemFont(ofSize: 12)
        lbl_placeholder.tintColor = UIColor.black
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.gray
        
        //Blur Effect
//        var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//        if #available(iOS 13.0, *) {
//            //blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
//        }
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        mainView?.addSubview(blurEffectView)
        
//        mainView?.addSubview(activityIndicator)
        mainView?.addSubview(dialogLoading)
        dialogLoading.addSubview(imageView)
        dialogLoading.addSubview(lbl_placeholder)
        
        activityIndicator.startAnimating()
        
        UIApplication.shared.delegate?.window??.addSubview(mainView!)
//        mainView!.addSubview(cancelButton)
        mainView?.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
//        270 139
        
        // button color uodate
        
//        var blurEffectView_2 = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
//        if #available(iOS 13.0, *) {
//            //blurEffectView_2 = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
//        }
//        cancelButton.addSubview(blurEffectView_2)
        
        NSLayoutConstraint.activate([
            mainView!.topAnchor.constraint(equalTo: UIApplication.shared.delegate!.window!!.topAnchor),
            mainView!.rightAnchor.constraint(equalTo: UIApplication.shared.delegate!.window!!.rightAnchor),
            mainView!.leftAnchor.constraint(equalTo: UIApplication.shared.delegate!.window!!.leftAnchor),
            mainView!.bottomAnchor.constraint(equalTo: UIApplication.shared.delegate!.window!!.bottomAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: mainView!.centerYAnchor),
//            activityIndicator.centerXAnchor.constraint(equalTo: mainView!.centerXAnchor),
            dialogLoading.centerYAnchor.constraint(equalTo: mainView!.centerYAnchor),
            dialogLoading.centerXAnchor.constraint(equalTo: mainView!.centerXAnchor),
            dialogLoading.heightAnchor.constraint(equalToConstant: 139),
            dialogLoading.widthAnchor.constraint(equalToConstant: 270),
            imageView.topAnchor.constraint(equalTo: dialogLoading.topAnchor),
            imageView.centerYAnchor.constraint(equalTo: dialogLoading.centerYAnchor),
            lbl_placeholder.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            lbl_placeholder.rightAnchor.constraint(equalTo: dialogLoading.rightAnchor),
            lbl_placeholder.leftAnchor.constraint(equalTo: dialogLoading.leftAnchor),
            lbl_placeholder.heightAnchor.constraint(equalToConstant: 40),
//            cancelButton.topAnchor.constraint(equalTo: dialogLoading.bottomAnchor, constant: 30),
//            cancelButton.centerXAnchor.constraint(equalTo: mainView!.centerXAnchor)
        ])
        //mainView!.addSubview(activityIndicator)
    }
    
    @objc class func setActionButton(){
        self.hide()
        delegateAction?.cencelActionLoader()
    }
    
    public static func show(view: UIView?, text:String?) {
        var mainView : UIView?
        
        //Disable user interaction
        view?.isUserInteractionEnabled = false
        
        //ContainerView
        mainView = UIView(frame: (view?.frame)!)
        mainView?.backgroundColor = .clear
        mainView?.tag = -99999
       
        
        let xAxis = CGPoint(x: (mainView?.center.x)!, y: 0)
        let yAxis =  CGPoint(x: 0, y: (mainView?.center.y)!)
       
        let activityLabel = UILabel(frame: CGRect(x: xAxis.x / 2, y: 0, width: 0, height: 0))
        activityLabel.text = text
        activityLabel.sizeToFit()
        
        activityIndicator.frame = CGRect(x: xAxis.x - 15, y:yAxis.y - 15, width: 30, height: 30)
        activityIndicator.color = .black
       
        activityLabel.center.y = activityIndicator.center.y + 30
        
        //Blur Effect
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blurEffectView.frame = (view?.bounds)!
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView?.addSubview(blurEffectView)
        
        mainView?.addSubview(activityIndicator)
        mainView?.addSubview(activityLabel)
        activityIndicator.startAnimating()
        
        view?.addSubview(mainView!)
    }
    
    public static func hide() {
//        activityIndicator.stopAnimating()
//        activityIndicator.removeFromSuperview()
        DispatchQueue.main.async {
            if let subviewsCount = UIApplication.shared.delegate?.window??.subviews.count, subviewsCount > 1 {
                UIApplication.shared.delegate?.window??.subviews.last?.removeFromSuperview()
            }
        }
    }
}
