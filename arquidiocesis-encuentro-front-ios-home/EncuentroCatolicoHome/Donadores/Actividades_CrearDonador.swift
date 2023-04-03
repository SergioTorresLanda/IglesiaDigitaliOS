//
//  Actividades_CrearDonador.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 27/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_CrearDonador: UIViewController {
    
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var comentsTV: UITextView!
    @IBOutlet weak var tipoDonacionPV: UIPickerView!
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
    var comedorId = 0
    var tipoDonacion = "En especie"
    let arrTipos = ["En especie"]
    var update=false
    var donadorId=""

    override func viewDidLoad() {
        super.viewDidLoad()
        formatoHeadView()
        addDoneButtonOnKeyboard()
        setFieldsText()
        setDelegates()
        getInfoCom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //hideProgress()
    }
    
    @IBAction func guardarClick(_ sender: Any) {
        //validacion de campos
        if !nombreTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El nombre del donador no puede quedar vacío." )
            return
        }
        if !comentsTV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de comentarios no puede quedar vacío." )
            return
        }
        if !telefonoTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono no puede quedar vacío." )
            return
        }
        if telefonoTF.text!.count>10 || telefonoTF.text!.count<10{
            showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono debe tener 13 caracteres." )
            return
        }
      
        let don = Donador(id: 0, bancarios: "datos bancarios", comentarios: comentsTV.text, correo: correoTF.text!, comedor_id:comedorId, nombre: nombreTF.text!, telefono:"+52"+telefonoTF.text!, tipo_don: tipoDonacion, user_id: SNId)
        print(don)
        showProgress()
        if update{
            putDonante(request:don)
        }else{
            postDonante(request: don)
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
        tipoDonacionPV.delegate=self
        tipoDonacionPV.dataSource=self
        telefonoTF.delegate=self
        correoTF.delegate=self
        nombreTF.delegate=self
        comentsTV.delegate=self
    }
    
    func putDonante(request: Donador) {
        print("put donante al :;")
        print(donadorId)
            let dictionary = request
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/donadores/"+donadorId) else {
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
                    self.showCanonAlert(title: "Error", msg: "No se ha actualizado el donador." + error.debugDescription)
                    return
                }
                let status = (response as! HTTPURLResponse).statusCode
                if status == 200 || status == 201{
                    print(":;;;;;;;STATUS 200 Donante :::::")
                    self.showCanonAlert(title: "Ėxito", msg: "Se ha actualizado el donador correctamente.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.alertFields?.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(":;;;;;;;ERROR STATUS DONANTE :::::")
                    print(String((response as! HTTPURLResponse).statusCode))
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    self.showCanonAlert(title: "Error", msg: "No se ha actualizado el donador." )
                }
            }
            tarea.resume()
    }
    
    func postDonante(request: Donador) {
        print("post donante al :;")
        print(request.comedor_id)
            let dictionary = request
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/donadores" ) else {
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
                    self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el donador." + error.debugDescription)
                    return
                }
                let status = (response as! HTTPURLResponse).statusCode
                if status == 200 || status == 201{
                    print(":;;;;;;;STATUS 200 Donante :::::")
                    self.showCanonAlert(title: "Ėxito", msg: "Se ha dado de alta el donador correctamente.")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                        self.alertFields?.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    })
                }else{
                    print(":;;;;;;;ERROR STATUS DONANTE :::::")
                    print(String((response as! HTTPURLResponse).statusCode))
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el donador." )
                }
            }
            tarea.resume()
    }
    
    func getInfoCom() {
        showProgress()
        //let idUser = defaults.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/comedores/"+String(comedorId)+"?participantes=DONADORES")
            
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
            //let responseData = String(data: allData, encoding: String.Encoding.utf8)
            //print(responseData)
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
                            DispatchQueue.main.async {
                                self.update=true
                                self.donadorId=object["FIDONANTEID"] as? String ?? "0"
                                self.guardarBtn.setTitle("Actualizar", for: .normal)
                                self.nombreTF.text=object["FCNOMBRE"] as? String ?? ""
                                self.comentsTV.text=object["FCCOMENTARIOS"] as? String ?? ""
                                self.correoTF.text=object["FCCORREO"] as? String ?? ""
                                let tel = object["FCTELEFONO"] as? String ?? ""
                                let tel2 = tel.substring(from: 3)
                                self.telefonoTF.text=tel2
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
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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

extension Actividades_CrearDonador: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
        case tipoDonacionPV:
            count = arrTipos.count
        default:
            break
        }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case tipoDonacionPV:
            return arrTipos[row]
        default:
            return arrTipos[row]
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case tipoDonacionPV:
            tipoDonacion=arrTipos[row]
        default:
            print("selecciono otro")
        }
    }
    
}

extension Actividades_CrearDonador: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.nextTextField(textField)
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

extension Actividades_CrearDonador: UITextViewDelegate {
    
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

struct Donador: Codable {
    var id: Int? //null
    var bancarios: String? // ""
    var comentarios: String?
    var correo: String?
    var comedor_id: Int?
    var nombre: String?
    var telefono: String?
    var tipo_don: String?
    var user_id: Int?
}
