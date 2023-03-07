//
//  SOSView.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 19/03/21.
//

import Foundation
import UIKit
//import MTSlideToOpen

class SOSView: UIViewController {
    
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var btnEmergencia: UIButton!
    
    var dataSOS = ["Uncion de los enfermos", "Celebrar misa de difuntos en funeraria"]
    var sibDataSOS = ["Scaramenteo por el que Jesús cura, fortalece y consuela", ""]
    var indexCircle: Int?
    
    var selectedOption: Bool = false
    var id: Int?
    var nameService: String? = ""
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
   
    var presenter: SOSPresenterProtocol? 
    var dataSource: [SOSFielModel] = [SOSFielModel](){
        didSet{
            sosTableView.reloadData()
        }
    }
    
    lazy var sosTableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var btnSOS: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 24
        btn.backgroundColor = .gray
        btn.setTitle("Emergencia", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(self.callAlert), for: .touchUpInside)
        btn.tag = 4
        btn.isEnabled = false
        return btn

    }()
    
    lazy var lblTitle3: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.text = "¡Queremos Ayudarte!"
        
        return lbl
    }()
    
    lazy var lblTitle4: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.text = "¿Cual es tu emergencia?"
        
        return lbl
    }()
    
    lazy var imgCentral: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "imgSigno", in: Bundle.local, compatibleWith: nil)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var buttonDecorator: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrowToRight", in: Bundle.local, compatibleWith: nil)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.tintColor = .white
        return img
    }()
    
    let heightBtn: CGFloat = 48
    let widthBtn: CGFloat = 297
    
    let heightImg: CGFloat = 20
    let widthImg: CGFloat = 20
    
    let colorBG = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    let colorBlue = UIColor(red: 25.0/255, green: 42.0/255, blue: 114.0/255, alpha: 1.0)
    let imgOK: UIImage = UIImage(named: "imgOK", in: Bundle.local, compatibleWith: nil) ?? UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = UserDefaults.standard.integer(forKey: "id")
//        self.callV()
        setupUI()
        showLoading()
        self.presenter?.getData(id: UInt(id))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func callV() {
       let a =  BibliotecaRecursosRouter.presentModule()
        self.present(a, animated: true, completion: nil)
    }
//    private func callLoader(){
//        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
//        indicator.center = view.center
//        view.addSubview(indicator)
//        indicator.bringSubviewToFront(view)
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
    
    private func setupUI() {
        btnEmergencia.layer.cornerRadius = 10
        customNavBar.layer.cornerRadius = 20
        lblTitle1.adjustsFontSizeToFitWidth = true
        lblTitle2.adjustsFontSizeToFitWidth = true
        customNavBar.ShadowNavBar()
        
    }
    
    private func initUI(){
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.reloadData()
       
//        self.view.backgroundColor = .white
//        self.sosTableView.delegate = self
//        self.sosTableView.dataSource = self
//        self.sosTableView.register(SOSViewCell.self, forCellReuseIdentifier: "cell")
//
//        self.view.addSubview(self.imgCentral)
//        self.view.addSubview(self.lblTitle1)
//        self.view.addSubview(self.lblTitle2)
//        self.view.addSubview(self.sosTableView)
//        self.view.addSubview(self.btnSOS)
//        self.view.addSubview(self.buttonDecorator)
//        self.setConstraints()
    }
    
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    func hideLoading(){
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            imgCentral.heightAnchor.constraint(equalToConstant: 150),
            imgCentral.widthAnchor.constraint(equalTo: imgCentral.heightAnchor),
            imgCentral.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imgCentral.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            
            lblTitle1.heightAnchor.constraint(equalToConstant: 30),
            lblTitle1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            lblTitle1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            lblTitle1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblTitle1.topAnchor.constraint(equalTo: self.imgCentral.bottomAnchor, constant: 10),
            
            lblTitle2.heightAnchor.constraint(equalToConstant: 30),
            lblTitle2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            lblTitle2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            lblTitle2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0),
            lblTitle2.topAnchor.constraint(equalTo: self.lblTitle1.bottomAnchor, constant: 0),
            
            
            btnSOS.heightAnchor.constraint(equalToConstant: 48),
            btnSOS.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            btnSOS.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            btnSOS.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -120),
            
            buttonDecorator.heightAnchor.constraint(equalToConstant: 28),
            buttonDecorator.widthAnchor.constraint(equalToConstant: 28),
            buttonDecorator.centerYAnchor.constraint(equalTo: btnSOS.centerYAnchor),
            buttonDecorator.trailingAnchor.constraint(equalTo: btnSOS.trailingAnchor, constant: -10),
            
            sosTableView.topAnchor.constraint(equalTo: lblTitle2.bottomAnchor, constant: 20),
            sosTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            sosTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            sosTableView.bottomAnchor.constraint(equalTo: self.btnSOS.topAnchor, constant: -10)
            
        ])

        
       
