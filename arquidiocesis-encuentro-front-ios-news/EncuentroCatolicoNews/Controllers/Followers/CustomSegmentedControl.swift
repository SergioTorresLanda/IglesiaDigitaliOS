//
//  CustomSegmentedControl.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//

import Foundation
import UIKit

protocol CustomSegmentedControlDelegate: AnyObject{
    func changeToIndex(index: Int)
}

class CustomSegmentedControl: UIView{
    
    private var buttonTitles: [String]!
    private var buttons: [UIButton] = [UIButton]()
    private var selectorView: UIView!
    
    weak var delegate: CustomSegmentedControlDelegate?
    
    var textColor: UIColor = UIColor(red: 113/255, green: 113/255, blue: 133/255, alpha: 1.0)
    var selectorViewColor: UIColor = UIColor(red: 170/255, green: 120/255, blue: 123/255, alpha: 1.0)
    var selectorTextColor: UIColor = UIColor(red: 113/255, green: 113/255, blue: 133/255, alpha: 1.0)
    
    convenience init(frame: CGRect, buttonTitle: [String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]){
        self.buttonTitles = buttonTitles
        updateView()
    }
    
    private func configStackView(){
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func configSelectorView(){
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 3, width: selectorWidth, height: 3))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton(){
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    @objc func buttonAction(sender: UIButton){
        for (buttonIndex, btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            if btn == sender{
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                delegate?.changeToIndex(index: buttonIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            }
        }
    }
    
    private func updateView(){
        createButton()
        configSelectorView()
        configStackView()
    }
}
