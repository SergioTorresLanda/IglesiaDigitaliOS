//
//  Actividades_CrearDonador.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 13/06/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_CrearActor: UIViewController {

    @IBOutlet weak var ComentsLbl: UILabel!
    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var comentsTV: UITextView!
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var telefonoTF: UITextField!
    @IBOutlet weak var numCharsLbl: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var guardarBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var viewHead: UIView!
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var alertFields : AcceptAlert?
    var azulito=UIColor(named: "azulActivo",in: Bundle(for: Actividades_CrearComedor.self), compatibleWith: nil)
    var eventoId = 0
    var update=false
    var actorId=0
    var tipo_actor=0
    var tipoActorS=""

    override func viewDidLoad() {
        super.viewDidLoad()
        formatoHeadView()
        addDoneButtonOnKeyboard()
        setFieldsText()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //hideProgress()
        switch tipo_actor {
        case 1:
            ComentsLbl.text="¿Qué quieres donar?"
            tipoActorS="donador"
        case 2:
            ComentsLbl.text="¿Cómo quieres apoyar?"
            tipoActorS="voluntario"
        case 3:
            ComentsLbl.text="Comentarios y/o dudas"
            tipoActorS="participante"
        default://solicitante o select
            print("No pasa")
        }
        titleLbl.text="Alta de "+tipoActorS
        nombreLbl.text="Nombre del "+tipoActorS
        getActorsList()
    }
    
    @IBAction func guardarClick(_ sender: Any) {
        if !comentsTV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de comentarios no puede quedar vacío." )
            return
        }
        let actor = Actor(nombre: nombreTF.text!,
                          correo: correoTF.text!,
                          telefono: telefonoTF.text!,
                          status: 1,
                          comentarios: comentsTV.text!,
                          user_id: SNId,
                          evento_id: eventoId,
                          tipo_actor: tipo_actor,
                          actor_id: 0)
        print(actor)
        showProgress()
        if update{
            putActor(request:actor)
        }else{
            postActor(request: actor)
        }
    }
    
    func formatoHeadView(){
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setDelegates(){
        telefonoTF.delegate=self
        correoTF.delegate=self
        nombreTF.delegate=self
        comentsTV.delegate=self
    }
    
    func putActor(request: Actor) {
        print("put actor al :;")
        print(actorId)
            let dictionary = request
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/genericos/actores/"+String(actorId)) else {
                print("Error formando url actor")
                self.showCanonAlert(title: "Error", msg: "Error formando URL")
                return
            }
            var request = URLRequest(url: endpoint)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let tksession = UserDefaults.standard.string(forKey: "idToken")
            request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            guard let body = try? encoder.encode(dictionary) else { return }
            print(body)
            request.httpBody = body
            let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
              
                if error != nil {
                    print("Hubo un error 060")
                    self.showCanonAlert(title: "Error", msg: "No se ha actualizado el "+self.tipoActorS+"." + error.debugDescription)
                    return
                }
                let status = (response as! HTTPURLResponse).statusCode
                if status == 200 || status == 201{
                    print(":;;;;;;;STATUS 200 ACTOR :::::")
                    self.showCanonAlert(title: "Ėxito", msg: "Se ha actualizado el "+self.tipoActorS+" correctamente.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.alertFields?.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(":;;;;;;;ERROR STATUS ACTOR :::::")
                    print(String((response as! HTTPURLResponse).statusCode))
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    self.showCanonAlert(title: "Error", msg: "No se ha actualizado el "+self.tipoActorS+"." )
                }
            }
            tarea.resume()
    }
    
    func postActor(request: Actor) {
        print("post actor al :;")
        print(actorId)
            let dictionary = request
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/genericos/actores" ) else {
                print("Error formando url comedor")
                self.showCanonAlert(title: "Error", msg: "Error formando URL")
                return
            }
            var request = URLRequest(url: endpoint)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let tksession = UserDefaults.standard.string(forKey: "idToken")
            request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            guard let body = try? encoder.encode(dictionary) else { return }
        print(body)
            request.httpBody = body
            let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
              
                if error != nil {
                    print("Hubo un error 060")
                    self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el "+self.tipoActorS+"." + error.debugDescription)
                    return
                }
                let status = (response as! HTTPURLResponse).statusCode
                if status == 200 || status == 201{
                    print(":;;;;;;;STATUS 200 Actor :::::")
                    self.showCanonAlert(title: "Ėxito", msg: "Se ha dado de alta el "+self.tipoActorS+" correctamente.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.alertFields?.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(":;;;;;;;ERROR STATUS ACTOR :::::")
                    print(String((response as! HTTPURLResponse).statusCode))
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el "+self.tipoActorS+"." )
                }
            }
            tarea.resume()
    }
    
    func getActorsList() {
        showProgress()
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/genericos/actores")
            
        else {return}
        print("LA URL ESSLLL ::")
        print(apiURL.absoluteString)
        var request = URLRequest(url: apiURL)
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let allData = data else {
                self.hideProgress()
                return
            }
            let responseData = String(data: allData, encoding: String.Encoding.utf8)
            print("RESPONSE Data:::")
            print(responseData)
            self.readJson(data: allData)
           
        }
            work.resume()
    }
    
    private func readJson(data:Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                print("JSONAct is dict")
                print(object)
                self.hideProgress()
            }else if let object = json as? [Any] {
                print("JSONCom is array") //esta es la opcion buena
                print(object)
                print("mi ID Es::")
                print(SNId)
                for x in object{
                    if let object = x as? [String: Any] { //esta deberia ser la buena
                        print(object)
                        if object["user_id"] as? Int ?? 0 == SNId{//es el usuario
                            print(object["user_id"] as? Int ?? 0)
                            print("Actualizar == TRUE")
                            print(object)
                            if object["evento_id"] as? Int ?? 0 == eventoId{//es el evento
                                if object["tipo_actor"] as? Int ?? 0 == tipo_actor{
                                    DispatchQueue.main.async {
                                        self.update=true
                                        self.actorId=object["actor_id"] as? Int ?? 0
                                        self.guardarBtn.setTitle("Actualizar", for: .normal)
                                        //self.nombreTF.text=object["nombre"] as? String ?? "noName"
                                        self.comentsTV.text=object["comentarios"] as? String ?? "noComents"
                                        //self.correoTF.text=object["correo"] as? String ?? "noCorreo"
                                        //let tel = object["telefono"] as? String ?? "noTelefono"
                                        //let tel2 = tel.substring(from: 3)
                                        //self.telefonoTF.text=tel2
                                        self.titleLbl.text="Actualizar "+self.tipoActorS
                                    }
                                }
                            }
                        }
                    }
                }
                self.hideProgress()
            } else {
                self.hideProgress()
                print("JSON is invalid")
            }
        } catch {
            self.hideProgress()
            print("JSON error")
            print(error.localizedDescription)
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideProgress(){
        DispatchQueue.main.async {
            self.view.alpha=1
            self.progress.isHidden=true
            self.progress.stopAnimating()
        }
    }
    
    func showProgress(){
        //DispatchQueue.main.async {
            self.view.alpha=0.5
            self.progress.isHidden=false
            self.progress.startAnimating()
        //}
    }
    
    func setFieldsText(){
        let tel = UserDefaults.standard.string(forKey: "telefono") ?? ""
        let tel2 = tel.substring(from: 3)
        telefonoTF.text=tel2
        correoTF.text=UserDefaults.standard.string(forKey: "email") ?? ""
        nombreTF.text=UserDefaults.standard.string(forKey: "nombre") ?? ""
    }
    
    func showCanonAlert(title:String, msg:String){
        hideProgress()
        DispatchQueue.main.async {
            self.alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
    }
    
    //MARK: KEYBOARD
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
             doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        telefonoTF.inputAccessoryView = doneToolbar
        correoTF.inputAccessoryView = doneToolbar
        comentsTV.inputAccessoryView = doneToolbar
        nombreTF.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        telefonoTF.resignFirstResponder()
        correoTF.resignFirstResponder()
        comentsTV.resignFirstResponder()
        nombreTF.resignFirstResponder()
    }
}


extension Actividades_CrearActor: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change")
        if textField == telefonoTF{
            if textField.text!.count>9 {
                textField.text=textField.text!.substring(to: 9)
            }
        }
        return true
    }
}

extension Actividades_CrearActor: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == comentsTV{
            numCharsLbl.text="\(textView.text.count)/250"
        }
        if textView.text.count>250 {
            textView.text=textView.text.substring(to: 250)
            numCharsLbl.text="\(textView.text.count)/250"
        }
    }
}

struct Actor: Codable {
    var nombre: String?
    var correo: String?
    var telefono: String?
    var status: Int? //null
    var comentarios: String?
    var user_id: Int?
    var evento_id: Int?
    var tipo_actor: Int?
    var actor_id: Int?
}