//        @objc func tapButtonAction() {
//        switch sender.tag {
//        case 1:
////            let alert = AlertSingleViewController.showAlert(titulo: "UNCIÓN DE LOS ENFERMOS", mensaje: "Sacramento que da la Iglesia para atraer la salud de alma, espíritu y cuerpo al cristiano en estado de enfermedad grave o vejez")
////            alert.presentartAlerta(en: self)
//
//            //Original
//            self.btnExtramucion.setTitleColor(self.colorBlue, for: .normal)
//            self.btnExtramucion.backgroundColor = .white
//            self.btnExtramucion.layer.borderColor = self.colorBlue.cgColor
//            self.btnExtramucion.layer.borderWidth = 1.0
//            self.btnUnicion.setTitleColor(.white, for: .normal)
//            self.btnUnicion.backgroundColor = self.colorBlue
//            self.btnMisa.setTitleColor(.white, for: .normal)
//            self.btnMisa.backgroundColor = self.colorBlue
//            self.id = self.dataSource[0].id ?? 1
//            self.nameService = self.dataSource[0].name ?? ""
//            self.descriptionService = self.dataSource[0].description
//            self.btnSOS.isEnabled = true
//            self.btnSOS.backgroundColor = self.colorBlue
//            self.btnExtramucion.moveImageLeftTextCenterSOSFiel(image: self.imgOK, imagePadding: 55.0, renderingMode: .alwaysOriginal)
//
//            self.selectedOption = true
//          break
//
//        case 2:
////            let alert = AlertOneButtonViewController.showAlert(titulo: "CONCLUIR SERVICIO", mensaje: "El servicio será concluido y se notificará al fiel")
////            alert.presentartAlerta(en: self)
//
//            self.btnExtramucion.setTitleColor(.white, for: .normal)
//            self.btnExtramucion.backgroundColor = self.colorBlue
//            self.btnUnicion.setTitleColor(self.colorBlue, for: .normal)
//            self.btnUnicion.backgroundColor = .white
//            self.btnUnicion.layer.borderColor = self.colorBlue.cgColor
//            self.btnUnicion.layer.borderWidth = 1.0
//
//            //Original
//            self.btnMisa.setTitleColor(.white, for: .normal)
//            self.btnMisa.backgroundColor = self.colorBlue
//            self.btnUnicion.moveImageLeftTextCenterSOSFiel(image: self.imgOK, imagePadding: 35.0, renderingMode: .alwaysOriginal)
//
//            self.id = self.dataSource[1].id ?? 1
//            self.nameService = self.dataSource[1].name ?? ""
//            self.descriptionService = self.dataSource[1].description
//            self.btnSOS.backgroundColor = self.colorBlue
//            self.btnSOS.isEnabled = true
//            self.selectedOption = true
//            break
//
//        case 3:
////            let alert = AlertTwoButtonsViewController.showAlert(titulo: "S.O.S", mensaje: "Tienes una solicitud", otro: "UNICIÓN DE LOS ENFERMOS")
////            alert.presentartAlerta(en: self)
//
//            self.btnExtramucion.setTitleColor(.white, for: .normal)
//            self.btnExtramucion.backgroundColor = self.colorBlue
//            self.btnMisa.setTitleColor(self.colorBlue, for: .normal)
//            self.btnMisa.backgroundColor = .white
//            self.btnMisa.layer.borderColor = self.colorBlue.cgColor
//            self.btnMisa.layer.borderWidth = 1.0
//
//
//            //Boton Original
//            self.btnUnicion.setTitleColor(.white, for: .normal)
//            self.btnUnicion.backgroundColor = self.colorBlue
//            self.btnMisa.moveImageLeftTextCenterSOSFiel(image: self.imgOK, imagePadding: 35.0, renderingMode: .alwaysOriginal)
//
//            self.id = self.dataSource[2].id ?? 1
//            self.nameService = self.dataSource[2].name ?? ""
//            self.descriptionService = self.dataSource[2].description
//            self.btnSOS.backgroundColor = self.colorBlue
//            self.selectedOption = true
//            self.btnSOS.isEnabled = true
//            self.sendToAnotherView()
//            break
//
//        case 4:
//            sender.backgroundColor = .red
//            sender.setTitle("Buscando...", for: .normal)
//            sender.setTitleColor(.white, for: .normal)
//
//
//
//            break
//        default:
//            break
//        }
//        }
    }
    
    @IBAction func actionEmergencia(_ sender: Any) {
        
        if self.nameService != "" && self.id != nil {
            sendToAnotherView()
        }else{
            showEmptyDataAlert()
        }

    }
    
    private func sendToAnotherView(){
        btnSOS.isEnabled = false
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.hideLoading()
            self.btnSOS.isEnabled = true
            let module = FaithfulWireframe.createFaithfulModule(service: Service(id: self.id, name: self.nameService))
            self.navigationController?.pushViewController(module, animated: true)
        }
    }
    
    private func showEmptyDataAlert() {
        let alert = AlertOneButtonViewController.showAlert(titulo: "Atención", mensaje: "Debes seleccionar un servicio para continuar")
        present(alert, animated: true, completion: nil)
        
    }
    
    
   @objc func callAlert(){
        guard
              self.nameService != "",
              self.id != nil
              else {
            return
        }
        sendToAnotherView()
    }
    
}

