//
//  paymentCompleted.swift
//  EncuentroCatolicoUtils
//
//  Created by Desarrollo on 25/03/21.
//

import UIKit
import Lottie

public class paymentCompleted: UIViewController {
    
    @IBOutlet weak var lootieView   : AnimationView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        lootieView.animation = Animation.named("success2", bundle:  Bundle(identifier:"mx.arquidiocesis.EncuentroCatolicoUtils")!)
        lootieView.loopMode = .loop
        lootieView.contentMode = .scaleAspectFit
        lootieView.animationSpeed = 0.5
        lootieView.play()
    }
}
