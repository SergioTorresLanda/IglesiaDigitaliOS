//
//  FaithfulProtocols.swift
//  FielSOS
//
//  Created by René Sandoval on 21/03/21.
//

import UIKit

protocol FaithfulViewType: class {
    var presenter: FaithfulPresenterType? { get set }
    func setService(service: Service)
    func didReceiveLocations()
    func didRegisterService(status: Bool, id: Int)
    func showLoading()
    func hideLoading()
}

protocol FaithfulWireframeType: class {
    static func createFaithfulModule(service: Service) -> UIViewController
}

protocol FaithfulPresenterType: class {
    var priest: Priest! { get set }
    var service: Service! { get set }
    var view: FaithfulViewType? { get set }
    var interactor: FaithfulInteractorInputsType? { get set }
    var wireframe: FaithfulWireframeType? { get set }

    func onViewDidLoad()
    func onRegisterService(withParameters parameters: [String: Any?])
    func numberOfListItems() -> Int
    func listItem(at index: Int) -> LocationSOS
}

protocol FaithfulInteractorInputsType: class {
    var presenter: FaithfulInteractorOutputsType? { get set }
    func getLocations()
    func registerServices(parameters: [String: Any?])
}

protocol FaithfulInteractorOutputsType: class {
    func didRetrieveLocations(_ Locations: [LocationSOS])
    func didRegisterServicesSuccess(status: Bool, id: Int)
}

protocol LocationsRemoteDataManagerType: class {
    func getLocations(for query: String, completion: @escaping ([LocationSOS]) -> Void)
    func registerService(withParameters parameters: [String: Any?], completion: @escaping (Bool) -> Void)
}
