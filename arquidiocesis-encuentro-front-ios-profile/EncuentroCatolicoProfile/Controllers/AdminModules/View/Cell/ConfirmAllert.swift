//
//  ConfirmAllert.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 15/07/21.
//

import Foundation
import UIKit
public protocol ConfirmAllertButtonDelegate: AnyObject {
    func didPressYesConfirmButton(_ sender: UIButton)
}
class ConfirmAllert: UIView {
    public weak var delegate: ConfirmAllertButtonDelegate!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    static let instance = ConfirmAllert()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("ConfirmAllert", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        titleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.adjustsFontSizeToFitWidth = true
        parentView.frame = CGRect(x: 60, y: 248, width: 280, height: 270)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        delegate?.didPressYesConfirmButton(sender)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
