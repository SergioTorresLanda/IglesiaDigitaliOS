//
//  ChurchsViewController.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import UIKit

class ChurchsViewController: UIViewController {
    var presenter: ChurchsPresenterType?
    
    private lazy var navBarImageView: UIImageView = setupNavBarImageView()
    private lazy var backButton: UIButton = setupBackButton()
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var churchsTableView: UITableView = setupChurchsTableView()
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        presenter?.onViewDidLoad()
    }
    
    private func configureUI() {
        view.backgroundColor = .white // PrimaryColor().blue
        
        [navBarImageView, backButton, titleLabel, churchsTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        navBarImageView.topAnchor(equalTo: view.topAnchor, constant: -10)
        navBarImageView.widthAnchor(equalTo: view.frame.width + 20)
        navBarImageView.heightAnchor(equalTo: 150)
        navBarImageView.centerXAnchor(equalTo: view.centerXAnchor)
        
        backButton.centerYAnchor(equalTo: navBarImageView.centerYAnchor, constant: 10)
        backButton.leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
        backButton.widthAnchor(equalTo: 15)
        backButton.heightAnchor(equalTo: 20)
        
        titleLabel.centerXAnchor(equalTo: navBarImageView.centerXAnchor)
        titleLabel.centerYAnchor(equalTo: navBarImageView.centerYAnchor)
        
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Busca una iglesia"
        
        churchsTableView.topAnchor(equalTo: navBarImageView.bottomAnchor)
        churchsTableView.leadingAnchor(equalTo: view.leadingAnchor)
        churchsTableView.trailingAnchor(equalTo: view.trailingAnchor)
        churchsTableView.bottomAnchor(equalTo: view.safeBottomAnchor, constant: -50.0)
    }
    
}

// MARK: - Actions

extension ChurchsViewController {
    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Views

extension ChurchsViewController {
    private func setupNavBarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navbar_image", in: Bundle.local, compatibleWith: nil)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
    private func setupBackButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return button
    }
    
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Misas"
        label.font = .systemFont(ofSize: 18.0)
        label.textColor = .white
        return label
    }
    
    private func setupChurchsTableView() -> UITableView {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(ChurchTableViewCell.self, forCellReuseIdentifier: ChurchTableViewCell.id)
        tableView.tableHeaderView = searchController.searchBar
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
}

// MARK: - ChurchsViewType

extension ChurchsViewController: ChurchsViewType {
    func didReceiveChurchs() {
        churchsTableView.isHidden = false
        churchsTableView.reloadData()
    }
    
    func displayAlert(for id: Int) {
        let alertController = UIAlertController(title: "\(id)", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func hideLoading() {
        self.alert.dismiss(animated: false, completion: nil)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension ChurchsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.numberOfListItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChurchTableViewCell.id, for: indexPath) as? ChurchTableViewCell else {
            fatalError("Could not cast ChurchTableViewCell")
        }
        
        cell.setup(with: presenter.listItem(at: indexPath.row))
        
        return cell
    }
}

extension ChurchsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UISearchResultsUpdating & UISearchBarDelegate

extension ChurchsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // presenter?.didChangeQuery(searchController.searchBar.text)
    }
}

extension ChurchsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.count > 0{
            presenter?.onViewDidLoad()
            searchBar.text = ""
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.didChangeQuery(searchController.searchBar.text)
        searchBar.resignFirstResponder()
    }
}
