//
//  Actividades_CrearVoluntario.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 28/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_CrearVoluntario: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var telefonoTF: UITextField!
    @IBOutlet weak var nombreInvTF: UITextField!
    @IBOutlet weak var telefonoInvTF: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var invsTV: UITableView!
    @IBOutlet weak var guardarBtn: UIButton!
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    @IBOutlet weak var invsTVHeight: NSLayoutConstraint!
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var alertFields : AcceptAlert?
    var azulito=UIColor(named: "azulActivo",in: Bundle(for: Actividades_CrearComedor.self), compatibleWith: nil)
    var comedorId = 0
    var update=false
    var voluntarioId=""
    var arrInvs:[Invitado]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatoHeadView()
        addDoneButtonOnKeyboard()
        setFieldsText()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getInfoVol()
    }
    
    func getInfoVol() {
        showProgress()
        //let idUser = defaults.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/comedores/"+String(comedorId)+"?participantes=VOLUNTARIOS")
            
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
            print(responseData)
            self.readJsonCom(data: allData)
           
        }
            work.resume()
    }
    
    private func readJsonCom(data:Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                print("JSONCom is dict")
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
                        if object["FIUSERID"] as? Int ?? 0 == SNId{
                            print(object["FIUSERID"] as? Int ?? 0)
                            print("Actualizar == TRUE")
                            print(object)
                            var multiUser : [Invitado] = []
                            let invs: [[String:Any]] = object["FCMULTIUSER"] as! [[String:Any]]
                            for v in invs {
                                let n = v["nombre"] as? String ?? "noName"
                                let tel = v["telefono"] as? String ?? "noPhone"
                                multiUser.append(Invitado(nombre: n, telefono: tel))
                            }
                            arrInvs=multiUser
                            DispatchQueue.main.async {
                                self.update=true
                                self.voluntarioId=object["FIVOLUNTARIOID"] as? String ?? "0"
                                self.guardarBtn.setTitle("Actualizar", for: .normal)
                                self.nombreTF.text=object["FCVOLUNTARIO"] as? String ?? ""
                                self.correoTF.text=object["FCCORREO"] as? String ?? ""
                                let tel = object["FCTELEFONO"] as? String ?? ""
                                let tel2 = tel.substring(from: 3)
                                self.telefonoTF.text=tel2
                                self.invsTV.reloadData()
                                //self.createLbl.text="Actualizar mi comedor "
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
    
    @IBAction func guardarClick(_ sender: Any) {
        //validacion de campos
        if !nombreTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El nombre del voluntario no puede quedar vacío." )
            return
        }
        if !telefonoTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono no puede quedar vacío." )
            return
        }
        if telefonoTF.text!.count>10 || telefonoTF.text!.count<10 {
            showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono debe tener 10 caracteres.")
            return
        }
        
        if !correoTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de correo no puede quedar vacío." )
            return
        }
        if !correoTF.text!.contains("@"){
            showCanonAlert(title: "Datos faltantes", msg: "Ingresa un correo válido." )
            return
        }
      
        let vol = Voluntario(id: 0, correo: correoTF.text, comedor_id: comedorId, voluntario: nombreTF.text, telefono: "+52"+telefonoTF.text!, multiuser: arrInvs, user_id: SNId, responsable: String(comedorId), nombre_comedor: String(comedorId), direccion:"empty")
        //print(don)
        showProgress()
        if update{
            print("update true")
            putVoluntario(request:vol)
        }else{
            postVoluntario(request: vol)
        }
    }
    
    func putVoluntario(request: Voluntario) {
        print("put voluntario al :;")
        print(request.comedor_id)
            let dictionary = request
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/voluntario/"+voluntarioId) else {
                print("Error formando url comedor")
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
                    self.showCanonAlert(title: "Error", msg: "No se ha actualizado el voluntario." + error.debugDescription)
                    return
                }
                let status = (response as! HTTPURLResponse).statusCode
                if status == 200 || status == 201{
                    print(":;;;;;;;STATUS 200 Voluntario :::::")
                    self.showCanonAlert(title: "Ėxito", msg: "Se ha actualizado el voluntario correctamente.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.alertFields?.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(":;;;;;;;ERROR STATUS Voluntario :::::")
                    print(String((response as! HTTPURLResponse).statusCode))
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    self.showCanonAlert(title: "Error", msg: "No se ha actualizado el voluntario." )
                }
            }
            tarea.resume()
    }
    
    func postVoluntario(request: Voluntario) {
        print("post voluntario al :;")
        print(request.comedor_id)
            let dictionary = request
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/voluntario" ) else {
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
                    self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el voluntario." + error.debugDescription)
                    return
                }
                let status = (response as! HTTPURLResponse).statusCode
                if status == 200 || status == 201{
                    print(":;;;;;;;STATUS 200 Voluntario :::::")
                    self.showCanonAlert(title: "Ėxito", msg: "Se ha dado de alta el voluntario correctamente.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.alertFields?.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(":;;;;;;;ERROR STATUS Voluntario :::::")
                    print(String((response as! HTTPURLResponse).statusCode))
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el voluntario." )
                }
            }
            tarea.resume()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addClick(_ sender: Any) {
        if !nombreInvTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El nombre del invitado no puede quedar vacío." )
            return
        }
        if !telefonoInvTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El teléfono del invitado no puede quedar vacío." )
            return
        }
        if telefonoInvTF.text!.count>10 || telefonoInvTF.text!.count<10{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono debe tener 10 caracteres." )
            return
        }
        arrInvs.append(Invitado(nombre: nombreInvTF.text!, telefono: "+52"+telefonoInvTF.text!))
        invsTV.reloadData()
        nombreInvTF.text=""
        telefonoInvTF.text=""
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
        invsTV.delegate=self
        invsTV.dataSource=self
    }
    //aqui nos quedamos
    func setFieldsText(){
        let tel = UserDefaults.standard.string(forKey: "telefono") ?? ""
        let tel2 = tel.substring(from: 3)
        telefonoTF.text=tel
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
    
    func hideProgress(){
        DispatchQueue.main.async {
            self.view.alpha=1
            self.progress.isHidden=true
            self.progress.stopAnimating()
        }
    }
    
    func showProgress(){
        DispatchQueue.main.async {
            self.view.alpha=0.5
            self.progress.isHidden=false
            self.progress.startAnimating()
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
        nombreTF.inputAccessoryView = doneToolbar
        nombreInvTF.inputAccessoryView = doneToolbar
        telefonoInvTF.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        telefonoTF.resignFirstResponder()
        correoTF.resignFirstResponder()
        nombreTF.resignFirstResponder()
        nombreInvTF.resignFirstResponder()
        telefonoInvTF.resignFirstResponder()
    }

}

extension Actividades_CrearVoluntario: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noris = 0
        noris = arrInvs.count  //saintOfDay.count + realesesP
        print(":::NORIS INV:::"+String(noris))
        invsTVHeight.constant=CGFloat(100*noris)
        return noris
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "INVCELL", for: indexPath) as! VoluntariosTVC
        cell.selectionStyle = .none
       
        if indexPath.row >= arrInvs.startIndex && indexPath.row < arrInvs.endIndex {
                print(":::SETUPP Comedores::: ")
                print(String(indexPath.row))
            cell.setInvitado(data: arrInvs[indexPath.row], i:indexPath.row)
            cell.delegate=self
        }else{
            print("ERROR INDEX PATH: "+String(indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
    
}

extension Actividades_CrearVoluntario:InvitadosCellDelegate{
    func delete(sender:Int) {
        print("recibio accion delete")
        arrInvs.remove(at: sender)
        invsTV.reloadData()
    }
}

extension Actividades_CrearVoluntario: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change")
        if textField == telefonoTF || textField == telefonoInvTF{
            if textField.text!.count>9 {
                textField.text=textField.text!.substring(to: 9)
            }
        }
        return true
    }
}

struct Voluntario: Codable {
    var id: Int? //null
    var correo: String?
    var comedor_id: Int?
    var voluntario: String?
    var telefono: String?
    var multiuser: [Invitado]?
    var user_id: Int?
    var responsable: String?
    var nombre_comedor: String?
    var direccion:String?
}

struct Invitado: Codable {
    var nombre: String?
    var telefono: String?
}
//CURL POST vountario
/*  {
 "responsable": "responsable de comedor 3",
 "direccion": "mi cassirri 098789",
 "nombre_comedor": "10",
 "voluntario": "Nombre del voluntario",
 "telefono": "+525526847904",
 "multiuser": [
     {
         "nombre": "Nombre de invitado 1",
         "telefono": "+525526847904"
     },
     {
         "nombre": "Nombre de invitado 2",
         "telefono": "+525526847905"
     }
     ],
 "correo": "correo@correo.com",
 "user_id": 1
}*/

