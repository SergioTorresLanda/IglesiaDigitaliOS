//
//  SOSServicesView.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 20/03/21.
//

import Foundation
import UIKit


class NotificationView: UIViewController {
    let urlOptionalImage = "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png"
    let id = UserDefaults.standard.integer(forKey: "id") 
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var idToSend: Int?
    var statusToSend: String = ""
    var datasource: [StatusModelNotification] = []
    var status: StatusSOS?
    var presenter: NotificationPresenterProtocol?
    var noData = true
    var dataChangeFlag: Bool = false
    
    lazy var  navImageBackground : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 129/255, alpha: 1.0)
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        return img
    }()
    
    lazy var btnBack: UIButton =  {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popViewNotification), for: .touchUpInside)
        return button
    }()
    
    lazy var lblNav : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Notificaciones"
        label.font = .boldSystemFont(ofSize: 18.0) 
        label.textColor = .white
        return label
    }()
    
    lazy var lblTitle : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "S.O.S"
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 22.0)
        label.textColor = .black
        return label
    }()
    
    let cellId = "cellId"
    
    let newCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = true
        // collection.contentSize = CGSize(width: 2000 , height: 400)
        return collection
    }()
    
    private func setUpLoader(){
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showLoading()
        self.presenter?.getData(id: UInt(id) , status: StatusSOS.IN_PROGRESS)
    }
    
    private func initUI(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
        
        self.view.addSubview(newCollection)
        self.view.addSubview(self.navImageBackground)
        self.view.addSubview(self.btnBack)
        self.view.addSubview(self.lblNav)
        self.view.addSubview(self.lblTitle)
        
        //newCollection.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        newCollection.delegate = self
        newCollection.dataSource = self
        newCollection.register(CustomeCellNotification.self, forCellWithReuseIdentifier: cellId)
        
        let dimensions: CGRect = CGRect(x: 25, y: 180, width: 345, height: 81)
        let data = DataHeaderNotification(title: self.datasource.first?.location?.name ?? "No Priest", horarios: "7:00 hrs - 20:00 hrs", img: self.datasource.first?.location?.imageURL ?? urlOptionalImage, km: self.datasource.first?.location?.distance ??  0.0)
        let header = HeaderNotificationView(frame: dimensions, data: data)
        header.layer.shadowColor = UIColor.lightGray.cgColor
        header.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        header.layer.shadowRadius = 1.0
        header.layer.shadowOpacity = 1.0
        header.layer.masksToBounds = false
        self.view.addSubview(header)
        setConstraints()
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        }
        loadingAlert.view.addSubview(imageView)
        self.present(loadingAlert, animated: false, completion: nil)
    }
    
    func hideLoading(){
        self.loadingAlert.dismiss(animated: false, completion: nil)
    }
    
    func setConstraints(){
        
        self.navImageBackground.topAnchor(equalTo: view.topAnchor, constant: -10)
        self.navImageBackground.widthAnchor(equalTo: view.frame.width + 20)
        self.navImageBackground.heightAnchor(equalTo: 118)
        self.navImageBackground.centerXAnchor(equalTo: view.centerXAnchor)
        
        
        self.btnBack.centerYAnchor(equalTo: navImageBackground.centerYAnchor, constant: 27)
        self.btnBack.leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
        self.btnBack.widthAnchor(equalTo: 15)
        self.btnBack.heightAnchor(equalTo: 20)
        
        self.lblNav.centerXAnchor(equalTo: navImageBackground.centerXAnchor)
        self.lblNav.centerYAnchor(equalTo: navImageBackground.centerYAnchor, constant: 27)
        
        
        self.lblTitle.centerXAnchor(equalTo: self.view.centerXAnchor)
        self.lblTitle.centerYAnchor(equalTo: self.navImageBackground.centerYAnchor, constant: 90)
        self.lblTitle.widthAnchor(equalTo: 120)
        self.lblTitle.heightAnchor(equalTo: 100)
        
        self.newCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.newCollection.topAnchor.constraint(equalTo: self.navImageBackground.bottomAnchor, constant: 165).isActive = true
        self.newCollection.heightAnchor.constraint(equalToConstant: self.view.bounds.height - 365).isActive = true
        
        self.newCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        self.newCollection.isUserInteractionEnabled = true
        
    }
    
    @objc func popViewNotification() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func showCancelAlert(){
        let alert = AlertOneButtonViewController.showAlert(titulo: "Cancelar Servicio", mensaje: "El servicio será cancelado y se le notificará al fiel")
        alert.delegate = self
        alert.presentartAlerta(en: self)
        self.callServiceChangeStatus()
    }
    
    private func showConfirmAlert(){
        let alert = AlertOneButtonViewController.showAlert(titulo: "Aceptar Servicio", mensaje: "El servicio será aceptado y se le notificará al fiel")
        alert.delegate = self
        alert.presentartAlerta(en: self)
        self.callServiceChangeStatus()
    }
    
    public func callServiceChangeStatus() {
        self.indicator.startAnimating()
        self.presenter?.changeStatusService(id: self.idToSend ?? 0, status: self.statusToSend )
    }
    
}

