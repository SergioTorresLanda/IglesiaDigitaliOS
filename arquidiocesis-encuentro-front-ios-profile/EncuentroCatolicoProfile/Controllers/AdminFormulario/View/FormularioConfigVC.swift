//
//  FormularioConfig.swift
//  ConfigAdmin
//
//  Created by Miguel Eduardo  Valdez Tellez  on 06/05/21.
//

import UIKit

class FormularioConfig: UIViewController {
    var name = String()
    var userId = Int()
    var locationId = Int()
    var isAdmin = Bool()
    var isSuperAdmin = Bool()
    var presenter: ProtocolosAdminFormularioPresenter?
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    static let instance = FormularioConfig()
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rolLabel: UILabel!
    @IBOutlet weak var lifeStateLabel: UILabel!
    @IBOutlet weak var editLabel: UILabel!
    @IBOutlet weak var churchLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var moduleCollection: UICollectionView!
    @IBOutlet weak var serviceCollection: UICollectionView!
    @IBAction func editButton(_ sender: Any) {
        presenter?.goToModules(id: userId, name: name, comesFromList: 1, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin)
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    var servicesData: [String] = ["Catequista","Pastoral","Sacristán","Diácono"]
    var moduleData: Modules?
    static let reuseIdentifier = "FormularioConfig"
    static let nib = UINib(nibName: FormularioConfig.reuseIdentifier, bundle: Bundle.local)
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter?.getData(id: userId, locationId: locationId)
//        setNavigationBar()
        serviceCollection.delegate = self
        serviceCollection.dataSource = self
        serviceCollection.register(UINib(nibName: "GenericCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "GenericCollectionViewCell")
        moduleCollection.delegate = self
        moduleCollection.dataSource = self
        moduleCollection.register(UINib(nibName: "GenericCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "GenericCollectionViewCell")
        if isSuperAdmin == true {
            starImageView.isHidden = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getData(id: userId, locationId: locationId)
//        moduleCollection.reloadData()
//        serviceCollection.reloadData()
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - FormularioConfig ")

        presenter?.getData(id: userId, locationId: locationId)
    }
    func setNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Nombrar Administradores")
        let img = UIImage(named: "navbar_image",in: Bundle.local,compatibleWith: nil)
        navBar.setBackgroundImage(img, for: .default)
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0)]
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBar.titleTextAttributes = textAttributes
        var image = UIImage(named:  "atrasIzq",in: Bundle.local,compatibleWith: nil)
        image = image?.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
        leftBarButtonItem.tintColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
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
    
    @objc func addTapped() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func returnTo(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension FormularioConfig: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == serviceCollection {
            return moduleData?.services?.count ?? 1
        } else {
            let filtered = moduleData?.modules?.filter({$0.enabled == true})
            return filtered?.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == serviceCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenericCollectionViewCell", for: indexPath) as! GenericCollectionViewCell
            cell.genericLabel.text = moduleData?.services?[indexPath.row].name
            cell.genericView.layer.cornerRadius = 6
            cell.genericView.layer.borderWidth = 1
            cell.genericView.layer.borderColor = UIColor(red:174/255, green:174/255, blue:174/255, alpha: 1).cgColor
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenericCollectionViewCell", for: indexPath) as! GenericCollectionViewCell
            let filtered = moduleData?.modules?.filter({$0.enabled == true})
           
            cell.genericLabel.text = filtered?[indexPath.row].name
            cell.genericLabel.sizeToFit()
            cell.genericView.layer.cornerRadius = 6
            cell.genericView.layer.borderWidth = 1
            cell.genericView.layer.borderColor = UIColor(red:174/255, green:174/255, blue:174/255, alpha: 1).cgColor
            return cell
        }
    }
}

extension FormularioConfig: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 50
        let width: CGFloat = 145
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension FormularioConfig: ProtocolosAdminFormularioView {
    func isSuccessData(_ modules: Modules) {
        self.moduleData = modules
        DispatchQueue.main.async { [self] in
            moduleCollection.reloadData()
            serviceCollection.reloadData()
            nameLabel.text = name
            nameLabel.adjustsFontSizeToFitWidth = true
            lifeStateLabel.text = moduleData?.life_status
            lifeStateLabel.adjustsFontSizeToFitWidth = true
          //  churchLabel.text = moduleData?.location
            churchLabel.adjustsFontSizeToFitWidth = true
            emailLabel.text = moduleData?.email
            emailLabel.adjustsFontSizeToFitWidth = true
            loadingAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    func showError(_ error: String) {
        
    }
    
    
}
