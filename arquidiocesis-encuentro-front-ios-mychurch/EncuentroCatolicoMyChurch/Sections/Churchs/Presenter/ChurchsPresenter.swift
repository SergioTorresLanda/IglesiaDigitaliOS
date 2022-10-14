//
//  ChurchsPresenter.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

final class ChurchsPresenter: ChurchsPresenterType, ChurchsInteractorOutputsType {
    weak var view: ChurchsViewType?
    var interactor: ChurchsInteractorInputsType?
    var wireframe: ChurchsWireframeType?

    private var Churchs = [Church]()

    func onViewDidLoad() {
        view?.showLoading()
        interactor?.fetchInitialChurchs()
    }

    func didRetrieveChurchs(_ Churchs: [Church]) {
        self.Churchs = Churchs
        view?.hideLoading()
        view?.didReceiveChurchs()
    }

    func didChangeQuery(_ query: String?) {
        guard let query = query else { return }
        view?.showLoading()
        interactor?.fetchChurchs(for: query)
    }

    func didSelectRow(_ indexPath: IndexPath) {
        let id = Churchs[indexPath.row].id
        view?.displayAlert(for: id)
    }

    func numberOfListItems() -> Int {
        return Churchs.count
    }

    func listItem(at index: Int) -> RepoViewModel {
        let item = Churchs.map { RepoViewModel(repo: $0) }
        return item[index]
    }
}

struct RepoViewModel {
    let id: Int
    let name: String
}

extension RepoViewModel {
    init(repo: Church) {
        id = repo.id
        name = repo.name
    }
}
