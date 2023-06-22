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
import MapKit
import SkeletonView
import EncuentroCatolicoVirtualLibrary

class Home_MiIglesia: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var otherChurchesCollectionView: UICollectionView!
    @IBOutlet weak var btnReturn: UIButton!
    @IBOutlet weak var customNavBar: UIView!
    

    public typealias SkeletonLayerAnimation = (CALayer) -> CAAnimation
    weak var delegateUtils: UtilsDetailsChurchButtonDelegate!
    var presenter: MyChurchesPresenterProtocol?
    var locationManager = CLLocationManager()
    let cell = MyChurchCollectionViewCell()
    let isPrayer = UserDefaults.standard.bool(forKey: "isPriest")
    let userRole = UserDefaults.standard.string(forKey: "role")
    var utilsChourcid = Int()
    var priestChurches: PriestChurches?
    var currentUser: Int?
    var locations: [Assigned] = []
    var comesFromSearch: Bool = false
    var alertFields : AcceptAlertLogin?
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
    
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 108, width: self.view.frame.width-20, height: self.view.frame.height-20))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Buscar iglesia"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
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
    
    @objc func mainChurchDetail(selector: Int) {
        if let id = priestChurches?.assigned?.id {
            currentUser = id
            goToChurch(with: currentUser ?? 1, selector: selector)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        initView()
        addSearchBar()
        otherChurchesCollectionView.isSkeletonable = true
        //setRole()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
//        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC ECChurch - MyChurches - MyChurchesView ")
        let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if newUser {//esta logueado proceder
            let idPriest =  UserDefaults.standard.integer(forKey: "id")
            print(idPriest)
            currentUser = idPriest
            presenter?.getChurches(with: currentUser ?? 0)
        }
      
    }
    
    //MARK: - View controls,
    private func initView() {
        otherChurchesCollectionView.register(FavouriteChurchCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: FavouriteChurchCollectionViewCell.reuseIdentifier)
        otherChurchesCollectionView.register(MyChurchCollectionViewCell.nib,
                                             forCellWithReuseIdentifier: MyChurchCollectionViewCell.reuseIdentifier)
        otherChurchesCollectionView.register(MyChurchHeaderCollectionViewCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MyChurchHeaderCollectionViewCell.reuseIdentifier)
        otherChurchesCollectionView.register(FavouriteChurchHeaderCollectionViewCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavouriteChurchHeaderCollectionViewCell.reuseIdentifier)
        
        otherChurchesCollectionView.register(UINib(nibName: "EmptyPrincipalChurch", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLEMPTYPRIN")
        
        otherChurchesCollectionView.register(UINib(nibName: "EmptyFavChurch", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLEMPTYFAV")
        
        otherChurchesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 140, right: 0)
        otherChurchesCollectionView.delegate = self
        otherChurchesCollectionView.dataSource = self
        searchBarF.setImage(UIImage(), for: .clear, state: .normal)
        customNavBar.layer.cornerRadius = 20
        customNavBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        customNavBar.ShadowNavBar()
    }
    
    private func addSearchBar() {
        self.view.addSubview(self.searchBarF)
    }
    
    private func hideElements() {
        self.otherChurchesCollectionView.isHidden = true
    }
    
    private func goToChurch(with id: Int, selector: Int) {
        presenter?.goToChurchDetail(id: id, selector: selector)
    }
    
    
    fileprivate func reloadContent() {
        
        otherChurchesCollectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
//            self.hideLoading()
        })
    }
    
    @IBAction func dismissView(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addActionPrin() {
        print("Tap en el btn del collectionview principal")
        if newUser {//esta logueado proceder
            presenter?.goToChourchMap(id: 1, selector: 0)
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para agregar una iglesia principal.")
        }
        
    }
    
    @objc func addActionFav() {
        print("Tap en el btn del collectionview favoritos")
        if newUser {//esta logueado proceder
            presenter?.goToChourchMap(id: 1, selector: 1)
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para agregar una iglesia favorita.")
        }
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    func showCanonAlert(title:String, msg:String){
        alertFields = AcceptAlertLogin.showAlert(titulo: title, mensaje: msg)
        alertFields!.view.backgroundColor = .clear
        self.present(alertFields!, animated: true)
    }
}

//MARK: - Collection view delegates
extension Home_MiIglesia: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AddChourchButtonDelegate, ChangeChourchButtonDelegate {
    func didPressChangeButton(_ tag: Int) {
        if newUser {//esta logueado proceder
            presenter?.goToChourchMap(id: tag, selector: 0)
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para cambiar tu iglesia principal.")
        }
    }
    
    func didPressAddButton(_ tag: Int) {
        if newUser {//esta logueado proceder
            presenter?.goToChourchMap(id: tag, selector: 1)
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para agregar una iglesia favorita.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if(indexPath.section == 0){
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MyChurchHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! MyChurchHeaderCollectionViewCell
                switch priestChurches?.assigned?.name {
                case nil:
                    headerView.changeChurch.isHidden = true
                default:
                    headerView.changeChurch.isHidden = false
                }
                switch userRole {
                case UserRoleEnum.fiel.rawValue:
                    headerView.changeChurch.isHidden = false
                    headerView.titleSection.text = "Mi Iglesia principal"
                    headerView.delegate = self
                    headerView.changeChurch.tag = indexPath.row
                case UserRoleEnum.fieladministrador.rawValue:
                    headerView.changeChurch.isHidden = false
                    headerView.titleSection.text = "Mi Iglesia principal"
                    headerView.delegate = self
                    headerView.changeChurch.tag = indexPath.row
                case UserRoleEnum.sacerdote.rawValue:
                    headerView.titleSection.text = "Adscrito a"
                    headerView.changeChurch.isHidden = true
                    headerView.delegate = self
                    headerView.changeChurch.tag = indexPath.row
                case UserRoleEnum.Sacerdoteadministrador.rawValue:
                    headerView.titleSection.text = "Adscrito a"
                    headerView.changeChurch.isHidden = true
                    headerView.delegate = self
                    headerView.changeChurch.tag = indexPath.row
                case UserRoleEnum.Sacerdotedecano.rawValue:
                    headerView.titleSection.text = "Adscrito a"
                    headerView.changeChurch.isHidden = true
                    headerView.delegate = self
                    headerView.changeChurch.tag = indexPath.row
                default:
                   break
                }
                return headerView
            }else{
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavouriteChurchHeaderCollectionViewCell.reuseIdentifier, for: indexPath) as! FavouriteChurchHeaderCollectionViewCell
                switch priestChurches?.locations?.first?.name {
                case nil:
                    headerView.addChurchView.isHidden = false
                default:
                    headerView.addChurchView.isHidden = false
                }
                headerView.delegate = self
                headerView.addChourcButton.tag = indexPath.row
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
            if locations.count != 0 {
                return self.locations.count
            }else{
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        let gradient = SkeletonGradient(baseColor: UIColor.clouds)
        
        if(indexPath.section == 0) {
            switch priestChurches?.assigned?.name {
            case nil:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLEMPTYPRIN", for: indexPath) as! EmptyPrincipalChurch
                cell.cardView.layer.cornerRadius = 10
                cell.cardView.ShadowCard()
                cell.addButton.addTarget(self, action: #selector(addActionPrin), for: .touchUpInside)
                switch userRole {
                case UserRoleEnum.fiel.rawValue:
                    cell.addButton.alpha = 1
                    cell.iconAdd.alpha = 1
                case UserRoleEnum.sacerdote.rawValue:
                    cell.addButton.alpha = 0
                    cell.iconAdd.alpha = 0
                default:
                    cell.addButton.alpha = 0
                    cell.addButton.alpha = 0
                }
                return cell
                
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  MyChurchCollectionViewCell.reuseIdentifier, for: indexPath) as? MyChurchCollectionViewCell
                cell?.titleChurch.isSkeletonable = true
                cell?.imageChurch.isSkeletonable = true
                cell?.titleChurch.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
                cell?.imageChurch.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
                cell?.titleChurch.showSkeleton(usingColor: .clouds, transition: .crossDissolve(0.25))
                cell?.imageChurch.showSkeleton(usingColor: .clouds, transition: .crossDissolve(0.25))
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
                    cell?.titleChurch.hideSkeleton()
                    cell?.imageChurch.hideSkeleton()
                })
                let url = priestChurches?.assigned?.image_url ?? ""
                UserDefaults.standard.setValue(url, forKey: "imgNext")
                if let imageUrl = URL(string: url) {
                    cell?.imageChurch.af.setImage(withURL: imageUrl)
                }
                cell?.titleChurch.text = priestChurches?.assigned?.name
                return cell!
            }
        }else{
            switch locations.count {
            case 0:
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLEMPTYFAV", for: indexPath) as! EmptyFavChurch
                cell2.cardView.alpha = 1
                cell2.cardView.layer.cornerRadius = 10
                cell2.cardView.ShadowCard()
                cell2.btnAdd.addTarget(self, action: #selector(addActionFav), for: .touchUpInside)
                
                switch userRole {
                case UserRoleEnum.fiel.rawValue, UserRoleEnum.sacerdote.rawValue:
                    cell2.btnAdd.alpha = 1
                    cell2.addIcon.alpha = 1
                default:
                    cell2.btnAdd.alpha = 0
                    cell2.addIcon.alpha = 0
                }
                return cell2
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteChurchCollectionViewCell.reuseIdentifier, for: indexPath)
                (cell as? FavouriteChurchCollectionViewCell)?.fill(with: (self.locations[safe: indexPath.row])!)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.section == 0){
            switch priestChurches?.assigned?.name {
            case nil:
                let height: CGFloat = 130
                let width: CGFloat = UIScreen.main.bounds.width
                let size = CGSize(width: width, height: height)
                return size
            default:
                let height: CGFloat = 150
                let width: CGFloat = UIScreen.main.bounds.width
                let size = CGSize(width: width, height: height)
                return size
            }
        }else{
            switch locations.count {
            case 0:
                let height: CGFloat = 130
                let width: CGFloat = collectionView.bounds.width
                let size = CGSize(width: width, height: height)
                return size
            default:
                let height: CGFloat = 180
                let width: CGFloat = UIScreen.main.bounds.width
                let size = CGSize(width: width, height: height)
                return size
            }
           
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            mainChurchDetail(selector: 3)
        }else{
            if let id = self.locations[safe: indexPath.item]?.id {
                if comesFromSearch == true {
                    goToChurch(with: id, selector: 1)
                    comesFromSearch = false
                }else{
                    goToChurch(with: id, selector: 2)
                }
            }
        }
    }
    
}

extension Home_MiIglesia: MyChurchesViewProtocol {
    func showSearchBarResponse(result: [Assigned]) {
        //self.hideLoading()
        self.locations.removeAll()
        for _assigned in result {
            if _assigned.image_url?.isEmpty == false {
                if _assigned.image_url != "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png" ||  _assigned.image_url != "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"{
                    self.locations.append(_assigned)
                }
            }
        }
        //self.locations = result
        DispatchQueue.main.async {
            [weak self] in
            self?.otherChurchesCollectionView.reloadData()
            self?.comesFromSearch = true
        }
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
//            self.hideLoading()
            self.showMessage(error)
        }
        
    }
    
    func showChurches(_ churches: PriestChurches) {
        self.priestChurches = churches
        self.locations.removeAll()
        if let locations = churches.locations{
            for _assigned in locations{
                self.locations.append(_assigned)
//                self.hideLoading()
            }
        }
        self.locations = churches.locations ?? []
        
        DispatchQueue.main.async {
            [weak self] in
            self?.reloadContent()
//            self!.hideLoading()
        }
    }
    
    func showEmpty() {
        //self.priestChurches = []
        self.locations.removeAll()
        DispatchQueue.main.async {
            [weak self] in
            self?.reloadContent()
//            self!.hideLoading()
        }
    }
    
}
//MARK: - Search Bar delegates
extension Home_MiIglesia: UISearchBarDelegate {
    
    @objc func seachEvent(){
        if (searchBarF.text?.isEmpty ?? true) == false {
            self.presenter?.searchBarChurch(name: searchBarF.text ?? "")
        }else{
            if newUser {//esta logueado proceder
                presenter?.getChurches(with: self.currentUser ?? 0)
            }else{
                showEmpty()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.seachEvent), object: nil)
        self.perform(#selector(self.seachEvent), with: nil, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        if newUser {//esta logueado proceder
            self.presenter?.getChurches(with: currentUser ?? 1)
        }else{
            showEmpty()
        }
//        self.hideLoading()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  self.presenter?.getDataInteractorSearchBar(type: searchBar.text!)
        self.view.endEditing(true)
    }
}

extension Home_MiIglesia: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
            return MyChurchCollectionViewCell.reuseIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, prepareCellForSkeleton cell: UICollectionViewCell, at indexPath: IndexPath) {
        let cell = cell as? MyChurchCollectionViewCell
        cell?.isSkeletonable = indexPath.row != 0
    }
        
}
