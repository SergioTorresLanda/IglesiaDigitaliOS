//
//  SuceesAllert.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 28/07/21.
//

import UIKit
public protocol SuccessAllertButtonDelegate: AnyObject {
    func didPressYesSuccessAllertButton(_ sender: UIButton)
}
class SuceesAllert: UIView {
    public weak var delegate: SuccessAllertButtonDelegate?
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtituleLabel: UILabel!
    static let instance = SuceesAllert()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("SuceesAllert", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        titleLabel.adjustsFontSizeToFitWidth = true
        subtituleLabel.adjustsFontSizeToFitWidth = true
        parentView.frame = CGRect(x: 30, y: 248, width: 344, height: 317)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @IBAction func laterButton(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    @IBAction func nextButton(_ sender: UIButton) {
        delegate?.didPressYesSuccessAllertButton(sender)
    }
    
}
