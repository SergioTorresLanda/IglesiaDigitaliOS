//
//  NavigationBar.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 28/06/21.
//

import Foundation
import UIKit

public class NavigationBar: UINavigationBar {

  public override func layoutSubviews() {
    super.layoutSubviews()

    for subview in self.subviews {
        let stringFromClass = NSStringFromClass(subview.classForCoder)
      //print("-------- \(stringFromClass)")
      if stringFromClass.contains("BarBackground") {
        subview.frame.origin.y = -20
        subview.frame.size.height = 64
      }
    }
  }
}
