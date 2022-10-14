//
//  SocialSearchView.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import UIKit

class SocialSearchView: UIViewController, SocialSearchViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: SocialSearchPresenterProtocol?
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblNavBar: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var btnCross: UIButton!
    
// MARK: LOCAL VAR -
    var arrayDataDummy = ["San Francisco de Asís", "San Francisco de Borja", "Comunidad de Paula", "San Francisco de Sales", "Francisco Javier Lopez", "Francisco Hugo Rojas", "Francisca Luigi Beltran"]
    var isFollowing = [false, false, true, false, true, true, false]
    
    var arrayResults = [ResultsSearch]()
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()

    }
    
// MARK: SETUP FUNCTIONS -
    private func setupTableView() {
        if #available(iOS 13.0, *) {
            mainTableView.register(UINib(nibName: "followCell", bundle: Bundle.local), forCellReuseIdentifier: "FOLLOWCELL")
        }else {
            // Fallback on earlier versions
        }
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        backBtn.setTitle("", for: .normal)
        btnCross.setTitle("", for: .normal)
    }
    
// MARK: @IBACTIONS -
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textDidChangeEditing(_ sender: Any) {
        self.presenter?.requestSearch(searchText: searchField.text ?? "")
        if searchField.text != "" {
            btnCross.isHidden = false
        }else{
            btnCross.isHidden = true
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        searchField.text = ""
        btnCross.isHidden = true
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func TapFollow(sender: UIButton) {
        
        let sectionData = arrayResults[sender.tag]
        var type = 5
        switch sectionData.type {
        case "Church":
            type = 2
        case "Community":
            type = 3
        default:
            type = 1
        }
        if sectionData.relationship != nil {
            presenter?.requestFollowUF(method: "DELETE", entityId: sectionData.id ?? 0, entityType: type)
        }else{
            presenter?.requestFollowUF(method: "POST", entityId: sectionData.id ?? 0, entityType: type)
        }
        
        mainTableView.reloadData()
    }

}

// MARK: SEARCH REPONSE -
extension SocialSearchView {
    func successSearch(data: SerachResponse) {
        arrayResults = data.result?.results ?? arrayResults
        mainTableView.reloadData()
    }
    
    func failSearch(message: String) {
        print(message)
    }
}

extension SocialSearchView {
    func successFollowUF(data: FollowResponse) {
        self.presenter?.requestSearch(searchText: searchField.text ?? "")
    }
    
    func failFollowUF(message: String) {
        print(message)
    }
}

