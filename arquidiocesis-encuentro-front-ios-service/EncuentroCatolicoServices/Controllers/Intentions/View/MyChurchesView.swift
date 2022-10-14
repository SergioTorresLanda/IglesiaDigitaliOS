//
//  MyChurchesView.swift
//  santander-kids
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MyChurchesViewController: BaseViewController {
    
    var presenter: MyChurchesPresenterProtocol?
    
    //MARK: - IBOutlets
    ///Main church
    //    @IBOutlet weak var mainChurchImage: UIImageView!
    //    @IBOutlet weak var mainChurchName: UILabel!
    //    @IBOutlet weak var mainChurchButton: UIButton!
    ///Favourites
    @IBOutlet weak var otherChurchesCollectionView: UICollectionView!
    //@IBOutlet weak var fabAddChurchButton: UIButton!
    
    @IBOutlet weak var btnReturn: UIButton!
    
    
    //    @IBOutlet weak var lblTitle: UILabel!
    //
    //    @IBOutlet weak var lblChurchFavorite: UILabel!
    let isPrayer = UserDefaults.standard.bool(forKey: "isPriest")
    let defaultImage = "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg"
    var priestChurches: PriestChurches?
    var currentUser: Int?
    var locations: [Assigned] = []
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 108, width: self.view.frame.width-20, height: self.view.frame.height-20))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Busca una iglesia"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        let imageView = UIImageView(image: UIImage(named: "Icono_buscar"))
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
    
    @objc func mainChurchDetail() {
        if let id = priestChurches?.assigned?.id {
            self.currentUser = id
            goToChurch(with: self.currentUser ?? 1)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        self.addSearchBar()
        hideKeyboardWhenTappedAround()
        //setRole()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let idPriest =  UserDefaults.standard.integer(forKey: "id")
        print(idPriest)
        self.currentUser = 1
        presenter?.getChurches(with: self.currentUser ?? 0)
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
    }
    
    func hideLoading() {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - View controls
    private func initView() {
        showLoading()
        otherChurchesCollectionView.register(FavouriteChurchCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: FavouriteChurchCollectionViewCell.reuseIdentifier)
        otherChurchesCollectionView.register(MyChurchCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: MyChurchCollectionViewCell.reuseIdentifier)
        otherChurchesCollectionView.register(MyChurchHeaderCollectionViewCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyChurchHeaderCollectionViewCell.reuseIdentifier)
        otherChurchesCollectionView.register(FavouriteChurchHeaderCollectionViewCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavouriteChurchHeaderCollectionViewCell.reuseIdentifier)
        
        otherChurchesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 140, right: 0)
        otherChurchesCollectionView.delegate = self
        otherChurchesCollectionView.dataSource = self
    }
    
    private func addSearchBar() {
        self.view.addSubview(self.searchBarF)
    }
    
    private func hidEelements() {
        self.otherChurchesCollectionView.isHidden = true
        //        self.mainChurchImage.isHidden = true
        //        self.mainChurchName.isHidden = true
        //        self.mainChurchButton.isHidden = true
        //        self.otherChurchesCollectionView.isHidden = true
        //        // self.fabAddChurchButton.isHidden = true
        //        self.btnReturn.isHidden = true
        //        // self.lblTitle.isHidden = true
        //        // self.lblChurchFavorite.isHidden = true
    }
    
    private func goToChurch(with id: Int) {
        print(id)
        presenter?.goToChurchDetail(id: id)
    }
    
    
    fileprivate func reloadContent() {
        
        otherChurchesCollectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func dismissView(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - Collection view delegates
extension MyChurchesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if(indexPath.section == 0){
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyChurchHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! MyChurchHeaderCollectionViewCell
                switch isPrayer {
                case true:
                    headerView.titleSection.text = "Adscrito a"
                    headerView.changeChurch.isHidden = false
                case false:
                    headerView.changeChurch.isHidden = true
                    headerView.titleSection.text = "Mi Iglesia principal"
                }
                return headerView
            }else{
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavouriteChurchHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! FavouriteChurchHeaderCollectionViewCell
                headerView.addChurchView.isHidden = !isPrayer
                return headerView
            }
        default:
            assert(false, "Unexpected element kind")
        }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyChurchHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! MyChurchHeaderCollectionViewCell
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0){
            return 1
        }else{
            return self.locations.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(indexPath.section == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  MyChurchCollectionViewCell.reuseIdentifier, for: indexPath) as? MyChurchCollectionViewCell
            
            var url = priestChurches?.assigned?.imageUrl ?? "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg"
            if url == "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"{
                url = "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg"
            }
            let data = try? Data(contentsOf: (URL(string: url) ?? URL(string: defaultImage))!)
            UserDefaults.standard.setValue(url, forKey: "imgNext")
            cell?.imageChurch.image = UIImage(data: data!)
           // cell?.imageChurch.downloaded(from: url)
            cell?.titleChurch.text = priestChurches?.assigned?.name
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteChurchCollectionViewCell.reuseIdentifier, for: indexPath)
            (cell as? FavouriteChurchCollectionViewCell)?.fill(with: (self.locations[safe: indexPath.row])!)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            let height: CGFloat = 150
            let width: CGFloat = UIScreen.main.bounds.width
            let size = CGSize(width: width, height: height)
            return size
        }else{
            let height: CGFloat = 200
            let width: CGFloat = (UIScreen.main.bounds.width / 2 ) - 5
            let size = CGSize(width: width, height: height)
            
            return size
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            mainChurchDetail()
        }else{
            if let id = self.locations[safe: indexPath.item]?.id {
                goToChurch(with: id)
            }
        }
    }
    
}

extension MyChurchesViewController: MyChurchesViewProtocol {
    func showSearchBarResponse(result: [Assigned]) {
        LoaderView.shared.hide()
        self.locations.removeAll()
        for _assigned in result {
            if _assigned.imageUrl?.isEmpty == false {
                if _assigned.imageUrl != "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png" ||  _assigned.imageUrl != "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"{
                    self.locations.append(_assigned)
                }
            }
        }
        //self.locations = result
        DispatchQueue.main.async {
            [weak self] in
            self?.otherChurchesCollectionView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            LoaderView.shared.hide()
            self.showMessage(error)
        }
        
    }
    
    func showChurches(_ churches: PriestChurches) {
        self.priestChurches = churches
        self.locations.removeAll()
        if let locations = churches.locations{
            for _assigned in locations{
                if _assigned.imageUrl?.isEmpty == false {
                    if _assigned.imageUrl != "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png" &&  _assigned.imageUrl != "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"{
                        
                        self.locations.append(_assigned)
                    }
                }
            }
        }
        //self.locations = churches.locations ?? []
        
        DispatchQueue.main.async {
            [weak self] in
            self?.reloadContent()
        }
    }
    
}

extension MyChurchesViewController: UISearchBarDelegate {
    
    @objc func seachEvent(){
        if (searchBarF.text?.isEmpty ?? true) == false{
            LoaderView.shared.show()
            self.presenter?.searchBarChurch(name: searchBarF.text ?? "")
        }else{
            LoaderView.shared.show()
            presenter?.getChurches(with: self.currentUser ?? 0)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if textSearched.count > 0 {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.seachEvent), object: nil)
            self.perform(#selector(self.seachEvent), with: nil, afterDelay: 0.2)
        }else if textSearched.count == 0 {
            self.presenter?.getChurches(with: currentUser ?? 1)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.presenter?.getChurches(with: currentUser ?? 1)
        self.view.endEditing(true)
    }
}

