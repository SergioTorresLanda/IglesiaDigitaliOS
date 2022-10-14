import Foundation
import UIKit

class Vista2Presenter  {
    
    // MARK: Properties
    weak var view: Vista2ViewProtocol?
    var interactor: Vista2InteractorInputProtocol?
    var wireFrame: Vista2WireFrameProtocol?
    
}

extension Vista2Presenter: Vista2PresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func siguiente(controller: UIViewController) {
        interactor?.guarda()
        wireFrame?.siguiente(controller: controller)
    }
    
}

extension Vista2Presenter: Vista2InteractorOutputProtocol {
    // TODO: implement interactor output methods
}
