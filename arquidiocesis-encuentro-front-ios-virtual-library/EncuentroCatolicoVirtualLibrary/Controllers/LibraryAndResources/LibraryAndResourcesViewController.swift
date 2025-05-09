//
//  LibraryAndResourcesViewController.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created Desarrollo on 15/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Lottie

class LibraryAndResourcesViewController: UIViewController, LibraryAndResourcesViewProtocol, CustomSegmentedControlDelegate {

    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var imgView            : UIImageView!
    @IBOutlet weak var lblTitle           : UILabel!
    @IBOutlet weak var lblSubtitle        : UILabel!
    @IBOutlet weak var featuredView       : UIView!
    @IBOutlet weak var interfaceSegmented : CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Descripción","Recursos"])
            interfaceSegmented.selectorViewColor = UIColor(red: 0.0863, green: 0.1216, blue: 0.5216, alpha: 1.0)
            interfaceSegmented.selectorTextColor = UIColor(red: 0.0863, green: 0.1216, blue: 0.5216, alpha: 1.0)
        }
    }
    @IBOutlet weak var contentView        : UIView!
    @IBOutlet weak var scrollViewHeight   : NSLayoutConstraint!
    @IBOutlet weak var scrollView         : UIScrollView! 
    
    var presenter: LibraryAndResourcesPresenterProtocol?
    var contentID: Int!
    var resourcesContent: [Resource] = []
    var descriptionContent: String? = nil
    
    let descriptionController = LibraryDescriptionRouter.createModule()
    let resourcesController = LibraryResourcesRouter.createModule()
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    private var animationView: AnimationView?
    
	override func viewDidLoad() {
        super.viewDidLoad()
        if contentID == nil{
            mostrarMSG(dtcAlerta: ["Error":"No se pudo procesar el ID correctamente"])
        }else{
            showLoading()
            presenter?.getContentByID(contentID: contentID)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
        interfaceSegmented.delegate = self
        navBar.roundCorners(.layerMinXMaxYCorner, radius: 15)
        embedView(viewToEmbed: descriptionController, tag: 1)
    }
    
    func embedView(viewToEmbed: UIViewController, tag: Int){
        addChild(viewToEmbed)
        viewToEmbed.view.tag = tag
        self.contentView.addSubview(viewToEmbed.view)
        viewToEmbed.view.frame = contentView.bounds
        viewToEmbed.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewToEmbed.didMove(toParent: self)
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func setFirstView(){
        lblSubtitle.isHidden = false
        featuredView.isHidden = false
        if contentView.subviews.contains(resourcesController.view){
            if let removable = contentView.viewWithTag(2){
               removable.removeFromSuperview()
            }
            if let removable = contentView.viewWithTag(3){
               removable.removeFromSuperview()
            }
        }
        embedView(viewToEmbed: descriptionController, tag: 1)
    }
    
    func setSecondView(){
        lblSubtitle.isHidden = true
        featuredView.isHidden = true
        if contentView.subviews.contains(descriptionController.view){
            if let removable = contentView.viewWithTag(1){
               removable.removeFromSuperview()
            }
            if let removable = contentView.viewWithTag(3){
               removable.removeFromSuperview()
            }
        }
        embedView(viewToEmbed: resourcesController, tag: 2)
        NotificationCenter.default.post(name: Notification.Name("loadResources"), object: resourcesContent)
    }
    
    func showLottie(){
        scrollView.layoutIfNeeded()
        contentView.layoutIfNeeded()
        let label = UILabel()
        label.text = "Sin Descripción, puedes visualizar los recursos audio visuales"
        label.textAlignment = .center
        label.numberOfLines = 4
        animationView = .init(name: "noData")
        animationView!.animation = Animation.named("noData", bundle: Bundle.local)
        animationView!.frame = CGRect(x: 50, y: 0, width: 300.0, height: 300.0)
        label.frame = CGRect(x: 25, y: 50, width: 250.0, height: 400.0)
        animationView?.addSubview(label)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        animationView!.play()
        animationView?.tag = 3
        contentView.addSubview(animationView!)
    }
    
    func configureScrollSize(index: Int){
        if descriptionContent == nil && index == 0{
               scrollViewHeight.constant = 400.0
               scrollView.layoutIfNeeded()
               self.view.layoutIfNeeded()
               showLottie()
        }
        if index == 1{
            if resourcesContent.count == 0{
                scrollViewHeight.constant = 400.0
                showLottie()
            }else{
                scrollViewHeight.constant = 1200.0
                scrollView.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    func change(to index: Int) {
        switch index {
        case 0:
            setFirstView()
            configureScrollSize(index: 0)
        case 1:
            setSecondView()
            configureScrollSize(index: 1)
        default:
            print("default case")
        }
    }
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        alert.dismiss(animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.alert.dismiss(animated: true, completion: nil)
            })
            let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        })
    }
    
    func loadContentDetail(data: ContentDetail){
        DispatchQueue.main.async {
            self.lblTitle.text = data.title
            self.lblSubtitle.text = data.subtitle
            self.descriptionContent = data.contentDetailDescription
            NotificationCenter.default.post(name: Notification.Name("loadDescription"), object: data.contentDetailDescription)
            self.configureScrollSize(index: 0)
            self.resourcesContent = data.resources
            let url = URL(string: data.image ?? "")
            let data = try? Data(contentsOf: url!)
            if data != nil {
                self.imgView.image = UIImage(data: data!)
            }
            self.alert.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }

}

extension UIView {
  func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
      self.layer.maskedCorners = corners
      self.layer.cornerRadius = radius
  }
}
