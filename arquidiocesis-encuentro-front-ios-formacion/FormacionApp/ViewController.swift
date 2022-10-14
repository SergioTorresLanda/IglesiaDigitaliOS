//
//  ViewController.swift
//  FormacionApp
//
//  Created by Daniel Isaac Mora Osorio on 01/05/21.
//

import UIKit
import EncuentroCatolicoNewFormation

class ViewController: UIViewController {
    
    var button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        button = UIButton(frame: CGRect.zero)
        guard let button = button else { debugPrint("Can't create button"); return }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Vamos", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(action), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    @objc func action(){
        guard let navigation = self.navigationController else { debugPrint("Can't create navigation"); return }
        let viewC = FirstMan_Route.createView(navigation: navigation)
        self.navigationController?.pushViewController(viewC, animated: true)
    }
}

