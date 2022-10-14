//
//  AlertaBaseViewController.swift
//  CetesDirecto
//
//  Created by Miguel Eduardo  Valdez Tellez on 9/23/19.
//  Copyright © 2019 Linko. All rights reserved.
//

import UIKit

open class AlertaBaseViewController: UIViewController {
    
    //MARK: - Ciclo de vida
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .gray
        self.view.alpha = 1
        
    }
        
    //MARK: - Presentar alerta
    open func presentartAlerta(en controlador: UIViewController) {
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            controlador.present(self, animated: true)
        }
    }

}
