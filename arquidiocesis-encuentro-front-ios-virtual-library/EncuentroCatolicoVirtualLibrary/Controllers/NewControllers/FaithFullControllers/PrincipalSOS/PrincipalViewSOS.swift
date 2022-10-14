//
//  PrincipalViewSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class PrincipalViewSOS: UIViewController, PrincipalViewProtocol, UIViewControllerTransitioningDelegate {
    
    static let singleton = PrincipalViewSOS()
    let transition = SlideTransition()
    let defaults = UserDefaults.standard
    var presenter: PrincipalPresenterProtocol?
    var titlesArray: [String] = []
    var subTitArray: [String] = []
    var idServices: [Int] = []
//    var titlesArray = ["Unción de los enfermos", "Celebrar misa de difuntos en funeraria"]
//    var subTitArray = ["Sacramento por el que Jesús cura, fortalece y consuela", ""]
    var indexCircle : Int?
    var stateCell = [false, false]
    var selctedCell = 100
    var cleanAll = false
    var isTap = false
    var alert2 : InputAlertController?
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var globalIndex = 100
    var selectedId = 0
    
// MARK: SEND DATA VAR -
    var direction = ""
    var serviceID = 0
    var nameService = ""
        
//MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var CustomNavBar: UIView!
    @IBOutlet weak var navBarTitle: UILabel!
    @IBOutlet weak var imgCentral: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var btnEmergency: UIButton!
        
//MARK: LIFE CYCLE -
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showLoading()
        setupUI()
        presenter?.getData()
        let singleton = PrincipalViewSOS.singleton
        singleton.isTap = false
        
    }
    
// MARK: UI FUNCTIONS -
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    private func setupUI() {
        CustomNavBar.ShadowNavBar()
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle2.adjustsFontSizeToFitWidth = true
        CustomNavBar.layer.cornerRadius = 20
        btnEmergency.layer.cornerRadius = 10
//        mainTable.delegate = self
//        mainTable.dataSource = self
       
    }
    
    func loadData(data: [PModelSOS]?) {
        data?.forEach({ (model) in
            titlesArray.append(model.name ?? "")
            subTitArray.append(model.description ?? "")
            idServices.append(model.id ?? 0)
        })
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.reloadData()
        alertLoader.dismiss(animated: true, completion: nil)
        
//        let module = UncionServiceSOSRouter.createModule()
//        let SOSId = defaults.integer(forKey: "SOSId")
//        print("%$%", SOSId)
//        if SOSId > 0 {
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                self.navigationController?.pushViewController(module, animated: true)
//            }
//        }
    }
    
    func successGetLastSOS(data: LastSosModel) {
        print("Vamoh directo al service")
        alertLoader.dismiss(animated: true, completion: nil)
        
        switch data.status {
        case "CANCELLED", "SUCCESSFULLY", "UNSUCCESSFULLY", "COMPLETED":
            let module = UncionMapRouter.createModuleMap()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.pushViewController(module, animated: true)
            }
        default:
            let singleton = UncionSOSView.singleton
            singleton.newServiceID = data.service_id ?? 0
            let module = UncionServiceSOSRouter.createModule()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.pushViewController(module, animated: true)
            }

        }
        
    }
    
    func failGetLastSOS(message: String) {
        print(message)
        alertLoader.dismiss(animated: true, completion: nil)
        if message == "Error en la data" {
            let module = UncionMapRouter.createModuleMap()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.pushViewController(module, animated: true)
            }
        }
    }
    

//MARK: @IBACTIONS -
    
    @IBAction func btnEmergency(_ sender: Any) {
        
        var toContinue = false
        
        stateCell.forEach { (state) in
            if state == true {
                toContinue = true
            }
        }
        
        if toContinue == true {
            self.present(alertLoader, animated: true, completion: nil)
            presenter?.getLastSOS(serviceID: selectedId)
            
        }else{

            let singleton = AcceptAlert.singleton
            singleton.type = "Main"
            let alert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Debes seleccionar un servicio para poder continuar")
            alert.view.backgroundColor = .clear
            present(alert, animated: true)
        }

    }
    
}

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
     guard let toInfoView = transitionContext.viewController(forKey: .to),
        let fromInfoView = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
       // let finalWidth = toInfoView.view.bounds.width * 0.76
        let finalWidth = toInfoView.view.bounds.width
        let finalHeight = toInfoView.view.bounds.height
        
        if isPresenting {
            
            // add menu view controller to container
            containerView.addSubview(toInfoView.view)
            
            // init frame off the screen
           // toInfoView.view.frame = CGRect(x: fromInfoView.view.frame.width, y: 0, width: finalWidth, height: finalHeight)
            toInfoView.view.frame = CGRect(x: 0, y: fromInfoView.view.frame.height, width: finalWidth, height: finalHeight)
            //toInfoView.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
            
        }
        
        // Animate on screen
        let transform = {
            
           // toInfoView.view.transform = CGAffineTransform(translationX: -finalWidth, y: 0)
            toInfoView.view.transform = CGAffineTransform(translationX: 0, y: -finalHeight)
            
        }
       // Animate off screen
            
            let identity = {
                fromInfoView.view.transform = .identity
                
            }
            
         // Animation of the transition
            let duration = self.transitionDuration(using: transitionContext)
            let isCancelled = transitionContext.transitionWasCancelled
            UIView.animate(withDuration: duration, animations: {
                self.isPresenting ? transform() : identity()
            }) { (_) in
                transitionContext.completeTransition(!isCancelled)
            }
            
        }
        
    }
