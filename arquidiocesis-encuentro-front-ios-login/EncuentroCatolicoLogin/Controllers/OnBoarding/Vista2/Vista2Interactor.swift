import Foundation

class Vista2Interactor: Vista2InteractorInputProtocol {

    // MARK: Properties
    weak var presenter: Vista2InteractorOutputProtocol?
    var localDatamanager: Vista2LocalDataManagerInputProtocol?
    var remoteDatamanager: Vista2RemoteDataManagerInputProtocol?
    
    func guarda() {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "onboarding")
    }

}

extension Vista2Interactor: Vista2RemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
