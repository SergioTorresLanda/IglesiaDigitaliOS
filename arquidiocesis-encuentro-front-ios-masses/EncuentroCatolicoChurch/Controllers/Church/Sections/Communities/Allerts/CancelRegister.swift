//
//  CancelRegister.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 28/07/21.
//

import UIKit
public protocol CancelRegisterAllertButtonDelegate: AnyObject {
    func didPressYesCancelRegisterButton(_ sender: UIButton)
}
class CancelRegister: UIView {
    public weak var delegate: CancelRegisterAllertButtonDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet var parentView: UIView!
    static let instance = CancelRegister()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("CancelRegister", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        titleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.adjustsFontSizeToFitWidth = true
        parentView.frame = CGRect(x: 60, y: 248, width: 280, height: 218)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func yesButtonAction(_ sender: UIButton) {
        delegate?.didPressYesCancelRegisterButton(sender)
    }
    @IBAction func noButtonAction(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
