//
//  FaithfulPresenter.swift
//  FielSOS
//
//  Created by René Sandoval on 21/03/21.
//

import Foundation

final class FaithfulPresenter: FaithfulPresenterType, FaithfulInteractorOutputsType {
    var service: Service!
    var priest: Priest!

    weak var view: FaithfulViewType?
    var interactor: FaithfulInteractorInputsType?
    var wireframe: FaithfulWireframeType?

    private var locations = [LocationSOS]()

    func onViewDidLoad() {
        view?.showLoading()
        view?.setService(service: service)
        interactor?.getLocations()
    }

    func didRetrieveLocations(_ locations: [LocationSOS]) {
        for item in locations{
            if item.image_url != "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"{
                self.locations.append(item)
            }
        }
        //self.locations = locations
        view?.hideLoading()
        view?.didReceiveLocations()
    }

    func onRegisterService(withParameters parameters: [String: Any?]) {
        view?.showLoading()
        interactor?.registerServices(parameters: parameters)
    }

    func didRegisterServicesSuccess(status: Bool, id: Int) {
        view?.hideLoading()
        view?.didRegisterService(status: status, id: id)
    }

    func numberOfListItems() -> Int {
        return locations.count
    }

    func listItem(at index: Int) -> LocationSOS {
        return locations[index]
    }
}
