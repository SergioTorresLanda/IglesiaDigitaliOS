//
//  ChurchCustomeAnotationView.swift
//  EncuentroCatolicoUtils
//
//  Created by Jorge Garcia on 14/06/21.
//

import UIKit
public protocol UtilsDetailsChurchButtonDelegate: AnyObject {
    func didPressUtilsDetalButton(_ tag: Int)
}

public class ChurchCustomeAnotation: UIView {
    public weak var  delegate: UtilsDetailsChurchButtonDelegate!
    @IBOutlet weak var churchLabel: UILabel!
    @IBOutlet weak var churchButton: UIButton!
    @IBOutlet weak var churchImage: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        
    }
    @IBAction func churchButtonAction(_ sender: UIButton) {
        delegate?.didPressUtilsDetalButton(sender.tag)
    }
}

