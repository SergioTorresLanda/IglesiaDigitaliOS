//
//  CongregationsView.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import UIKit

class CongregationsView: UIViewController, CongregationsViewProtocol {
        
// MARK: PROTOCOL VAR -
    var presenter: CongregationsPresenterProtocol?
    
// MARK: LOCAL VAR -
    var congregationsList: [Elements] = []
    var searchList: [String] = []
    var searchID: [Int] = []
    var isSearch = false
    var selectedCong = "Unspecified"
    var selectedID = 0
    var indexID = 0
    
    static let singleton = CongregationsView()
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentCard: UIView!
    @IBOutlet weak var littleNavBar: UIView!
    @IBOutlet weak var closeIcon: UIImageView!
    @IBOutlet weak var navBarTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lineaView: UIView!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.requestListCongregations()
        showShadowBackground()
        setupUI()
        setupGestures()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - congregationsView ")

    }
    
    private func setupUI() {
        contentCard.layer.cornerRadius = 6
        contentCard.clipsToBounds = true
        navBarTitle.adjustsFontSizeToFitWidth = true
        
    }
    
    func setupTableDelegates() {
        searchBar.delegate = self
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.reloadData()
    }
    
    private func setupGestures() {
        let tapCloseIcon = UITapGestureRecognizer(target: self, action: #selector(TapClose))
        self.closeIcon.addGestureRecognizer(tapCloseIcon)
    }
    
    private func showShadowBackground() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.2) {
                self.shadowView.alpha = 0.4
            }
        }
    }
    
// MARK: @OBJC FUNC -
    @objc func TapClose() {
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
// MARK: SERVICES API FUNCTIONS -
    func succesResponse(data: CongregationsList) {
        congregationsList = data.data ?? []
        setupTableDelegates()
    }
    
    func failResponse() {
        
    }

}

extension CongregationsView: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("El texto cambio")
        isSearch = true
        if searchList .count != 0 {
            searchList.removeAll()
            searchID.removeAll()
        }
        congregationsList.forEach { item in
            let lessFisrt = item.descripcion?.lowercased()
            if lessFisrt?.contains(searchBar.text?.lowercased() ?? "z") == true {
                searchList.append(item.descripcion ?? "Unspecified")
                searchID.append(item.id ?? 0)
            }
            
        }

        if searchList.count == 0 {
            isSearch = false
        }
        
        listTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
}
