//
//  MainConfigView.swift
//  EncuentroCatolicoProfile
//
//  Created by Miguel Eduardo  Valdez Tellez  on 05/05/21.
//

import UIKit

class MainConfigView: UIViewController {
    
    var presenter: ProtocolosAdminPresenter?
    let isPrayer = UserDefaults.standard.bool(forKey: "isPriest")
    let userId = UserDefaults.standard.integer(forKey: "locationId")
    let locationComponentId = UserDefaults.standard.integer(forKey: "locationModule")
    let userRole = UserDefaults.standard.string(forKey: "profile")
    let CommunityId = UserDefaults.standard.integer(forKey: "CommunityId")
    let email = UserDefaults.standard.string(forKey: "email")
    let phone = UserDefaults.standard.string(forKey: "phone2")
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    @IBOutlet weak var sosView: UIView!
    @IBOutlet weak var collectionExit: UIView!
    @IBOutlet weak var collectionButton: UICollectionView!
    @IBOutlet weak var viewUbication: UIView!
    @IBOutlet weak var sosSwitch: UISwitch!
    @IBOutlet weak var ubicationLabel: UILabel!
    @IBOutlet weak var btnDeleteUser: UIButton!
    var presentertoLogOut: ProfileInfoPresenterProtocol?
    var response: AssignedChurches?
    var loactionID = Int()
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let buttonAttributes: [NSAttributedString.Key: Any] = [
          .font: UIFont.systemFont(ofSize: 16),
          .foregroundColor: UIColor.eMainBlue,
          .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
    @IBAction func sosSwichAction(_ sender: Any) {
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func closeSesionButton(_ sender: Any) {
        logOut()
       
    }
    @IBAction func readyButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    let dataCollection = ["Nombrar Administradores"]
    static let reuseIdentifier = "MainConfigView"
    static let nib = UINib(nibName: MainConfigView.reuseIdentifier, bundle: Bundle.local)
    
    @IBAction func deleteAccount(_ sender: Any) {
        let alert = UIAlertController(title: "Aviso", message: "Al eliminar tu cuenta, se borrará tu usuario y no tendrás mas acceso a la la información, servicios, publicaciones realizados desde la misma.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) {
            [weak self] _ in
            guard let self = self else {return}
            self.presenter?.deleteColaboradorData(id: self.userId, email: self.email, phone: self.phone)
            }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
        
    }
        
    override func viewDidLoad() {
//        self.setNavigationBar()
        showLoading()
        let attributeString = NSMutableAttributedString(
                string: "Eliminar cuenta",
                attributes: buttonAttributes
             )
        btnDeleteUser.setAttributedTitle(attributeString, for: .normal)
        collectionButton.delegate = self
        collectionButton.dataSource = self
        collectionButton.register(UINib(nibName: "ButtonCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "ButtonCollectionViewCell")
        viewUbication.layer.cornerRadius = 6
        sosView.layer.cornerRadius = 6
        collectionExit.layer.cornerRadius = 6
        
        loadUserAttributs()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getData(id: userId)
    }
    override func viewDidAppear(_ animated: Bool) {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    @objc func addTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func validateChurchAndCommunity() {
        switch userRole {
        case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue:
            presenter?.goToAdmin(locationId: locationComponentId)
        case UserProfileEnum.fieladministrador.rawValue, UserProfileEnum.Sacerdotedecano.rawValue, UserProfileEnum.Sacerdoteadministrador.rawValue:
            presenter?.goToAdmin(locationId: locationComponentId)
        default:
            presenter?.goToAdmin(locationId: userId)
        }
    }
    
    func loadUserAttributs() {
        switch userRole {
        case UserProfileEnum.fiel.rawValue:
            collectionButton.isHidden = true
        case UserProfileEnum.fieladministrador.rawValue:
            if ((locationcomponents?.contains{ $0 == "APPOINT_ADMINISTRATOR"}) == true){
                collectionButton.isHidden = false
            }else{
                collectionButton.isHidden = true
            }
            
        case UserProfileEnum.sacerdote.rawValue:
            collectionButton.isHidden = true
        case UserProfileEnum.Sacerdoteadministrador.rawValue:
            collectionButton.isHidden = false
        case UserProfileEnum.Sacerdotedecano.rawValue:
            collectionButton.isHidden = false
        case UserProfileEnum.AdministradorComunidad.rawValue:
            if ((locationcomponents?.contains{ $0 == "APPOINT_ADMINISTRATOR"}) == true){
                collectionButton.isHidden = false
            }else{
                collectionButton.isHidden = true
            }
        case UserProfileEnum.MiembroComunidad.rawValue:
            collectionButton.isHidden = true
        case UserProfileEnum.ResponsableComunidad.rawValue:
            collectionButton.isHidden = false
        default:
           break
        }
    }
    func setNavigationBar() {
        let navBar = NavigationBar(frame: CGRect(origin: CGPoint(x: 0,
                                                                 y: 0),
                                                 size: CGSize(width: view.frame.width,
                                                              height: 43)
        )
        )
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Administrar módulos")
        navBar.backgroundColor = .eMainBlue
//        let img = UIImage(named: "navbar_image",in: Bundle.local,compatibleWith: nil)
//        navBar.setBackgroundImage(img, for: .default)
        navBar.backgroundColor = .eMainBlue
        
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0)]
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBar.titleTextAttributes = textAttributes
        var image = UIImage(named:  "atrasIzq",in: Bundle.local,compatibleWith: nil)
        image = image?.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
        leftBarButtonItem.tintColor = .white
        navItem.leftBarButtonItem = leftBarButtonItem
        
//        let rightBarButtonItem = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(addTapped))
//        rightBarButtonItem.tintColor = UIColor(red: 190/255, green: 169/255, blue: 120/255, alpha: 1)
//        navItem.rightBarButtonItem = rightBarButtonItem
        
        navBar.setItems([navItem], animated: false)
    }
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    
    private func logOut() {
        UserDefaults.standard.removeObject(forKey: "nombre")
        UserDefaults.standard.removeObject(forKey: "id")
        
        presentertoLogOut?.cerrarSesion()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "newLogOut"),
                                                         object: nil, userInfo: nil))
        })
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "newLogOut"), object: nil)
    }
    
    @IBAction func returnTo(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension MainConfigView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as! ButtonCollectionViewCell
        cell.collectionText.text = dataCollection[indexPath.row]
        cell.shadowDecorate()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.validateChurchAndCommunity()
        case 1:
            break
            //presenter?.goToModules(id: userId, name: "", comesFromList: 2, locationId: loactionID, isAdmin: false, isSuperAdmin: false)
            //UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionButton.bounds.width, height: 48)
    }
}

extension MainConfigView: ProtocolosAdminView {
    
    func isSuccessDataColaboradores(churches: AssignedChurches) {
        self.response = churches
        self.loactionID = response?.assigned?.id ?? 1
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    func isSuccesDelete(result: Bool) {
        DispatchQueue.main.async {
            if result == true {
                let alert = UIAlertController(title: "Aviso", message: "La cuenta fue eliminada con éxito", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel){
                    [weak self] _ in
                    guard let self = self else {return}
                    self.logOut()
                    }
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true)
                
                
            }else {
                
            }
        }
    }
    
    func showError(_ error: String) {
        
    }
    
    
}

extension String {
    func isValidEmailSP() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
