import Foundation
import UIKit

class Vista1Presenter  {
    
    // MARK: Properties
    weak var view: Vista1ViewProtocol?
    var interactor: Vista1InteractorInputProtocol?
    var wireFrame: Vista1WireFrameProtocol?
    
}

extension Vista1Presenter: Vista1PresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func omitir(controller: UIViewController) {
        interactor?.guardar()
        wireFrame?.omitir(controller: controller)
    }
    
    func siguiente(controller: UIViewController) {
        wireFrame?.siguiente(controller: controller)
    }
    
}

extension Vista1Presenter: Vista1InteractorOutputProtocol {
    // TODO: implement interactor output methods
}
