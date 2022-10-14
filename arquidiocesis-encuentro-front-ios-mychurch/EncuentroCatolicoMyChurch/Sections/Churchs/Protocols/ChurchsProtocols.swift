//
//  ChurchsProtocols.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import UIKit

protocol ChurchsViewType: class {
    var presenter: ChurchsPresenterType? { get set }
    func didReceiveChurchs()
    func showLoading()
    func hideLoading()
    func displayAlert(for id: Int)
}

protocol ChurchsWireframeType: class {
    static func createChurchsModule() -> UIViewController
}

protocol ChurchsPresenterType: class {
    var view: ChurchsViewType? { get set }
    var interactor: ChurchsInteractorInputsType? { get set }
    var wireframe: ChurchsWireframeType? { get set }

    func onViewDidLoad()
    func didChangeQuery(_ query: String?)
    func didSelectRow(_ indexPath: IndexPath)

    func numberOfListItems() -> Int
    func listItem(at index: Int) -> RepoViewModel
}

protocol ChurchsInteractorInputsType: class {
    var presenter: ChurchsInteractorOutputsType? { get set }
    func fetchChurchs(for query: String)
    func fetchInitialChurchs()
}

protocol ChurchsInteractorOutputsType: class {
    func didRetrieveChurchs(_ Churchs: [Church])
}

protocol ChurchsRemoteDataManagerType: class {
    func fetchChurchs(for query: String, completion: @escaping ([Church]) -> Void)
}
