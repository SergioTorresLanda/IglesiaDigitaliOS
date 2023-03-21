//
//  NewHomeServiceView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

class NewHomeServiceView: UIViewController, NewHomeServiceViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: NewHomeServicePresenterProtocol?
    
// MARK: - GLOBAL VARIABLES -
    var arraySections = ["Intenciones", "Servicios"]
// MARK: @IBOUTLETS -
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainTable: UITableView!
// MARK:  LIFE CYCLE FUNCS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - NewHomeServiceVC ")
    }
    
// MARK: SETUPS FUNCS -
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        customNavBar.ShadowNavBar()
    }
    
    private func setupDelegates() {
        mainTable.delegate = self
        mainTable.dataSource = self
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
// MARK: @OBJC FUNCS -
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
