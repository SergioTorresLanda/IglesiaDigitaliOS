//
//  SellectedModulesAllert.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 23/06/21.
//

import UIKit
public protocol SellectedModeuleButtonDelegate: AnyObject {
    func didPressYesButton(_ sender: UIButton)
    func didPresNoButton(_ tag: Int)
}
class SellectedModulesAllert: UIView {
    public weak var delegate: SellectedModeuleButtonDelegate!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var selectedModelsArray = [String]()
    static let instance = SellectedModulesAllert()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("SellectedModulesAllert", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        titleLabel.text = "Confirmar"
        messageLabel.text = "Los siguientes modulos se activaron:"
        titleLabel.adjustsFontSizeToFitWidth = true
        messageLabel.adjustsFontSizeToFitWidth = true
        parentView.frame = CGRect(x: 60, y: 248, width: 280, height: 270)
        //parentView.center = CGPoint(x: parentView.frame.size.width  / 2, y: parentView.frame.size.height / 2)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.register(UINib(nibName: "SellectedModulesTableViewCell", bundle: Bundle.local), forCellReuseIdentifier: "SellectedModulesTableViewCell")
    }
    func showAllert(sellectedModules: Array<String>) {
        self.selectedModelsArray = sellectedModules
        
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
        delegate?.didPressYesButton(sender)
    }
    @IBAction func noButtonAction(_ sender: UIButton) {
        parentView.removeFromSuperview()
    }
}

extension SellectedModulesAllert: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedModelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellectedModulesTableViewCell", for: indexPath) as! SellectedModulesTableViewCell
        cell.titleLabesl.text = selectedModelsArray[indexPath.row]
        return cell
    }
    
    
}
