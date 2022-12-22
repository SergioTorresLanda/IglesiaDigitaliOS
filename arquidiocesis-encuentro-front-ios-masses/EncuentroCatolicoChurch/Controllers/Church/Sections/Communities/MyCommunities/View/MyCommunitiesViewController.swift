//
//  MyCommunitiesViewController.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 02/08/21.
//

import UIKit

class MyCommunitiesViewController: UIViewController, MyCommunitiesViewProtocol {
    
    var presenter: MyCommunitiesPresenterProtocol?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - Communities - MyCommunitiesVC ")
    }

}
