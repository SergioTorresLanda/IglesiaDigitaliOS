//
//  AdminListView.swift
//  EncuentroCatolicoProfile
//
//  Created by 4n4rk0z on 06/05/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class AdminListView: UIViewController {
    var presenter: ProtocolosAdminListPresenter? 
    @IBOutlet weak var srcSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var passUserName = String()
    var userId = Int()
    var locationId = Int()
    var isAdmin = Bool()
    var isSuperAdmin = Bool()
    @IBOutlet weak var btnEdit: UIButton!
    var arrayPersons: [UserList] = []
    var bEdit: Bool = false
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let transition = SlideTransition()
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getData(id: locationId)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()

        initUI()
//        setNavigationBar()
        presenter?.getData(id: locationId)
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getData(id: locationId)
        //loadingAlert.dismiss(animated: true, completion: nil)
    }
    func setNavigationBar() {
        let navItem = UINavigationItem(title: "Nombrar Administradores")
        var image = UIImage(named:  "atrasIzq",in: Bundle.local,compatibleWith: nil)
        image = image?.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
        leftBarButtonItem.tintColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
        navItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    private func initUI() {
        //        self.navigationItem.title = "Colaboradores"
        //        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0)]
        //        var image = UIImage(named:  "atrasIzq",in: Bundle.local,compatibleWith: nil)
        //        image = image?.withRenderingMode(.alwaysOriginal)
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: self, action: #selector(addTapped))
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 800)
        tableView.backgroundColor = UIColor.eBackgroundGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AdminListCell", bundle: Bundle.local), forCellReuseIdentifier: "AdminListCell")
        tableView.separatorStyle = .singleLine
        tableView.reloadData()
        srcSearchBar.delegate = self
        
    }
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
           // self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    func showAlert(titleAlert: String, message: String) {
        let alert = AcceptAlert.showAlert(titulo: titleAlert, mensaje: message)
        alert.modalPresentationStyle = .overFullScreen
        alert.transitioningDelegate = self
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func addTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func returnTo(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func goToDetail(_ sender: Any) {
        presenter?.goToFormullary(id: userId, name: passUserName, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin)
    }
}

extension AdminListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayPersons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminListCell") as! AdminListCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let name = arrayPersons[indexPath.row].name
        let lastName = arrayPersons[indexPath.row].first_surname
        let fullName = "\(name ?? "") \(lastName ?? "")"
        cell.lblName.text = fullName
        cell.containerView.layer.cornerRadius = 6
        cell.separatorInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        if arrayPersons[indexPath.row].is_super_admin == true {
            let userID = UserDefaults.standard.integer(forKey: "id")
            if arrayPersons[indexPath.row].id == userID {
                cell.lblAdmin.isHidden = true
                cell.starImage.isHidden = true
                cell.lblName.isHidden = true
                cell.containerView.backgroundColor = .clear
                showAlert(titleAlert: "Aviso", message: "Al momento no hay personas colaboradores en tu comunidad")
                
            }else{
                cell.lblAdmin.isHidden = false
                cell.starImage.isHidden = false
            }
            
        }else if arrayPersons[indexPath.row].is_admin == true {
            let userID = UserDefaults.standard.integer(forKey: "id")
            if arrayPersons[indexPath.row].id == userID {
                cell.lblAdmin.isHidden = true
                cell.starImage.isHidden = false
                cell.lblName.isHidden = true
                cell.containerView.backgroundColor = .clear
                showAlert(titleAlert: "Aviso", message: "Al momento no hay personas colaboradores en tu comunidad")
            }else{
                cell.lblAdmin.isHidden = false
                cell.starImage.isHidden = true
            }
            
        }else{
            cell.lblAdmin.isHidden = true
            cell.starImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: "") { [weak self] (action, view, handler) in
            self?.handleMoveToTrash()
            handler(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(named: "iconDelete", in: Bundle.local, compatibleWith: nil)
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        switch bEdit {
        case true:
            return UITableViewCell.EditingStyle.delete
        case false:
            return UITableViewCell.EditingStyle.none
        }
    }
    
    
}

extension AdminListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AdminListCell
        passUserName = cell.lblName.text!
        userId = arrayPersons[indexPath.row].id ?? 1
        isSuperAdmin = arrayPersons[indexPath.row].is_super_admin ?? false
        //presenter?.goToFormullary(id: userId, name: passUserName, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin)
        RouterAdminModules.getController(id: userId, name: passUserName, comesFromList: 1, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: self)
        
    }
    
    private func handleMoveToTrash() {
        print("Moved to trash")
    }
}

extension AdminListView: ProtocolosAdminListView {
    
    func isSuccessData(_ modules: [UserList]) {
        self.arrayPersons = modules
        
        if modules.count != 0 {
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
                loadingAlert.dismiss(animated: true, completion: nil)
            }
            
        }else{
            
            let alert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Al momento no hay personas colaboradores en tu comunidad")
            alert.modalPresentationStyle = .overFullScreen
            alert.transitioningDelegate = self
            DispatchQueue.main.async {
                self.loadingAlert.dismiss(animated: true, completion: nil)
            }
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
                self.present(alert, animated: true, completion: nil)
            }
        
        }
       
    }
    
    func showError(_ error: String) {
        print("Error en el servico: \(error)")
        let alert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Al momento no hay personas colaboradores en tu comunidad")
        alert.modalPresentationStyle = .overFullScreen
        alert.transitioningDelegate = self
        DispatchQueue.main.async {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.3) {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}

extension AdminListView: UISearchBarDelegate {
    @objc func seachEvent(){
        if (srcSearchBar.text?.isEmpty ?? true) == false{
            self.presenter?.searchBarPerson(id: locationId, name: srcSearchBar.text ?? "")
        }else{
            presenter?.getData(id: locationId)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.seachEvent), object: nil)
        self.perform(#selector(self.seachEvent), with: nil, afterDelay: 0.5)
    }
}

extension AdminListView: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = false
        
        self.navigationController?.popViewController(animated: true)
            
            
        return transition
        
    }
    
}


