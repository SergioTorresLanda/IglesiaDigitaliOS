//
//  MyCommunitiesMainViewController.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 11/08/21.
//

import UIKit
import CoreLocation

enum UserCommunityStatus: String {
    case pendingApproval = "PENDING_VICARAGE_APPROVAL"
    case complete = "COMPLETED"
    case pendindCompletion = "PENDING_COMPLETION"
}

class MyCommunitiesMainViewController: UIViewController, MyCommunitiesMainViewProtocol, CLLocationManagerDelegate {
    
    var presenter: MyCommunitiesMainViewPresenterProtocol?
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
//    let label1 = "Señora de Jesuz"
//    let label2 = "Misioneras franciscanas"
    let id = UserDefaults.standard.integer(forKey: "id")
    var communitiesID = Int()
    var communitiesFavID = Int()
    var communities: CommunityMainList?
    var searchBarResult: CommunitySearchList?
    var comoesFromSerach: Bool = false
    
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    let communityStatus = UserDefaults.standard.string(forKey: "communityStatus")
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var mainComTableView: UITableView!
    @IBOutlet weak var favComTableView: UITableView!
    @IBOutlet weak var customNav: UIView!
    @IBOutlet weak var cardEmpty: UIView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var iconChurch: UIImageView!
    @IBOutlet weak var btnTitleAdd: UIButton!
    @IBOutlet weak var addTitleIconP: UIButton!
    @IBOutlet weak var btnAddTitleFav: UIButton!
    @IBOutlet weak var btnAddTitleFavIcon: UIButton!
    @IBOutlet weak var favotitesLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  presenter?.getCommunitiesData(id: id)
        initView()
        setupLocation()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - MyCommunitiesMV- MyCommunitiesVC")
        presenter?.getCommunitiesData(id: id)
        self.showLoading()
    }
    func initView() {
        favotitesLbl.adjustsFontSizeToFitWidth = true
        cardEmpty.layer.cornerRadius = 10
        cardEmpty.ShadowCard()
        customNav.layer.cornerRadius = 20
        customNav.ShadowNavBar()
        mainComTableView.delegate = self
        mainComTableView.dataSource = self
        favComTableView.delegate = self
        favComTableView.dataSource = self
        searchBar.delegate = self
        mainComTableView.register(CommunityTableViewCell.nib, forCellReuseIdentifier: CommunityTableViewCell.reuseIdentifier)
        mainComTableView.register(EmptyTableViewCell.nib, forCellReuseIdentifier: EmptyTableViewCell.reuseIdentifier)
        favComTableView.register(CommunityTableViewCell.nib, forCellReuseIdentifier: CommunityTableViewCell.reuseIdentifier)
        favComTableView.register(FavEmptyTableViewCell.nib, forCellReuseIdentifier: FavEmptyTableViewCell.reuseIdentifier)
        self.favComTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.mainComTableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    func hideLoading() {
        loadingAlert.dismiss(animated: false, completion: nil)
    }
    @IBAction func mapButtonAction(_ sender: Any) {
        presenter?.goToMaps(isPrincipal: 3, isPrincialBool: false)
    }
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addAction(_ sender: Any) {
        presenter?.goToMaps(isPrincipal: 3, isPrincialBool: false)
    }
    
    @IBAction func addPrincipal(_ sender: Any) {
        presenter?.goToMaps(isPrincipal: 3, isPrincialBool: true)
    }
    
    @IBAction func addActionCard(_ sender: Any) {
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()
                    
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()
                    
                @unknown default:
                    break
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func communitySuccess(response: CommunityMainList) {
        communities = response
        print(communities, "****")
        DispatchQueue.main.async { [self] in
            mainComTableView.reloadData()
            favComTableView.reloadData()
            
            if communities?.assigned == nil {
                addTitleIconP.isHidden = true
                btnTitleAdd.isHidden = true
                
            }else{
                addTitleIconP.isHidden = true
                btnTitleAdd.setTitle("Cambiar", for: .normal)
                btnTitleAdd.isHidden = false
                
            }
            
            if communities?.locations?.count != 0 {
                cardEmpty.isHidden = true
                btnAddTitleFav.isHidden = false
                btnAddTitleFavIcon.isHidden = false
                favComTableView.alpha = 1
                
            }else{
                cardEmpty.isHidden = false
                btnAddTitleFav.isHidden = true
                btnAddTitleFavIcon.isHidden = true
                favComTableView.alpha = 0
                
            }
            self.hideLoading()
        }
    }

    func communityError(msg: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: "Error en el servico, intenta de nuevo más trde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func serachBarResponse(result: CommunitySearchList) {
        searchBarResult = result
        comoesFromSerach = true
        DispatchQueue.main.async { [self] in
            favComTableView.reloadData()
        }
    }
}



extension MyCommunitiesMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainComTableView {
            return 1
        }else{
            if comoesFromSerach == false {
                return communities?.locations?.count ?? 1
            }else {
                return searchBarResult?.count ?? 1
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainComTableView {
            if communities?.assigned == nil {
                let cell = mainComTableView.dequeueReusableCell(withIdentifier: "CELLNEWEMPTY", for: indexPath) as! NewEmptyCell
                cell.cardView.layer.cornerRadius = 10
                cell.selectionStyle = .none
                cell.cardView.ShadowCard()
                cell.delegate = self
                return cell
            }else {
                let cell = mainComTableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.reuseIdentifier, for: indexPath) as! CommunityTableViewCell
                cell.subtitleLabel.text = communities?.assigned?.name
                communitiesID = communities?.assigned?.id ?? 1
                let url = communities?.assigned?.imageURL ?? ""
                if let imageUrl = URL(string: url) {
                    cell.mainImageView.af.setImage(withURL: imageUrl)
                }
                cell.selectionStyle = .none
                return cell
            }
        }else{
            if ((communities?.locations?.isEmpty) == nil) {
                let cell = favComTableView.dequeueReusableCell(withIdentifier: "CELLEMPTYFAVCOM", for: indexPath) as! EmptyFavComCell
                cell.cardView.layer.cornerRadius = 10
                cell.cardView.ShadowCard()
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }else {
                let cell = favComTableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.reuseIdentifier, for: indexPath) as! CommunityTableViewCell
                if comoesFromSerach == false {
                    cell.subtitleLabel.text = communities?.locations?[indexPath.row].name
                    communitiesFavID = communities?.locations?[indexPath.row].id ?? 1
                    cell.selectionStyle = .none
                    let url = communities?.locations?[indexPath.row].imageURL ?? ""
                    if let imageUrl = URL(string: url) {
                        cell.mainImageView.af.setImage(withURL: imageUrl)
                    }
                    favComTableView.separatorStyle = .singleLine
                }else {
                    cell.subtitleLabel.text = searchBarResult?[indexPath.row].name
                    communitiesFavID = searchBarResult?[indexPath.row].id ?? 1
                    favComTableView.separatorStyle = .singleLine
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == mainComTableView {
            if communities?.assigned != nil {
                switch communityStatus {
                case UserCommunityStatus.pendindCompletion.rawValue:
                    presenter?.goToCommunityDetail(myChourch: false, id: communitiesID, isFavorite: true, isPrincipal: false, isEdit: false)
                default:
                    presenter?.goToCommunityDetail(myChourch: false, id: communitiesID, isFavorite: true, isPrincipal: false, isEdit: true)
                }
            }else{
               print("Nothing")
            }
               
        }else {
            
            print(communitiesFavID, "****")
            if communities?.locations?[indexPath.row].id != nil {
                if comoesFromSerach == true {
                   // presenter?.goToCommunityDetail(myChourch: false, id: communitiesFavID, isFavorite: false, isPrincipal: false)
                    let idA = communities?.locations?[indexPath.row].id ?? 1
                    
                    switch communityStatus {
                    case UserCommunityStatus.pendindCompletion.rawValue:
                        presenter?.goToCommunityDetail(myChourch: false, id: idA, isFavorite: true, isPrincipal: false, isEdit: false)
                    default:
                        presenter?.goToCommunityDetail(myChourch: false, id: idA, isFavorite: true, isPrincipal: false, isEdit: true)
                    }
                    searchBar.resignFirstResponder()
                    searchBar.text = ""
                    comoesFromSerach = false
                } else {
                    let idA = communities?.locations?[indexPath.row].id ?? 1
                    switch communityStatus {
                    case UserCommunityStatus.pendindCompletion.rawValue:
                        presenter?.goToCommunityDetail(myChourch: false, id: idA, isFavorite: true, isPrincipal: false, isEdit: false)
                    default:
                        presenter?.goToCommunityDetail(myChourch: false, id: idA, isFavorite: true, isPrincipal: false, isEdit: true)
                    }
                    
                }
            }
        }
    }
    
}

extension MyCommunitiesMainViewController: UISearchBarDelegate {
    
    @objc func seachEvent(){
        if (searchBar.text?.isEmpty ?? true) == false {
//            self.showLoading()
            self.presenter?.searchBarChurch(name: searchBar.text ?? "")
        }else{
//            self.showLoading()
            presenter?.getCommunitiesData(id: id)
            comoesFromSerach = false
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.seachEvent), object: nil)
        self.perform(#selector(self.seachEvent), with: nil, afterDelay: 0.5)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        presenter?.getCommunitiesData(id: id)
        comoesFromSerach = false
//        self.hideLoading()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  self.presenter?.getDataInteractorSearchBar(type: searchBar.text!)
        searchBar.text = ""
        self.view.endEditing(true)
    }
}

extension MyCommunitiesMainViewController: addCommunityEmptyFavButtonDelegate {
    func didPressaddCommunityEmptyFavButton(_ sender: UIButton) {
       // presenter?.goToMaps(isPrincipal: 3, isPrincialBool: false)
    }
}

extension MyCommunitiesMainViewController: addCommunityNewEmptyButtonDelegate {
    func didPressaddCommunityNewEmptyButton(_ sender: UIButton) {
       // presenter?.goToMaps(isPrincipal: 3, isPrincialBool: true)
    }
}
