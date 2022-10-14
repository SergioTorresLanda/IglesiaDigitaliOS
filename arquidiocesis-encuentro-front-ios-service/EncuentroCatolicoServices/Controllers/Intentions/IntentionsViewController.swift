
//
//  IntentionsViewController.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 27/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import AlamofireImage
class IntentionsViewController: UIViewController {
    
    @IBOutlet weak var imgView           : UIImageView!
    @IBOutlet weak var lblChurch         : UILabel!
    @IBOutlet weak var collection        : UICollectionView!
    @IBOutlet weak var featuredChurchView: UIView!
    
    var presenter: IntentionsPresenterProtocol?
    var priestChurches: PriestChurches?
    let viewBundle = Bundle.init(identifier: "mx.arquidiocesis.EncuentroCatolicoServices")
    let defaultImage = "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg"
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var comesFormSearch = Bool()
    
    lazy var tableSearchBar: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 650))
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        return table
    }()
    
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 110, width: self.view.frame.width, height: self.view.frame.height))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Busca iglesia"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        let imageView = UIImageView(image: UIImage(named: "Icono_buscar", in: viewBundle, compatibleWith: nil))
        
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.rightView = imageView
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.rightViewMode = UITextField.ViewMode.always
        } else {
            // Fallback on earlier versions
        }
        
        return searchBar
    }()
    
    var locations = [Assigned]()
    var assigned = [Assigned]()
    var demo = [Assigned]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "FavoriteChurchCells", bundle: viewBundle), forCellWithReuseIdentifier: "cell")
        setNavAndSearch()
        searchBarF.setImage(UIImage(), for: .clear, state: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        featuredChurchView.layer.masksToBounds = false
        featuredChurchView.layer.shadowColor = UIColor.black.cgColor
        featuredChurchView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        featuredChurchView.layer.shadowOpacity = 0.1
        featuredChurchView.layer.shadowRadius = 5
        featuredChurchView.layer.cornerRadius = 10
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
        presenter?.requestlocations()
    }
    
    private func setNavAndSearch() {
        self.view.addSubview(self.searchBarF)
        //  self.tableSearchBar.register(UITableViewCell.self, forCellReuseIdentifier: cellTable)
    }
    
    private func isSuccesSearch() {
        self.tableSearchBar.reloadData()
        self.tableSearchBar.isHidden = false
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: viewBundle, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func hideLoading() {
        self.alert.dismiss(animated: false, completion: nil)
    }
    
    fileprivate func reloadContent() {
        
        collection.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.hideLoading()
        })
    }
    
    @IBAction func btnSendToView(_ sender: Any) {
        guard let location = assigned.first else {
            return
        }
        let view = ScheduleMassRouter.createModule(location: location)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
}

extension IntentionsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavoriteChurchCells
        let url = locations[indexPath.row].image_url ?? ""
        cell.lblTitle.text = locations[indexPath.row].name
        if let imageUrl = URL(string: url) {
            cell.imgView.af.setImage(withURL: imageUrl)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        let view = ScheduleMassRouter.createModule(location: location)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 161.0, height: 158.0)
    }
}

extension IntentionsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Resultado"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.searchBarF.text = self.dataSourceSearch[indexPath.row].name
        //               let id = self.dataSourceSearch[indexPath.row].id
        //               let view = LibraryAndResourcesRouter.createModule(contentID: id)
        //               self.navigationController?.pushViewController(view, animated: true)
    }
}

extension IntentionsViewController: UISearchBarDelegate {
    
    @objc func seachEvent(){
        if (searchBarF.text?.isEmpty ?? true) == false {
            //            self.showLoading()
            self.presenter?.searchBarIntentionsChurch(name: searchBarF.text ?? "")
        }else{
            //            self.showLoading()
            self.presenter?.requestlocations()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.seachEvent), object: nil)
        self.perform(#selector(self.seachEvent), with: nil, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.presenter?.requestlocations()
        self.hideLoading()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //  self.presenter?.getDataInteractorSearchBar(type: searchBar.text!)
        self.view.endEditing(true)
    }
}

extension IntentionsViewController: IntentionsViewProtocol {
    
    func showSearchBarResponse(result: [Assigned]) {
        self.locations = result
        DispatchQueue.main.async { [self] in
            collection.reloadData()
            hideLoading()
        }
    }
    
    
    func loadOptions(data: PriestChurches) {
        DispatchQueue.main.async { [self] in
            if data.assigned != nil {
                guard let assigned = data.assigned else {return}
                lblChurch.text = assigned.name
                
                if let url = URL(string: assigned.image_url ?? "") {
                    imgView.af.setImage(withURL: url)
                }
                self.assigned.append(assigned)
            }else if data.locations != nil {
            }
            guard let locations = data.locations else {
                return
            }
            self.locations = locations
            collection.reloadData()
            hideLoading()
            //            func mostrarMSG(dtcAlerta: [String : String]) {
            //                alert.dismiss(animated: false, completion: {
            //                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            //                        self.alert.dismiss(animated: true, completion: nil)
            //                    })
            //                    let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
            //                    alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            //                    self.present(alerta, animated: true, completion: nil)
            //                })
            //            }
        }
    }
}
