//
//  ECDonationToMyChurchVC.swift
//  EncuentroCatolicoDonations
//
//  Created by llavin on 24/11/22.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class ECDonationToMyChurchVC: UIViewController,ECDonationToMyChurchVCProtocol  {

    var presenter: ECDonationToMyChurchPresenterProtocol?
    //let viewBundle = Bundle.init(identifier: "mx.arquidiocesis.EncuentroCatolicoServices")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - ECDonationToMyChurchVC ")

    }
}
