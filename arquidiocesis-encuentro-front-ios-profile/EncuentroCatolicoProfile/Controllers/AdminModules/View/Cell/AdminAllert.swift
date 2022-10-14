//
//  AdminAllert.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 15/07/21.
//

import Foundation
import UIKit
public protocol AdminAllertButtonDelegate: AnyObject {
    func didPressYesAdminButton(_ sender: UIButton)
}
class AdminAllert: UIView {
    
    public weak var delegate: AdminAllertButtonDelegate!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var chourchName = String()
    static let instance = AdminAllert()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("AdminAllert", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        subTitleLabel.text = "El “Colaborador” ahora es administrador de la Iglesia \(chourchName)"
        titleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.sizeToFit()
        parentView.frame = CGRect(x: 60, y: 248, width: 280, height: 190)
        //parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAllert(chourchName: String) {
        self.chourchName = chourchName
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        delegate?.didPressYesAdminButton(sender)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
