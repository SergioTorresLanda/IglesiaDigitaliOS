//
//  VistaExtension.swift
//  CetesDirecto
//
//  Created by Edgar Hernandez on 5/13/19.
//  Copyright © 2019 Linko. All rights reserved.
//

import UIKit

enum DireccionGradiente {
    case vertical, horizontal
}

extension UIView {
    func rotar(angulo: CGFloat, duracion: CGFloat = 0.25) {
        UIView.animate(withDuration: TimeInterval(duracion), animations: {
            self.transform = self.transform.isIdentity ? CGAffineTransform(rotationAngle: angulo) : CGAffineTransform.identity
        })
    }
}