extension SOSView : SOSViewProtocol {
    func showResult(result: [SOSFielModel]) {
        var resultCopy = result
        resultCopy.removeAll(where: { $0.name == "Extremaunción"})
        self.dataSource = resultCopy
        print(dataSource)
        hideLoading()
        initUI()
    }

    func showError(_ error: String) {
        
    }
    
}

extension SOSView : SubDelegateAlert {
    func refuseButton(action: AlertTwoButtonsViewController) {
        
    }
    
    func scheduleButton(action: AlertTwoButtonsViewController) {
        
    }
    
    func acceptServiceButton(action: AlertOneButtonViewController) {
        
    }
}

extension SOSView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
       // return dataSOS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "CELLSOS", for: indexPath) as! SOSViewTableCell
        cell.cardView.layer.cornerRadius = 15
        cell.lblTitle1.text = dataSource[indexPath.row].name ?? ""
        cell.lblSubtitle.text = dataSource[indexPath.row].description ?? ""
        cell.cardView.ShadowCard()
        cell.cardView.backgroundColor = .white
        cell.fillCircle.alpha = 0
        
        if indexCircle != nil {
            
            if indexPath.row == indexCircle {
                
                if cell.fillCircle.alpha == 0 {
                    cell.fillCircle.alpha = 1
                }else{
                    cell.fillCircle.alpha = 0
                }
                
            }
            
        }
        
        return cell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SOSViewCell
//        cell.nameLabel.text = dataSource[indexPath.row].name ?? ""
//        cell.descriptionLabel.text = dataSource[indexPath.row].description ?? dataSource[indexPath.row].name
//        if #available(iOS 13.0, *) {
//            cell.checkImage.image =  dataSource[indexPath.row].id == self.id ? UIImage(named: "imgCheck", in: Bundle.local, with: nil) : UIImage(named:"")
//        } else {
//            // Fallback on earlier versions
//        }
//        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        id =  dataSource[indexPath.row].id
//        nameService =  dataSource[indexPath.row].name
//        btnSOS.isEnabled = true
//        btnSOS.backgroundColor = #colorLiteral(red: 0.05902313441, green: 0.1112141833, blue: 0.4248627126, alpha: 1)
//        sosTableView.reloadData()
        
        id = dataSource[indexPath.row].id
        nameService = dataSource[indexPath.row].name
        tableView.deselectRow(at: indexPath, animated: false)
        indexCircle = indexPath.row
        mainTable.reloadData()
        
    }
    
}
