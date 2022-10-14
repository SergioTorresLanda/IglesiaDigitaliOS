import Foundation

class Vista1Interactor: Vista1InteractorInputProtocol {

    // MARK: Properties
    weak var presenter: Vista1InteractorOutputProtocol?
    var localDatamanager: Vista1LocalDataManagerInputProtocol?
    var remoteDatamanager: Vista1RemoteDataManagerInputProtocol?
    
    func guardar() {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "onboarding")
    }

}

extension Vista1Interactor: Vista1RemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
