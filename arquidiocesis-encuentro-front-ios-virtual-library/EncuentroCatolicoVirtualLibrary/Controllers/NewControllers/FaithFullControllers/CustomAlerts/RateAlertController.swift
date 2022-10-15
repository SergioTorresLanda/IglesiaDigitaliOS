//
//  RateAlertController.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 17/06/21.
//

import UIKit

open class RateAlertController: UIViewController {

    var rate = 0
    var serviceID = 0
   
    @IBOutlet weak var shadowAlert: UIView!
    @IBOutlet weak var cardAlertView: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var btnEnviar: UIButton!
    @IBOutlet weak var lineaView: UIView!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var comentariosField: UITextField!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        comentariosField.returnKeyType = .done
        comentariosField.delegate = self
        setupGestures()
        cardAlertView.layer.cornerRadius = 12
        btnEnviar.layer.cornerRadius = 8
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowAlert.alpha = 0.25
            }
        }

    }

    func setupGestures() {
       let tapShadowGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapShadow))
       self.shadowAlert.addGestureRecognizer(tapShadowGesture)
        
        let tapI = UITapGestureRecognizer(target: self, action: #selector(handleTapStar1))
        star1.addGestureRecognizer(tapI)
        
        let tapII = UITapGestureRecognizer(target: self, action: #selector(handleTapStar2))
        star2.addGestureRecognizer(tapII)
        
        let tapIII = UITapGestureRecognizer(target: self, action: #selector(handleTapStar3))
        star3.addGestureRecognizer(tapIII)
        
        let tapIV = UITapGestureRecognizer(target: self, action: #selector(handleTapStar4))
        star4.addGestureRecognizer(tapIV)
        
        let tapV = UITapGestureRecognizer(target: self, action: #selector(handleTapStar5))
        star5.addGestureRecognizer(tapV)
        
   }
   
   @objc func handleTapShadow() {
       self.dismiss(animated: false, completion: nil)
   }
    
    @objc func handleTapStar1() {
        
        if #available(iOS 13.0, *) {
            let imgFill = UIImage(systemName: "star.fill")
            let img = UIImage(systemName: "star")
            if rate != 1 {
                star1.image = imgFill
                star2.image = img
                star3.image = img
                star4.image = img
                star5.image = img
                rate = 1
                
            }else{
                
                star1.image = img
                rate = 0
            }
            
           
        } else {
            // Fallback on earlier versions
        }
                
    }
    
    @objc func handleTapStar2() {
       
        if #available(iOS 13.0, *) {
            let imgFill = UIImage(systemName: "star.fill")
            let img = UIImage(systemName: "star")
            if rate != 2 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = img
                star4.image = img
                star5.image = img
                rate = 2
                
            }else{
                star1.image = img
                star2.image = img
                rate = 0
            }
        } else {
            // Fallback on earlier versions
        }
    
    }
    
    @objc func handleTapStar3() {
        
        if #available(iOS 13.0, *) {
            let imgFill = UIImage(systemName: "star.fill")
            let img = UIImage(systemName: "star")
            if rate != 3 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = img
                star5.image = img
                rate = 3
                
            }else{
                star1.image = img
                star2.image = img
                star3.image = img
                rate = 0
                
            }
        } else {
            // Fallback on earlier versions
        }
               
    }
    
    @objc func handleTapStar4() {
        if #available(iOS 13.0, *) {
            let imgFill = UIImage(systemName: "star.fill")
            let img = UIImage(systemName: "star")
            if rate != 4 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgFill
                star5.image = img
                rate = 4
                
            }else{
                star1.image = img
                star2.image = img
                star3.image = img
                star4.image = img
                rate = 0
                
            }
            
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    @objc func handleTapStar5() {
       
       
        if #available(iOS 13.0, *) {
            let imgFill = UIImage(systemName: "star.fill")
            let img = UIImage(systemName: "star")
            if rate != 5 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgFill
                star5.image = imgFill
                rate = 5
                
            }else{
                star1.image = img
                star2.image = img
                star3.image = img
                star4.image = img
                star5.image = img
                rate = 0
                
            }
        } else {
            // Fallback on earlier versions
        }
                
    }
    
    @IBAction func btnEnviarAction(_ sender: Any) {
       // self.dismiss(animated: false, completion: nil)
        rateService(serviceID: "\(serviceID)", rating: rate, comment: comentariosField.text ?? "")
    }
    
    
    class public func showAlertRate(serviceID: Int) -> RateAlertController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: RateAlertController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "RateAlertController") as! RateAlertController
        view.modalPresentationStyle = .overFullScreen
        view.serviceID = serviceID
        
        return view
    }

}

extension RateAlertController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
}

extension RateAlertController {
    
    // MARK: RATE SERVICE API -
    func rateService(serviceID: String, rating: Int, comment: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(serviceID)") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        let parameters : [String:Any] = [
            "rating" : rating,
            "comments" : comment
        ]
        let body = try! JSONSerialization.data(withJSONObject: parameters)
        request.httpMethod = "PUT"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
            
        }.resume()
    }
}
