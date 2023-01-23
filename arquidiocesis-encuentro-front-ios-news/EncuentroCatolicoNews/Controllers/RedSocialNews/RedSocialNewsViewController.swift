//
//  redSocialNewsViewController.swift
//  EncuentroCatolicoNews
//
//  Created by Luis Angel on 11/01/23.
//

import UIKit
import EncuentroCatolicoLive
import EncuentroCatolicoScanner
import EncuentroCatolicoProfile
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoPrayers
import Foundation
import EncuentroCatolicoNewFormation

class RedSocialNewsViewController: UIViewController {
    //outletss
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var titulo: UILabel!
   
    @IBOutlet weak var redUrl: UILabel!
    @IBOutlet weak var desc: CustomLabel!
    @IBOutlet weak var imagen: UIImageView!
    
    //variables globales
    var id = ""
    var post:Posts?
    var url: CustomLabelType = .url
    var urlG="https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012"
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        id=" ya "
        desc.delegate = self
        //configuracione iniciales de la clase
        print("la vista se creo y cargo en la memoria")
        print("el valor author del post es: ")
        print(String(post!.content!))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //llamadas a base de datos
        print("la vista esta apunto de aparecer")
        titulo.text = post?.author?.name
        desc.text = post?.content
       
        let iDate = post?.createdAt
        let strDate = "\(iDate ?? 0)"
        fecha.text = Date(timeIntervalSince1970: TimeInterval(strDate) ?? 0.0).formatRelativeString()
//        fecha.text = post?.createdAt
        
       
//        titulo.text="ya se conecto el titulo"
        if post?.multimedia! == nil{
            print("multimedia::::empty")
        }else{
            if !post!.multimedia!.isEmpty{
                if let media = post?.multimedia?[0]{
                    switch media.format {
                    case "jpeg", "png":
                        let url = media.url ?? ""
                        imagen.loadS(urlS: url)
                    default:
                        print("lo")
                    }
                }
            }else{
                imagen.loadS(urlS: urlG)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("la vista acaba de aparecer")
    }
    
    override func viewDidLayoutSubviews() {
        print("los elementos de la vista ya se cargaron y se les dio sus constraints y diseño (ideal para formato de botomes textos etc..)")
        //backbtn.setBorder(borderColor: )
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("la vista esta apunto de desaparecer")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("la vista acaba de desaparecer")
    }
    
    
    @IBAction func backBtnClick(_ sender: Any) {
        print("click back")
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension RedSocialNewsViewController: CustomLabelDelegate {
    public func didSelect(_ text: String, type: CustomLabelType) {
        print("aqui esta el link 2 \(text)")
        if let url = URL(string: text) {
                  UIApplication.shared.open(url)
               }
    }
}


extension UIImageView {
    
    func loadS(urlS: String) {
        guard let url = URL(string:urlS)else{
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        //imageCache.setObject(image, forKey: urlS as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

