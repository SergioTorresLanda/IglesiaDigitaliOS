//
//  ViewController.swift
//  FielSOS
//
//  Created by René Sandoval on 20/03/21.
//

import UIKit

class FaithfulViewController: UIViewController {
    var presenter: FaithfulPresenterType?
    
    private lazy var navBarImageView: UIImageView = setupNavBarImageView()
    private lazy var backButton: UIButton = setupBackButton()
    private lazy var navBarTitleLabel: UILabel = setupNavBarTitleLabel()
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var subtitleLabel: UILabel = setupSubtitleLabel()
    private lazy var faithfulCollectionView: UICollectionView = setupFaithfulCollectionView()
    
    var nameIglesias: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter?.onViewDidLoad()
    }
    
    private func configureView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        [navBarImageView, backButton, navBarTitleLabel, titleLabel, subtitleLabel, faithfulCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        navBarImageView.topAnchor(equalTo: view.topAnchor, constant: -10)
        navBarImageView.widthAnchor(equalTo: view.frame.width + 20)
        navBarImageView.heightAnchor(equalTo: 118)
        navBarImageView.centerXAnchor(equalTo: view.centerXAnchor)
        
        backButton.centerYAnchor(equalTo: navBarImageView.centerYAnchor, constant: 30)
        backButton.leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
        backButton.widthAnchor(equalTo: 15)
        backButton.heightAnchor(equalTo: 20)
        
        navBarTitleLabel.centerXAnchor(equalTo: navBarImageView.centerXAnchor)
        navBarTitleLabel.centerYAnchor(equalTo: navBarImageView.centerYAnchor, constant: 30)
        
        titleLabel.topAnchor(equalTo: navBarTitleLabel.bottomAnchor, constant: 40)
        titleLabel.widthAnchor(equalTo: view.frame.width - 20)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)
        
        subtitleLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 10)
        subtitleLabel.widthAnchor(equalTo: view.frame.width - 20)
        subtitleLabel.heightAnchor(equalTo: 20)
        subtitleLabel.centerXAnchor(equalTo: view.centerXAnchor)
        
        faithfulCollectionView.topAnchor(equalTo: subtitleLabel.bottomAnchor, constant: 25.0)
        faithfulCollectionView.leadingAnchor(equalTo: view.leadingAnchor, constant: 10)
        faithfulCollectionView.trailingAnchor(equalTo: view.trailingAnchor, constant: -10)
        faithfulCollectionView.bottomAnchor(equalTo: view.safeBottomAnchor)
        faithfulCollectionView.showsVerticalScrollIndicator = false
        faithfulCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        self.present(loadingAlert, animated: false, completion: nil)
    }
    
    func hideLoading(){
        loadingAlert.dismiss(animated: false, completion: nil)
    }
}

// MARK: - Actions
extension FaithfulViewController {
    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Views
extension FaithfulViewController {
    private func setupNavBarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 129/255, alpha: 1.0)
        imageView.contentMode = .scaleToFill
        return imageView
    }
    
    private func setupBackButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return button
    }
    
    private func setupNavBarTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Emergencia"
        label.font = .boldSystemFont(ofSize: 18.0)
        label.textColor = .white
        return label
    }
    
    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = Colors.titles
        return label
    }
    
    private func setupSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Iglesias y sacerdotes cercanos"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = Colors.titles
        return label
    }
    
    private func setupFaithfulCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(FaithfulCollectionViewCell.self, forCellWithReuseIdentifier: FaithfulCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }
}

// MARK: - ChurchsViewType

extension FaithfulViewController: FaithfulViewType {
    func didRegisterService(status: Bool, id: Int) {
        if status == true{
            let alert = AlertOneButtonViewController.showAlert(titulo: "RECIBIMOS TU SOLICITUD", mensaje: "En breve el Párroco \(presenter?.priest.name ?? "") se comunicara contigo.")
            present(alert, animated: true) {
                DispatchQueue.main.async {
                    let timerView = TimerSOS()
                    timerView.name = self.presenter?.priest.name
                    timerView.serviceId = id
                    timerView.nameCapilla = self.nameIglesias
                    self.navigationController?.pushViewController(timerView, animated: true)
                }
            }
        }else{
            let alert = AlertOneButtonViewController.showAlert(titulo: "Ocurrió un error", mensaje: "No pudimos crear tu solicitud, por favor intenta más tarde")
            present(alert, animated: true)
        }
    }
    
    func setService(service: Service) {
        titleLabel.text = service.name
    }
    
    func didReceiveLocations() {
        faithfulCollectionView.reloadData()
    }
    
    //    func showLoading() {
    //        LoadingIndicatorView.show()
    //    }
    //
    //    func hideLoading() {
    //        LoadingIndicatorView.hide()
    //    }
}

// MARK: - UICollectionView

extension FaithfulViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SelectionDelegate {
    func didSelect(id: Int, priest: Priest, nameIgl: String) {
        nameIglesias = nameIgl
        presenter?.priest = priest
        let parameters = [
            "devotee": [
                "devotee_id": UserDefaults.standard.integer(forKey: "id"),
                "phone": UserDefaults.standard.string(forKey: "telefono") ?? "",
            ],
            "service": [
                "id": presenter?.service.id ?? 0,
                "type": "SOS"
            ],
            "priest": [
                //                "priestId": presenter?.priest.priestId,
                "priest_id" : priest.priest_id,
            ],
            "location": [
                "id": id,
            ],
            "latitude": 19.392642,
            "longitude": -99.08929,
        ] as [String: Any]
        
        presenter?.onRegisterService(withParameters: parameters)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.numberOfListItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FaithfulCollectionViewCell.id, for: indexPath) as? FaithfulCollectionViewCell else {
            fatalError("Could not cast FaithfulCollectionViewCell")
        }
        
        //        cell.distanceChurchLabel = presenter.listItem(at: indexPath.row)
        cell.location = presenter.listItem(at: indexPath.row)
        cell.selectionDelegate = self
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var baseHeightPriest = 45
        
        if let totalPriest = presenter?.listItem(at: indexPath.row).priests.count {
            baseHeightPriest += baseHeightPriest * totalPriest
        }
        
        return CGSize(width: collectionView.frame.size.width, height: CGFloat(100 + baseHeightPriest))
    }
}

extension FaithfulViewController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            print("Delete action triggered")
            self.deleteItem(at: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "imgOK")
        
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .drag
        return options
    }
    
    func deleteItem(at indexPath: IndexPath){
        
    }
}
