//
//  PrayerViewController.swift
//  EncuentroCatolicoPrayers
//
//  Created by Miguel Eduardo  Valdez Tellez  on 26/04/21.
//

import UIKit
import AlamofireImage

class Home_Oraciones: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    var dataSourceCollectionView: [String] = []
    var collectionID: [Int?] = []
    var dataSourceIntCollectionView: [Int] = []
    var dataSourcePrayerView = ["El Padre Nuestro", "Devoción al Sagrado Corazón", "El Angel De la Guarda", "Gloaria", "El Salve", "Oración ante el crucifijo"]
    var dataSourceTableView: [String] = []
    var imagenesPrayers: [UIImage] = []
    var dataSource: [DataResponse]?
    var dataSourceImageView: [UIImage] = []
    
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    @IBAction func dissButtonAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var dissButton: UIButton!
    var indexTable: Int = 0
    @IBOutlet weak var prayerCollection: UICollectionView!
    @IBOutlet weak var prayerTable: UITableView!
    @IBOutlet weak var navView: UIView!

    @IBOutlet weak var buscarTF: UITextField!
    
    @IBAction func buscarEnd(_ sender: Any) {
        
    }
    
    @IBAction func buscarBegin(_ sender: Any) {
    }
    
    @IBAction func buscarChanged(_ sender: Any) {
        print("DID CHAnGE serchh")
        if buscarTF.text!.count > 1 {
            self.presenter?.getDataInteractorSearchBar(type: buscarTF.text!)
        }else if buscarTF.text!.count == 0{
            self.presenter?.getDataInteractor(name: "")
        }
    }
    
    
    var presenter: PresenterOracionesProtocol?
   
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 112, width: self.view.frame.width-16, height: self.view.frame.height-22))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "¿Qué oración buscas?"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = .clear
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        let imageView = UIImageView(image: UIImage(named: "iconoBuscar"))
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.leftView = imageView
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.leftViewMode = UITextField.ViewMode.always
        } else {
            // Fallback on earlier versions
        }
        let img = UIImage(named: "iconSearch", in: Bundle(for: Home_Oraciones.self), compatibleWith: nil)
        searchBar.setImage(img, for: .search, state: .normal)
        //setPaddingWithImage(image: img ?? UIImage(), textField: searchBar)
        return searchBar
    }()
    
    func setPaddingWithImage(image: UIImage, textField: UITextField){
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let viewR = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.frame = CGRect(x: 12.0, y: 12.0, width: 25.0, height: 25.0)//13 x y  y
        let seperatorView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        seperatorView.backgroundColor = UIColor.clear
        textField.leftViewMode = .always
        viewR.addSubview(imageView)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = seperatorView
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = viewR
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navView.layer.cornerRadius = 20
        navView.ShadowNavBar()
        showLoading()
        //self.view.addSubview(self.searchBarF)
        presenter?.getDataInteractor(name: "")
        prayerTable.delegate = self
        prayerTable.delegate = self
        prayerCollection.delegate = self
        prayerCollection.dataSource = self
        buscarTF.delegate=self
        searchBarF.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        setImage()
        hideKeyboardWhenTappedAround()
        addDoneButtonOnKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECPrayers -OracionesList- PrayerVC ")
        let img = UIImage(named: "iconSearch", in: Bundle(for: Home_Oraciones.self), compatibleWith: nil)
        setPaddingWithImage(image: img ?? UIImage(), textField: buscarTF)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.hideLoading()
        }
    }
    
    func getSubtitles(topic: String) -> [String] {
        let devotion = self.dataSource?.first{$0.name == topic}
        let results =  devotion?.devotions.map({$0.map{$0.name ?? ""}})
        return results ?? []
        
    }
    
    func getSubtituleID(id: Int) -> [Int] {
        let devotion = self.dataSource?.first{$0.id == id}
        let results =  devotion?.devotions.map({$0.map{$0.id ?? 0}})
        return results ?? []
    }
    
    func getDevotions(topic: String) -> [Devotion] {
        let devotion = self.dataSource?.first{$0.name == topic}
        let results =  devotion?.devotions
        return results ?? []
        
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        }
        loadingAlert.view.addSubview(imageView)
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    func hideLoading(){
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    private func setImage() {
        if #available(iOS 13.0, *) {
            dataSourceImageView = [UIImage(named:  "A_Jesucristo",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "A_la_Santísima_Trinidad",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "A_la_Virgen_María",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "Al_ángel_de_la_guarda",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "Al_Padre",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "Bendición_de_los_alimentos",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "De_arrepentimiento",in: Bundle.local,compatibleWith: nil)!,
                                   UIImage(named:  "De_los_Santos",in: Bundle.local,compatibleWith: nil)!]
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func isScuccesData(data: [DataResponse]) {
        var arrayTotal: [String] = []
        var arrayTotalId: [Int] = []
        let oracionesTitulo = data.map({$0.name ?? ""})
        let oracionesId = data.map{($0.id)}
        self.collectionID = oracionesId
        self.dataSourceTableView = oracionesTitulo
        self.prayerTable.reloadData()
        for i in self.dataSourceTableView {
            arrayTotal.append(contentsOf: self.getSubtitles(topic: i))
        }
        for i in self.collectionID {
            arrayTotalId.append(contentsOf: self.getSubtituleID(id: i ?? 0))
        }
        self.dataSourceCollectionView = arrayTotal
        self.dataSourceIntCollectionView = arrayTotalId
        self.prayerCollection.reloadData()
        hideLoading()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == prayerCollection {
            return dataSourceCollectionView.count
        } else {
            return dataSourcePrayerView.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PrayerCollectionCell
        cell.prayerCollectionText.text = dataSourceCollectionView[indexPath.row]
        cell.prayerCollectionText.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == prayerCollection {
            let id = self.dataSourceIntCollectionView[indexPath.row]
            let view = OracionesDetailRouter.getDetailView(id: id)
            self.navigationController?.pushViewController(view, animated: true)
        } else {
            let id = self.collectionID[indexPath.row] ?? 0
            print(OracionesDetailRouter.getDetailView(id: id))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "PrayerCell", for: indexPath) as! PrayerTableViewCell
        
        self.indexTable = indexPath.row
        //fill Colelction
        
        let title =  self.dataSourceTableView[indexPath.row]
        self.dataSourcePrayerView = self.getSubtitles(topic: title)
        let id = self.dataSource?[indexPath.row].id ?? 0
        print(id)
        cellTable.configure(data: self.getDevotions(topic: title))
        cellTable.delegateCollectionPrayer = self
        //ffff
        let url = URL(string: dataSource?[indexPath.row].icon_url ?? "")!
        cellTable.imagePrayer.af.setImage(withURL: url)
        cellTable.subPrayerCollection.reloadData()
        return cellTable
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    //MARK: KEYBOARD
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
             doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        buscarTF.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        buscarTF.resignFirstResponder()
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension Home_Oraciones: ViewOracionesProtocol {
    func showError(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showAlert(withTitle: "Error", withMessage: message)
            self.presenter?.getDataInteractor(name: "")
        }
    }
    
    func isSuccess(data: [DataResponse]) {
        print("SUCcess oraciones")
        dataSource = data
        isScuccesData(data: data)
    }
}

extension Home_Oraciones: DelegateCellViewCollectionPrayers {
    func tapDetail(id: Int) {
        let detail = OracionesDetailRouter.getDetailView(id: id)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension Home_Oraciones: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if textSearched.count > 1 {
            self.presenter?.getDataInteractorSearchBar(type: textSearched)
        }else if textSearched.count == 0{
            self.presenter?.getDataInteractor(name: "")
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.presenter?.getDataInteractor(name: "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  self.presenter?.getDataInteractorSearchBar(type: searchBar.text!)
        self.view.endEditing(true)
    }
}