extension NotificationView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.datasource.count != 0 {
            return self.datasource.count
        }
        
        else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomeCellNotification
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2.0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.delegate = self
        
        if datasource.count != 0 {
            noData = false
            cell.configureCell(data: self.datasource[indexPath.row], noData: noData, flagX: false)
        }
        
        else {
            cell.configureCell(data: nil, noData: noData, flagX: self.dataChangeFlag)
        }
        
        //cell.clipsToBounds = true
        
        //cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width - 20, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}


extension NotificationView: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        var actions: [SwipeAction] = []
        
        // Delete Action
        let deleteAction = SwipeAction(style: .destructive, title: nil) { [self] _, indexPath in
            self.idToSend = self.datasource[indexPath.row].id
            self.statusToSend = "CANCELED"
            self.showCancelAlert()
        }
        
        deleteAction.image = UIImage(named: "trash_icon", in: Bundle.local, compatibleWith: nil)
        //deleteAction.backgroundColor = UIColor(red: 253 / 255, green: 13 / 255, blue: 27 / 255, alpha: 1.0)
        
        let acceptAction = SwipeAction(style: .default, title: nil) { _, indexPath in
            self.idToSend = self.datasource[indexPath.row].id
            self.statusToSend = "COMPLETED"
            self.showConfirmAlert()
        }
        acceptAction.hidesWhenSelected = true
        acceptAction.image = UIImage(named: "check_icon", in: Bundle.local, compatibleWith: nil)
        //acceptAction.backgroundColor = UIColor(red: 19 / 255, green: 39 / 255, blue: 124 / 255, alpha: 1.0)
        
        //Changes ulises
        
        switch datasource[indexPath.row].status {
        case "ACCEPTED":
            actions.append(acceptAction)
            actions.append(deleteAction)
            //Remover vista del call
            break;
            
        case "CANCELED":
            //Se oculatan todos los swips incluyendo telefono
            break;
            
        case "COMPLETED":
            //Se oculatan todos los swips incluyendo telefono
            
            break;
            
        case "IN_PROGRESS":
            //se muestra telefono
            actions.append(acceptAction)
            actions.append(deleteAction)
            break;
        default:
            break;
        }
        
        return actions
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .selection
        options.transitionStyle = .drag
        return options
    }
}

extension NotificationView: NotificationViewProtocol {
    func successChangeServiceStatus() {
        self.presenter?.getStatus(id: self.id)
    }
    
    func showResult(result: [StatusModelNotification]) {
        //        self.indicator.stopAnimating()
        self.datasource = result
        self.newCollection.reloadData()
        self.hideLoading()
        self.dataChangeFlag = true
        //self.datasource.removeAll()
        self.newCollection.reloadData()
        //
        self.initUI()
    }
    
    func showResponseStatus(status: Bool?) {
        self.newCollection.reloadData()
        //self.switchResponseActions(status: status ?? false)
    }
    
    func showError(_ error: String) {
        //        self.indicator.stopAnimating()
        self.hideLoading()
    }
}

extension NotificationView: SubDelegateAlert {
    func refuseButton(action: AlertTwoButtonsViewController) {
        self.callServiceChangeStatus()
    }
    
    func scheduleButton(action: AlertTwoButtonsViewController) {
        self.callServiceChangeStatus()
    }
    
    func acceptServiceButton(action: AlertOneButtonViewController) {
        self.callServiceChangeStatus()
    }
}
