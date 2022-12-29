//
//  PriestPSOSView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

class PriestPSOSView: UIViewController, PriestPSOSViewProtocol {
    var presenter: PriestPSOSPresenterProtocol?

    @IBOutlet weak var segementControl: UISegmentedControl!
    @IBOutlet weak var servicesTable: UITableView!
    @IBOutlet weak var segmentLine: UIView!
    @IBOutlet weak var lblMainTitle: UILabel!
    
    static let singleton = PriestPSOSView()
    
    var pos = 0
    var idService = 0
    var firstServices = ["Unción de los enfermos", "Misa de difuntos", "Unción de los enfermos"]
    var secondServices = ["Misa de difuntos", "Unción de los enfermos", "Misa de difuntos"]
    
    var firstNames = ["Jesus Silva", "Jose Luna", "Maria Perez"]
    var secondNames = ["Pedro Silva",  "Luna vega", "Guadalupe Suarez"]
    
    var fisrtStatus = ["Ayuda en camino", "Por aceptar", "Llamada realizada"]
    var SecondStatus = ["Cancelado", "Finalizado", "Finalizado"]
    var statusStr = "ACTIVE"
    
    var dummyServices : [String] = []
    var dummyNames : [String] = []
    var dummyStatus : [String] = []
    
    var servicesNames : [String] = []
    var faithfulNames : [String] = []
    var servicesStatus : [String] = []
    
    var listRequests : [ListSrevices] = []
    var listHistory : [ListSrevices] = []
    let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
    
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segementControl.addUnderlineForSelectedSegment()
      //  setupTableDelegates()
        setupUI()
      //  presenter?.requestListServices(paramStatus: "ACTIVE")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("EC virtualLibrary - NewControllers - Priest Controllers - PriestPrincipalSOS")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             self.showLoading()
        }
        presenter?.requestListServices(paramStatus: statusStr)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func setupUI() {
        lblMainTitle.adjustsFontSizeToFitWidth = true
    }
    
    func setupTableDelegates() {
        dummyServices = firstServices
        dummyNames = firstNames
        dummyStatus = fisrtStatus
        servicesTable.delegate = self
        servicesTable.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.alertLoader.dismiss(animated: true, completion: nil)
            self.imageView.removeFromSuperview()
            self.servicesTable.reloadData()
        })
       
    }
    
    func showLoading(){
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: true, completion: nil)
        
    }
    
    func successLoadRequestServices(requestData: [ListSrevices]) {
        print(requestData)
        
        listRequests = requestData.sorted(by: { $0.id ?? 0 > $1.id ?? 0 })
        setupTableDelegates()
        
    }
    
    func failLoadRequestServices() {
        
    }
    
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        segementControl.changeUnderlinePosition()
        
        if segementControl.selectedSegmentIndex == 0 {
            statusStr = "ACTIVE"
            listRequests.removeAll()
            servicesTable.reloadData()
            presenter?.requestListServices(paramStatus: statusStr)
           // servicesTable.reloadData()
        }else{
            statusStr = "FINISHED"
            listRequests.removeAll()
            servicesTable.reloadData()
            presenter?.requestListServices(paramStatus: statusStr)
           // servicesTable.reloadData()
        }
        
    }
    
}
