//
//  CustomSegmentController.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Billy Jack on 19/10/21.
//

import Foundation
import UIKit
import CoreMIDI

protocol CustomSegmentControllerDelegate: AnyObject {
    func change(to index:Int)
}

class CustomSegmentController: UIView{
    
    private var sgmBtnTitles: [String]?
    private var sgmBtns: [UIButton]?
    private var vwSelector: UIView?
    
    var txtColor: UIColor = .green
    var selectViewColor: UIColor = UIColor(red: 117.0/255.0, green: 120.0/255.0, blue: 123.0/255.0, alpha: 1)
    var selectTxtColor: UIColor = UIColor(red: 113.0/255.0, green: 113.0/255.0, blue: 113.0/255.0, alpha: 1)
    
    weak var delegate: CustomSegmentControllerDelegate?
    
    public private(set) var selectedIndex: Int = 0
  
    convenience init(frame: CGRect, sgmTitles:[String]) {
        self.init(frame: frame)
        self.sgmBtnTitles = sgmTitles
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setSgmtTitles(sgmtTitles: [String]){
        self.sgmBtnTitles = sgmtTitles
        self.updateView()
    }
    
    
    func setIndex(index: Int){
        sgmBtns?.forEach({ $0.setTitleColor(selectTxtColor, for: .normal)})
        let button = sgmBtns?[index]
        selectedIndex = index
        button?.setTitleColor(selectTxtColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(sgmBtnTitles?.count ?? 0) * CGFloat(index)
        UIView.animate(withDuration: 0.2){
            self.vwSelector?.frame.origin.x = selectorPosition
        }
    }
    
    @objc func buttonAction(sender: UIButton){
        if let btnsEnumerated = sgmBtns?.enumerated(){
            for (buttonIndex, btn) in btnsEnumerated {
                btn.setTitleColor(selectTxtColor, for: .normal)
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                if btn == sender{
                    let selectorPosition = frame.width/CGFloat(sgmBtnTitles?.count ?? 0) * CGFloat(buttonIndex)
                    selectedIndex = buttonIndex
                    delegate?.change(to: selectedIndex)
                    UIView.animate(withDuration: 0.3){
                        self.vwSelector?.frame.origin.x = selectorPosition
                    }
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                    btn.setTitleColor(selectTxtColor, for: .normal)
                    
                }
            }
        }
    }
}

extension CustomSegmentController{
    
    private func updateView(){
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: sgmBtns ?? [])
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
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.sgmBtnTitles?.count ?? 0)
        vwSelector = UIView(frame: CGRect(x: 0, y: self.frame.height, width: selectorWidth, height: 2))
        vwSelector?.backgroundColor = selectViewColor
        addSubview(vwSelector ?? UIView())
    }
    
    private func createButton() {
        sgmBtns = [UIButton]()
        sgmBtns?.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        if let buttonTitles = sgmBtnTitles{
            for buttonTitle in buttonTitles {
                let button = UIButton(type: .system)
                button.setTitle(buttonTitle, for: .normal)
                button.addTarget(self, action:#selector(CustomSegmentController.buttonAction(sender:)), for: .touchUpInside)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                button.setTitleColor(selectTxtColor, for: .normal)
                sgmBtns?.append(button)
            }
            if sgmBtns?.count ?? 0 > 0{
                sgmBtns?[0].setTitleColor(selectTxtColor, for: .normal)
                sgmBtns?[0].titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            }
            
        }
        
    }
}
