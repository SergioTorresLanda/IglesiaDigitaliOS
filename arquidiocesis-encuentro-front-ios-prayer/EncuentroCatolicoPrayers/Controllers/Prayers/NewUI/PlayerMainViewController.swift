//
//  PlayerMainViewController.swift
//  EncuentroCatolicoPrayers
//
//  Created by Miguel Eduardo  Valdez Tellez  on 26/04/21.
//

import UIKit

class PlayerMainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    var dataSourceCollectionView:[String] = []
    var dataSourcePrayerView:[String] = []
    var dataSourceTableView:[String] = []
    var imagenesPrayers: [UIImage] = []
    var dataSource: [DataResponse]?
    let dataSourceImageView = ["A Jesucristo", "A la Santísima Trinidad", "A la Virgen María", "Al ángel de la guarda", "Al Padre", "Bendición de los alimentos", "De arrepentimiento", "De los Santos"]
    
    @IBOutlet weak var prayerCollection: UICollectionView!
    @IBOutlet weak var subPrayerCollection: UICollectionView!
    
    var presenter: PresenterOracionesProtocol?
    
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 120, width: self.view.frame.width-16, height: self.view.frame.height-22))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "¿Qué oración buscas?"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        //searchBar.showsCancelButton = true
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
        self.view.addSubview(self.searchBarF)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
     func getSubtitles(topic: String) -> [String] {
       let devotion = self.dataSource?.first{$0.name == topic}
    
        
        let results =  devotion?.devotions.map({$0.map{$0.name ?? ""}})
        
       return results ?? []
        
    }
    private func isScuccesData(data: [DataResponse]) {
        
       
        let oracionesTitulo = data.map({$0.name ?? ""})
        self.dataSourceTableView = oracionesTitulo
        
//        let imagenes = data.map({($0.iconUrl ?? "https://img.icons8.com/ios-filled/72/christian-prayer.png")})
//        for i in imagenes {
//
//            let img: UIImage = UIImage().downloadImage(url: i) ?? UIImage()
//
//            self.imagenesPrayers.append(img)
//        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == prayerCollection {
            return dataSourceCollectionView.count
        } else {
            return dataSourceCollectionView.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == prayerCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PrayerCollectionCell
           
            let tituloToSeacrh = self.dataSource?.last?.name ?? "A Jesucristo"
            let subtitles = getSubtitles(topic: tituloToSeacrh)
            self.dataSourceCollectionView = subtitles
            
            cell.prayerCollectionText.text = dataSourceCollectionView[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCell", for: indexPath) as! NamePrayerCollectionCell
            
            let tituloToSeacrh = self.dataSource?[indexPath.row].name ?? "A Jesucristo"
            let subtitles = getSubtitles(topic: tituloToSeacrh)
            self.dataSourcePrayerView = subtitles
            cell.subPrayerText.text = dataSourcePrayerView[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == prayerCollection {
            print("Prayer")
            let id = self.dataSource?[indexPath.row].id ?? 0
           OracionesDetailRouter.getDetailView(fromView: self, id: id)
            //self.navigationController?.pushViewController(detail, animated: true)
            
        } else {
            print("Prayer 2")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "PrayerCell", for: indexPath) as! PrayerTableViewCell
        
      
        cellTable.namePrayer.text = self.dataSourceTableView[indexPath.row]
        cellTable.imagePrayer.image = UIImage(named: dataSourceImageView[indexPath.row])
        return cellTable
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension PlayerMainViewController: ViewOracionesProtocol {

    func showError(message: String) {
        LoaderView.shared.hide()
        self.showAlert(withTitle: "Error", withMessage: message)
        self.presenter?.getDataInteractor(name: "")
    }
    
    func isSuccess(data: [DataResponse]) {
        LoaderView.shared.hide()
        self.dataSource = data
        self.isScuccesData(data: data)
        
    }
}

extension PlayerMainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if textSearched.count > 3 {
            print("Search...")
        }
       
    }
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
}


