//
//  redSocialNewsViewController.swift
//  EncuentroCatolicoNews
//
//  Created by Luis Angel on 11/01/23.
//

import UIKit
import EncuentroCatolicoDonations
import EncuentroCatolicoLive
import EncuentroCatolicoScanner
import EncuentroCatolicoProfile
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoChurch
import EncuentroCatolicoPrayers
import Foundation
import EncuentroCatolicoNewFormation

class RedSocialNewsViewController: UIViewController {
    
    lazy private var labelTittle: UILabel = {
        let label = UILabel()
        label.text = "Arquidiocesis De Mexico"
        return label
    }()
    
    lazy private var labelFecha: UILabel = {
        let label = UILabel()
        label.text = "hoy 07:57"
        return label
    }()
    
    lazy private var textViewDescription: UITextView = {
        let textView = UITextView()
        textView.text = "los dogmas de de la Iglesia Catolica o dogmas de fe son la base de toda la doctrina catolica. Estan los dogmas de jesucristo y mas ¡conocelos! https://bit.ly/3i7223k"
        return textView
    }()
    
    lazy private var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "imagemCristo", in: Bundle(for: type(of: self)), compatibleWith: nil)
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(image)
        image.addAnchorsAndSize(width: 100, height: 100, left: 100, top: 100, right: 100, bottom: nil)
        
        view.addSubview(labelTittle)
        labelTittle.addAnchorsAndSize(width: nil, height: nil, left: 10, top: 10, right: 30, bottom: nil, withAnchor: .top,relativeToView: image)
        
        view.addSubview(labelFecha)
        labelFecha.addAnchorsAndSize(width: nil, height: nil, left: 10, top: 5, right: nil, bottom: nil, withAnchor: .top, relativeToView: labelTittle)
        
        view.addSubview(textViewDescription)
        textViewDescription.addAnchorsAndSize(width: nil, height: nil, left: 10, top: 5, right: nil, bottom: nil, withAnchor: .top, relativeToView: labelFecha)
        
      
        

    }
    
}

