//
//  alertViewController.swift
//  EncuentroCatolicoUtils
//
//  Created by Branchbit on 10/03/21.
//

import UIKit
import Lottie

public class alertViewController: UIViewController {
    
    @IBOutlet weak public var alertTitle          : UILabel!
    @IBOutlet weak public var alertMessage        : UILabel!
    @IBOutlet weak public var leftButton          : UIButton!
    @IBOutlet weak public var rightButton         : UIButton!
    @IBOutlet weak public var stackView           : UIStackView! 
    @IBOutlet weak public var alertView           : UIView!
    @IBOutlet weak public var imageView           : UIImageView!
    @IBOutlet weak public var alertHeight         : NSLayoutConstraint!
    @IBOutlet weak public var alertWidth          : NSLayoutConstraint!
    @IBOutlet weak var lootieView                 : AnimationView!
    
    var photoHeight: Float = 0.0
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        leftButton.isHidden = true
        configureAlertSize()
        alertView.layer.cornerRadius = 10
        alertView.layer.shadowColor = UIColor.black.cgColor
        alertView.layer.shadowOpacity = 0.2
        alertView.layer.shadowOffset = .zero
        alertView.layer.shadowRadius = 10
    }
    
    func configureAlertSize(){
        if imageView.isHidden == true && lootieView.isHidden == true{
            photoHeight = 0.0
        }else{
            if photoHeight > 150.0{
                photoHeight = 150.0
            }
        }
        
        if alertMessage.text!.count <= 40{
            alertHeight.constant = CGFloat(110.0 + photoHeight)
        }else{
            let textLarge =  (alertMessage.text!.count / 40) * 10
            var size = CGFloat(110.0 + Float(textLarge) + photoHeight)
            if size > 500{
                size = 500
            }
            alertHeight.constant = size
        }
    }

    public func setImage(image: UIImage){
        /*
         Para poner una imagen escribe el nombre de la imagen y el bundle identifier de la clase desde donde lo estás llamando
        controller.setImage(image: UIImage(named: "nombreImagen", in: Bundle(identifier: "BundleIdentifier"), compatibleWith: nil)!)
        */
        lootieView.isHidden = true
        imageView.isHidden = false
        imageView.image = image
        photoHeight = Float(image.size.height) + 20.0
        configureAlertSize()
    }
    
    public func setLottie(named: String){
        imageView.isHidden = true
        lootieView.isHidden = false
        lootieView.animation = Animation.named(named, bundle:  Bundle(identifier:"mx.arquidiocesis.EncuentroCatolicoUtils")!)
        lootieView.loopMode = .loop
        lootieView.contentMode = .scaleAspectFit
        lootieView.animationSpeed = 0.5
        lootieView.play()
        photoHeight = Float(130.0)
        configureAlertSize()
    }
    
    public func alertStyle(style: alertStyle){
        if style == EncuentroCatolicoUtils.alertStyle.titleOnMiddle{
            stackView.addArrangedSubview(self.stackView.subviews[0])
        }
    }
    
    public func configureAlert(title: String, message: String){
        alertTitle.text = title
        alertTitle.minimumScaleFactor = 0.9
        alertMessage.text = message
    }
    
    public func textAlignment(type: NSTextAlignment){
        alertTitle.textAlignment = type
    }
    
    public func titleAligment(type: NSTextAlignment){
        alertMessage.textAlignment = type
    }
    
    public func rightButtonText(title: String){
        rightButton.setTitle("OK", for: .normal)
    }
    
    @IBAction public func close(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

public extension UIViewController{
    func getAlertController() -> alertViewController{
        let controller = alertViewController()
        let bundle = Bundle(for: type(of: controller))
        bundle.loadNibNamed("alertViewController", owner: controller, options: nil)
        return controller
    }
}

public enum alertStyle{
    case titleOnTop
    case titleOnMiddle
}
