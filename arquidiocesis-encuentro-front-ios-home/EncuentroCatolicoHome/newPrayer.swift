//
//  ViewController.swift
//  Cadena de Oracion
//
//  Created by Branchbit on 22/03/21.
//

import UIKit
import RealmSwift
import EncuentroCatolicoUtils
import EncuentroCatolicoProfile

class newPrayer: UIViewController {
    
    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var txtComments  : UITextView!
    @IBOutlet weak var btnSend      : UIButton!
    @IBOutlet weak var alertView    : UIView!
    @IBOutlet weak var imgView      : UIImageView!
    
    
    let realm = try! Realm()
    var userName: String?
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nGenerando oración...", preferredStyle: .alert)
    
    override func viewWillAppear(_ animated: Bool) {
        let url = UserDefaults.standard.string(forKey: "imageUrl")
        guard let fileUrl = URL(string: url ?? "") else { return  }
        imgView.af.setImage(withURL: fileUrl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSend.layer.cornerRadius = 10
        alertView.layer.cornerRadius = 20
        alertView.addShadow()
        imgView.makeCircular()
        let profile = EditionPromisseDataManager.shareInstance.findByEmail(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
        if #available(iOS 13.0, *) {
            let url = UserDefaults.standard.string(forKey: "imageUrl")
            guard let fileUrl = URL(string: url ?? "") else { return  }
            imgView.af.setImage(withURL: fileUrl)
            imgView.image = profile.count > 0 ? HttpRequestSingleton.shareManager.convertBase64StringToImage(imageBase64String:  profile[0].image ?? "") : UIImage(named: "userImage",in: Bundle.local, with: nil)
        } else {
            // Fallback on earlier versions
        }
        imgView.contentMode = .scaleAspectFill
        lblName.text = userName
        txtComments.delegate = self
        txtComments.layer.cornerRadius = 10
        txtComments.text = "Escribe una oración..."
        txtComments.textColor = UIColor.lightGray
    }
    
    func sendPrayer(){
        self.view.endEditing(true)
        showLoading()
//        sendRESTRequest(endPoint: "https://api-develop.arquidiocesis.mx/prayers")
        sendRESTRequest(endPoint: "\(APIType.shared.User())/prayers")
    }
    
    func closeView() {
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "PrayerSend"), object: nil, userInfo: nil))
        self.dismiss(animated: true, completion: nil)
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideLoading(error: String?){
        if error != nil{
            self.alert.dismiss(animated: false, completion: {
                let errorAlert = UIAlertController(title: "Alerta", message: error!, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            })
        }else{
            self.alert.dismiss(animated: false, completion: {
                self.closeView()
            })
        }
    }
    
    func sendRESTRequest(endPoint: String) {
        let endpoint: URL = URL(string: endPoint)!
        var request = URLRequest(url: endpoint)
        request.timeoutInterval = 10
        let parameterDictionary: [String : Any] = [
            "fiel_id" : UserDefaults.standard.value(forKey: "id") ?? 1,
            "fiel_name" : UserDefaults.standard.value(forKey: "email") ?? "?",
            "reason" : 5,
            "description": txtComments.text!
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                DispatchQueue.main.async {
                    self.hideLoading(error: nil)
                }
            } else {
                DispatchQueue.main.async{
                    var msgError = ""
                    switch (response as! HTTPURLResponse).statusCode {
                    case 400:
                        msgError = "Servicio no disponible, intente más tarde"
                    case 401:
                        msgError = "Acceso no autorizado "
                    case 403:
                        msgError = "Acceso denegado"
                    case 404:
                        msgError = "Servicio no encontrado, intente más tarde"
                    case 500:
                        msgError = "Error interno del servidor, por favor intente más tarde"
                    default:
                        msgError = "Ocurrió un error desconocido, intente más tarde"
                    }
                    self.hideLoading(error: msgError)
                    APIType.shared.refreshToken()
                }
            }
        }
        tarea.resume()
    }
    
    @IBAction func newPrayer(_ sender: Any){
        if txtComments.text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 || txtComments.text == "Escribe una oración..."{
            let alert = UIAlertController(title: "Atención", message: "No puede hacer una publicación vacía", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            sendPrayer()
        }
    }
    
    @IBAction func close(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension newPrayer: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Escribe una oración..."
            textView.textColor = UIColor.lightGray
        }
    }
}
