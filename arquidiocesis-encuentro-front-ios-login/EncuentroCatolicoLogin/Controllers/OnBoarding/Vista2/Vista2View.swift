import Foundation
import UIKit

class Vista2View: UIViewController {

    // MARK: Properties
    var presenter: Vista2PresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad() 
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(gestoSwipe(gesture:)))
        swipe.numberOfTouchesRequired = 1
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(swipe)
        NotificationCenter.default.addObserver(self, selector: #selector(popToLogin), name: NSNotification.Name(rawValue: "LogOut"), object: nil)
    }
    
    @objc func popToLogin(){
        print("Notificación recibida")
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func gestoSwipe(gesture: UISwipeGestureRecognizer) {
        presenter?.siguiente(controller: self)
    }
    
    @IBAction func omitirAction(_ sender: Any) {
        presenter?.siguiente(controller: self)
    }
    
    @IBAction func siguienteAction(_ sender: Any) {
        presenter?.siguiente(controller: self)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension Vista2View: Vista2ViewProtocol {
    // TODO: implement view output methods
}
