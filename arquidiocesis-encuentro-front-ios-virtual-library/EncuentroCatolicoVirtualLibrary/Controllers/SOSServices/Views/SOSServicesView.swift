//
//  SOSServicesView.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 20/03/21.
//

import Foundation
import UIKit

class SOSServicesView: UIViewController {
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)

    var idToSend: Int?
    var statusToSend: String = ""
    var datasource: [StatusModel] = []
    let id = UserDefaults.standard.integer(forKey: "id")
    var status: StatusSOS?
    var presenter: SOSPresenterServiciosProtocol?
    lazy var switchBtn: UISwitch = {
        let swi = UISwitch()
        swi.isOn = true
        swi.setOn(true, animated: false)
        swi.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        swi.translatesAutoresizingMaskIntoConstraints = false
        return swi
    }()

    lazy var lblTitle1: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 14)
        lbl.textColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
        lbl.text = "Activa Emergencia"
        return lbl
    }()

    lazy var lblTitle2: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 12)
        lbl.textColor = .gray
        lbl.text = "Activa el servicio de emergencia, podras recibir, aceptar y rechazar solicitudes."
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2

        return lbl
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

    private func setUpLoader() {
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
        setUpLoader()
        indicator.startAnimating()
        presenter?.getStatus(id: id)
    }

    private func initUI() {
        view.backgroundColor = .white
        view.addSubview(newCollection)
        view.addSubview(lblTitle1)
        view.addSubview(lblTitle2)
        view.addSubview(switchBtn)

        newCollection.delegate = self
        newCollection.dataSource = self
        newCollection.register(CustomeCell.self, forCellWithReuseIdentifier: cellId)
        setConstraints()
    }

    func setConstraints() {
        switchBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        switchBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        switchBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 120).isActive = true
        switchBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

        lblTitle1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblTitle1.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lblTitle1.leftAnchor.constraint(equalTo: switchBtn.rightAnchor, constant: 25).isActive = true
        lblTitle1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true

        lblTitle2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblTitle2.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lblTitle2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 17).isActive = true
        lblTitle2.topAnchor.constraint(equalTo: switchBtn.bottomAnchor, constant: 10).isActive = true

        newCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newCollection.topAnchor.constraint(equalTo: lblTitle2.bottomAnchor, constant: 30).isActive = true
        newCollection.heightAnchor.constraint(equalToConstant: view.bounds.height - 150).isActive = true
        newCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true

        newCollection.isUserInteractionEnabled = true
    }

    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if sender.isOn == true {
            print("on")
            lblTitle2.textColor = .gray
            presenter?.changeStatus(id: id, status: true)
        } else {
            lblTitle2.textColor = UIColor(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 0.5)
            presenter?.changeStatus(id: id, status: false)
        }
    }

    private func actionCancelarStatus() {
        presenter?.changeStatusService(id: idToSend ?? 0, status: "CANCELED")
        let alert = AlertOneButtonViewController.showAlert(titulo: "Cancelar Servicio", mensaje: "El servicio será cancelado y se le notificará al fiel")

        alert.presentartAlerta(en: self)
        presenter?.getStatus(id: id)
    }

    private func actionRechazarrStatus() {
        presenter?.changeStatusService(id: idToSend ?? 0, status: "CANCELED")
        let alert = AlertOneButtonViewController.showAlert(titulo: "Servicio Rechazado", mensaje: "El servicio será cancelado y se le notificará al fiel.")
        alert.presentartAlerta(en: self)
        presenter?.getStatus(id: id)
    }

    private func actionAceptarStatus(service: String) {
        presenter?.changeStatusService(id: idToSend ?? 0, status: "COMPLETED")
        presenter?.getStatus(id: id)
    }

    private func actionConcluirStatus() {
        presenter?.changeStatusService(id: idToSend ?? 0, status: "COMPLETED")
        let alert = AlertOneButtonViewController.showAlert(titulo: "Concluir Servicios", mensaje: "El servicio será concluido y se le notificará al fiel")
        alert.presentartAlerta(en: self)
        
        presenter?.getStatus(id: id)
    }

    public func callServiceChangeStatus() {
        indicator.startAnimating()
        presenter?.changeStatusService(id: idToSend ?? 0, status: statusToSend)
    }

    func makePhoneCall(phoneNumber: String) {
        if let phoneURL = NSURL(string: "tel://" + phoneNumber) {
            let alert = UIAlertController(title: "Call " + phoneNumber + "?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { _ in
                UIApplication.shared.open(phoneURL as URL, options: [:], completionHandler: nil)
                print("handler call")
                self.actionAceptarStatus(service: "ACCEPTED")
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    func switchResponseActions(status: Bool) {
        if status {
            switchBtn.isOn = true
        } else {
            switchBtn.isOn = false
        }
        presenter?.getData(id: UInt(id), status: StatusSOS.IN_PROGRESS)
    }
}

extension SOSServicesView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }

    #warning("Separar celdas ")
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomeCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.gray.cgColor
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 2, height: 2.0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false

        cell.configureCell(data: datasource[indexPath.row])
        cell.cellDelegate = self
        cell.delegate = self
        // cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 20, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}

extension SOSServicesView: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        
        var actions: [SwipeAction] = []
        
        // Delete Action
        let deleteAction = SwipeAction(style: .destructive, title: nil) { [self] _, indexPath in
            print("Delete action triggered")
            self.idToSend = self.datasource[indexPath.row].id
            self.actionCancelarStatus()
//            self.deleteItem(at: indexPath)
        }
        deleteAction.image = UIImage(named: "trash_icon", in: Bundle.local, compatibleWith: nil)
        deleteAction.backgroundColor = UIColor(red: 253 / 255, green: 13 / 255, blue: 27 / 255, alpha: 1.0)

        // Accept Action
        let acceptAction = SwipeAction(style: .default, title: nil) { _, indexPath in
            print("Accept action triggered")
            // self.acceptItem(at: indexPath)
            self.idToSend = self.datasource[indexPath.row].id
            let status = self.selectStatus(status: self.datasource[indexPath.row].status ?? "")
            
            if status != "" {
                self.actionAceptarStatus(service: status)
            }
            
        }
        acceptAction.hidesWhenSelected = true
        acceptAction.image = UIImage(named: "check_icon", in: Bundle.local, compatibleWith: nil)
        acceptAction.backgroundColor = UIColor(red: 19 / 255, green: 39 / 255, blue: 124 / 255, alpha: 1.0)

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

    func deleteItem(at indexPath: IndexPath) {
        print("DELETE: \(datasource[indexPath.row])")
    }

    func acceptItem(at indexPath: IndexPath) {
        print("ACEPTED: \(datasource[indexPath.row])")
    }
    
    func selectStatus(status: String)-> String {
        
        var statusToSend: String?
        switch status {
        case "ACCEPTED":
            statusToSend = "COMPLETED";
            break

        case "COMPLETED":
            statusToSend = "";
            break

        case "IN_PROGRESS":
            statusToSend = "ACCEPTED";
            
            break
        default:
            statusToSend = "nil"
            break
        }
        
        return statusToSend ?? "nil"
    }
}

