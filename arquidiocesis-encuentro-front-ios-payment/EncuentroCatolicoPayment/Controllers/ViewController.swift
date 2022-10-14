//
//  ViewController.swift
//  zeus-ios-sdk-payment
//
//  Created by Gabriel Briseño on 06/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .purple
        
        print(CipherUtil.encryptJSON(text: "data") ?? "Sin data")
    }
}

