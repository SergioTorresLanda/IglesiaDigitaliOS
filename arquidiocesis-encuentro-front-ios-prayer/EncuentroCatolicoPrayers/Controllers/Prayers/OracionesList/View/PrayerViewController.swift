//
//  PrayerViewController.swift
//  EncuentroCatolicoPrayers
//
//  Created by Miguel Eduardo  Valdez Tellez  on 26/04/21.
//

import UIKit
import AlamofireImage

class PrayerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
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
    var presenter: PresenterOracionesProtocol?
    
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 112, width: self.view.frame.width-16, height: self.view.frame.height-22))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "¿Qué oración buscas?"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true
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
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        self.view.addSubview(self.searchBarF)
        self.presenter?.getDataInteractor(name: "")
        self.prayerTable.delegate = self
        self.prayerTable.delegate = self
        self.prayerCollection.delegate = self
        self.prayerCollection.dataSource = self
        self.searchBarF.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        setImage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECPrayers -OracionesList- PrayerVC ")

    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        } else {
            // Fallback on earlier versions
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
    
}

extension PrayerViewController: ViewOracionesProtocol {
    func showError(message: String) {
        self.showAlert(withTitle: "Error", withMessage: message)
        self.presenter?.getDataInteractor(name: "")
    }
    
    func isSuccess(data: [DataResponse]) {
        self.dataSource = data
        self.isScuccesData(data: data)
    }
}

extension PrayerViewController: DelegateCellViewCollectionPrayers {
    func tapDetail(id: Int) {
        let detail = OracionesDetailRouter.getDetailView(id: id)
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension PrayerViewController: UISearchBarDelegate {
    
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