extension SOSServicesView: ProtocolCellView {
    func tapImage(status: String, id: Int) {
        self.makePhoneCall(phoneNumber: "5598798696")
    }
    
    func tapButtonLeft(status: String, id: Int) {
        idToSend = id
        statusToSend = "CANCELED"
        actionCancelarStatus()
    }

    func tapButtonRight(status: String, id: Int, service: String) {
        switch status {
        case "ACCEPTED":
            idToSend = id
            statusToSend = "COMPLETED"
            actionConcluirStatus()
            break

        case "COMPLETED":
            break

        case "IN_PROGRESS":
            idToSend = id
            statusToSend = "ACCEPTED"
            actionAceptarStatus(service: service)
            break
        default:
            break
        }
    }
}

extension SOSServicesView: SOSViewServiciosProtocol {
    func successChangeServiceStatus() {
        presenter?.getStatus(id: id)
    }

    func showResult(result: [StatusModel]) {
        indicator.stopAnimating()
        datasource = result
        newCollection.reloadData()
        initUI()
    }

    func showResponseStatus(status: Bool?) {
        switchResponseActions(status: status ?? false)
    }

    func showError(_ error: String) {
        indicator.stopAnimating()
    }
}

extension SOSServicesView: SubDelegateAlert {
    func refuseButton(action: AlertTwoButtonsViewController) {
        callServiceChangeStatus()
    }

    func scheduleButton(action: AlertTwoButtonsViewController) {
        callServiceChangeStatus()
    }

    func acceptServiceButton(action: AlertOneButtonViewController) {
        callServiceChangeStatus()
    }
}
