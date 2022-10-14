//
//  FirstMan_View.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 01/05/21.
//

import UIKit


class FirstMan_View: UITabBarController, UITabBarControllerDelegate {
    
    var searchField : UITextField?
    var _presenter: SSVIPER_ViewToPresenterProtocol?
    
    lazy var safeArea = { () -> UILayoutGuide in
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide
        }else{
            return self.view.layoutMarginsGuide
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        searchField = UITextField(frame: CGRect.zero)
        guard let searchField = searchField else { debugPrint("Can't create searchField"); return }
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.layer.cornerRadius = 20
        searchField.layer.masksToBounds = true
        searchField.layer.borderWidth = 2
        searchField.layer.borderColor = UIColor.black.cgColor
        searchField.rightViewMode = UITextField.ViewMode.always
        
        let view1 = NavigationGeneric()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.delegate = self
        
        self.view.addSubview(view1)
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -50),
            view1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            view1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            view1.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        let height = navigationController?.navigationBar.frame.maxY
        tabBar.frame = CGRect(x: 0, y: (height ?? 0) + 79.2, width: tabBar.frame.size.width, height: tabBar.frame.size.height)
        self.tabBar.unselectedItemTintColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        self.tabBar.tintColor = UIColor(red: 28.0 / 255.0, green: 117.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
        super.viewDidLayoutSubviews()
    }
    
}

extension FirstMan_View: NavigationDelegationAction{
    func getAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension FirstMan_View: SSVIPER_PresenterToViewProtocol{
    func setDataCatalog(data: FF_CatalogObj_Entity) {
        print("Imprimio en First: \(data)")
    }
    
    
    func errorCloseSesion(code: Int?, msg: String?) {
//        print("Regreso la data errorCloseSesion")
    }
    
    func successcloseSesion(data: String?, msg: String?) {
//        print("Regreso la data successcloseSesion")
    }
    
    func setData(data: FF_FormationObj_Entity){
//        print("Regreso la data")
    }
    
    func setDataChild(data: [FF_Formation_Entity]) {
//        print("Regreso la data")
    }
    
}


