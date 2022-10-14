//
//  UITextField+Extensions.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import UIKit

extension UITextField {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        var bottomBorder = UIView()
        bottomBorder = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = color
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)

        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: width).isActive = true
        layoutIfNeeded()
    }
}
