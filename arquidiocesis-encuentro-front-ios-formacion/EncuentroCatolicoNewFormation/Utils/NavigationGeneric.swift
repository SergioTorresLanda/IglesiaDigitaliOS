//
//  NavigationGeneric.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 09/05/21.
//

import UIKit

protocol NavigationDelegationAction: class{
    func getAction(sender: UIButton)
}

class NavigationGeneric: UIView {
    
    public var navigationShared : UINavigationController?
    public var delegate: NavigationDelegationAction?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let title_lbl = UILabel()
        title_lbl.translatesAutoresizingMaskIntoConstraints = false
        title_lbl.tintColor = UIColor.white
        title_lbl.textColor = UIColor.white
        title_lbl.font = UIFont.boldSystemFont(ofSize: 20)
        title_lbl.text = "NGeneric".getStringFrom()
        
        let buttonUnsegue = UIButton()
        buttonUnsegue.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "back", in: Bundle().getBundle(), compatibleWith: nil)
        buttonUnsegue.setImage(image, for: UIControl.State.normal)
        buttonUnsegue.addTarget(self, action: #selector(segueNavigation(sender:)), for: UIControl.Event.touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(red: 25.0 / 255.0, green: 42.0 / 255.0, blue: 115.0 / 255.0, alpha: 1.0)
        self.addSubview(title_lbl)
        self.addSubview(buttonUnsegue)
        
        NSLayoutConstraint.activate([
            title_lbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            title_lbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonUnsegue.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            buttonUnsegue.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            buttonUnsegue.heightAnchor.constraint(equalToConstant: 19),
            buttonUnsegue.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    @objc func segueNavigation(sender: UIButton){
        delegate?.getAction(sender: sender)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
