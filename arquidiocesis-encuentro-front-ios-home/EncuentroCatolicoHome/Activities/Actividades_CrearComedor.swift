//
//  Actividades_CrearComedor.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 09/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_CrearComedor: UIViewController {
    
    @IBOutlet weak var viewProgress: UIView!
    @IBOutlet weak var progressLoad: UIActivityIndicatorView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var updateLocationSV: UIStackView!
    @IBOutlet weak var locationTV: UITextView!
    
    @IBOutlet weak var switchV: UISwitch!
    
    @IBOutlet weak var switchPrice: UISwitch!
    @IBOutlet weak var swichStatus: UISwitch!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var LuV: UIView!
    @IBOutlet weak var MaV: UIView!
    @IBOutlet weak var MiV: UIView!
    @IBOutlet weak var JuV: UIView!
    @IBOutlet weak var ViV: UIView!
    @IBOutlet weak var SaV: UIView!
    @IBOutlet weak var DoV: UIView!
    
    @IBOutlet weak var luLbl: UILabel!
    @IBOutlet weak var maLbl: UILabel!
    @IBOutlet weak var miLbl: UILabel!
    @IBOutlet weak var juLbl: UILabel!
    @IBOutlet weak var viLbl: UILabel!
    @IBOutlet weak var saLbl: UILabel!
    @IBOutlet weak var doLbl: UILabel!
    
    @IBOutlet weak var openPV: UIPickerView!
    @IBOutlet weak var closePV: UIPickerView!
    
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var telefonoTf: UITextField!
    @IBOutlet weak var precioTF: UITextField!
    @IBOutlet weak var nombreTF: UITextField!
    @IBOutlet weak var responsableTF: UITextField!
    
    @IBOutlet weak var charsLbl: UILabel!
    @IBOutlet weak var requisitosTV: UITextView!
    @IBOutlet weak var btnGuardar: UIButton!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var alertFields : AcceptAlert?
    var azulito=UIColor(named: "azulActivo",in: Bundle(for: Actividades_CrearComedor.self), compatibleWith: nil)
    var luBool=false
    var maBool=false
    var miBool=false
    var juBool=false
    var viBool=false
    var saBool=false
    var doBool=false
    var voluntariosG=0
    var openHour=""
    var closeHour=""
    var statusG=1
    let arrOpen=["00:00","01:00","02:00","03:00","04:00","05:00","06:00",
                 "07:00","08:00","09:00","10:00","11:00","12:00",
                 "13:00","14:00","15:00","16:00","17:00","18:00",
                 "19:00","20:00","21:00","22:00","23:00"]
    let mapaIdZonas = ["Álvaro Obregón":10, "Azcapotzalco":2, "Benito Juárez":14, "Coyoacán":3, "Cuajimalpa de Morelos":4, "Cuauhtémoc":15, "Gustavo A. Madero":5, "Iztacalco":6, "Iztapalapa":7, "La Magdalena Contreras":8, "Miguel Hidalgo":16, "Milpa Alta":9, "Tláhuac":11, "Tlalpan":12, "Venustiano Carranza":17, "Xochimilco":13]
    let defaults=UserDefaults.standard
    var update = false
    var comedorId = "00"

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "map" {
            let vc = segue.destination as! CrearComedor_Mapa
            //vc.deliveryId = sender as? String
        }
    }
    
    @IBAction func switchPriceClick(_ sender: Any) {
            precioTF.isHidden = !switchPrice.isOn
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestures()
        formatoDaysViews()
        formatoHeadView()
        addDoneButtonOnKeyboard()
        setFieldsText()
        setDelegates()
        if update{
            viewProgress.isHidden=false
            progressLoad.startAnimating()
            titleLbl.text="Actualizar comedor"
            getInfoCom()
        }
    }
    
    func getInfoCom() {
        //let idUser = defaults.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/comedores/"+comedorId) else { return }
        var request = URLRequest(url: apiURL)
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let allData = data else { return }
            let responseData = String(data: allData, encoding: String.Encoding.utf8)
            print("Comedor:: "+self.comedorId)
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
                self.hideProgress()
            }else if let object = json as? [Any] {
                print("JSONCom is array") //esta es la opcion buena
                self.getData(rD: object)
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
    
    func getData(rD:Array<Any>){
            if let object = rD.first as? [String: Any] {
                var dias : [Dia] = []
                if let arr2 = object["FCHORARIOS"] as? [[String:Any]],
                   let hora = arr2.first {
                    openHour = hora["hour_start"] as? String ?? "00:02"
                    closeHour = hora["hour_end"] as? String ?? "00:02"
                        if let dias2 = hora["days"] as? [[String:Any]]{
                            if dias2[0]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 1, name: "Domingo", checked: true))
                            }
                            if dias2[1]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 2, name: "Lunes", checked: true))
                            }
                            if dias2[2]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 3, name: "Martes", checked: true))
                            }
                            if dias2[3]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 4, name: "Miércoles", checked: true))
                            }
                            if dias2[4]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 5, name: "Jueves", checked: true))
                            }
                            if dias2[5]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 6, name: "Viernes", checked: true))
                            }
                            if dias2[6]["checked"] as? Int ?? 3 == 1 {
                                dias.append(Dia(id: 7, name: "Sábado", checked: true))
                            }
                        }else{
                            print("dias ok NO")
                        }
                    }else{
                        print("no se pudo castear")
                    }
    
                let c = Comedor(horarios: [Horario(days: dias, hour_start: openHour,hour_end: closeHour)],
                                 correo: object["FCCORREO"] as? String ?? "sinCorreo",
                                 telefono: object["FCTELEFONO"]  as? String ?? "sinTelefono",
                                 direccion: object["FCDIRECCION"]  as? String ?? "sinDireccion",
                                 cobro: object["FCCOBRO"] as? Int ?? 0,
                                 requisitos: object["FCREQUISITOS"]  as? String ?? "sinRequisitos",
                                 voluntarios: object["FCVOLUNTARIOS"] as? Int ?? 0,
                                 donantes: [0],
                                 zona: object["FIZONA"] as? Int ?? 0,
                                 status: object["FCSTATUS"] as? Int ?? 0,
                                 longitud: object["FNLONGITUD"] as? Double ?? 0.0,
                                 latitud: object["FNLATITUD"] as? Double ?? 0.0,
                                 nombre: object["FCNOMBRECOM"]  as? String ?? "sinNombre",
                                 responsable: object["FCRESPONSABLE"]  as? String ?? "sinResponsable",
                                 user_id: object["FIUSERID"]  as? String ?? "nouserId")
                setupData(c:c)
            } else {
                print("JSON2 is invalid")
                self.hideProgress()
            }
    }
    
    func hideProgress(){
        DispatchQueue.main.async {
            self.viewProgress.isHidden=true
            self.progressLoad.stopAnimating()
        }
    }
    
    func setupData(c:Comedor){
        DispatchQueue.main.async {
            self.responsableTF.text=c.responsable
            self.correoTF.text=c.correo
            self.telefonoTf.text=c.telefono
            self.locationTV.text=c.direccion
            self.requisitosTV.text=c.requisitos
            self.charsLbl.text="\(self.requisitosTV.text.count)/250"
            self.switchPrice.setOn(c.cobro>0, animated: true)
            self.precioTF.isHidden = c.cobro==0
            self.precioTF.text=String(c.cobro)
            self.nombreTF.text=c.nombre
            self.switchV.setOn(c.voluntarios==1, animated: true)
            self.swichStatus.setOn(c.status==1, animated: true)
            //self.myPickerView.selectRow(0, inComponent: 0, animated: false)
            //self.pickerView(self.myPickerView, didSelectRow: 0, inComponent: 0)
            self.openPV.selectRow(self.arrOpen.firstIndex(of: c.horarios[0].hour_start) ?? 0, inComponent: 0, animated: true)
            self.closePV.selectRow(self.arrOpen.firstIndex(of: c.horarios[0].hour_end) ?? 0, inComponent: 0, animated: true)
            for day in c.horarios[0].days {//ya son todos llos true
                switch day.id{
                case 1 :
                    self.doBool = true
                    self.formatoDaysActive(txt: self.doLbl, view: self.DoV, bool: self.doBool)
                case 2 :
                    self.luBool = true
                    self.formatoDaysActive(txt: self.luLbl, view: self.LuV, bool: self.luBool)
                case 3 :
                    self.maBool = true
                    self.formatoDaysActive(txt: self.maLbl, view: self.MaV, bool: self.maBool)
                case 4 :
                    self.miBool = true
                    self.formatoDaysActive(txt: self.miLbl, view: self.MiV, bool: self.miBool)
                case 5 :
                    self.juBool = true
                    self.formatoDaysActive(txt: self.juLbl, view: self.JuV, bool: self.juBool)
                case 6 :
                    self.viBool = true
                    self.formatoDaysActive(txt: self.viLbl, view: self.ViV, bool: self.viBool)
                case 7 :
                    self.saBool = true
                    self.formatoDaysActive(txt: self.saLbl, view: self.SaV, bool: self.saBool)
                default:
                    print("no pasa")
                }
            }
            self.hideProgress()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let adress = defaults.string(forKey: "lastAdress") ?? "Actualiza la ubicación de tu comedor en el mapa para obtener la dirección."
        locationTV.text=adress
        progress.isHidden=true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.charsLbl.text="\(self.requisitosTV.text.count)/250"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //UserDefaults.standard.removeObject(forKey: "lastAdress")
        //UserDefaults.standard.removeObject(forKey: "latitude")
        //UserDefaults.standard.removeObject(forKey: "longitude")
    }
    
    func setFieldsText(){
        telefonoTf.text=UserDefaults.standard.string(forKey: "telefono") ?? ""
        correoTF.text=UserDefaults.standard.string(forKey: "email") ?? ""
    }
    
    @IBAction func guardarClick(_ sender: Any) {
        progress.isHidden=false
        progress.startAnimating()
        //validacion de campos
        if !nombreTF.hasText{
            self.showCanonAlert(title: "Datos faltantes", msg: "El nombre del comedor no puede quedar vacío." )
            return
        }
        if !locationTV.hasText{
        //guard let adress = defaults.string(forKey: "lastAdress") else {
            self.showCanonAlert(title: "Datos faltantes", msg: "Actualiza la ubicación de tu comedor." )
            return
        //}
        }else{
            defaults.set(locationTV.text, forKey: "lastAdress")
        }
        
        if !luBool && !maBool && !miBool && !juBool && !viBool && !saBool && !doBool{
            self.showCanonAlert(title: "Datos faltantes", msg: "Activa por lo menos un día a la semana en el que preste servicio tu comedor." )
            return
        }
        if openHour==""{
            self.showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de apertura." )
            return
        }
        if closeHour==""{
            self.showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de cierre." )
            return
        }
        if !responsableTF.hasText{
            self.showCanonAlert(title: "Datos faltantes", msg: "El nombre del responsable no puede quedar vacío." )
            return
        }
        if !correoTF.hasText{
            self.showCanonAlert(title: "Datos faltantes", msg: "El campo de correo no puede quedar vacío." )
            return
        }
        if !telefonoTf.hasText{
            self.showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono no puede quedar vacío." )
            return
        }
        if switchV.isOn{
            voluntariosG=1
        }
        if !swichStatus.isOn{
            statusG=0
        }
        let lat = defaults.double(forKey: "latitude")
        let lon = defaults.double(forKey: "longitude")
        let idZona = defaults.integer(forKey: "idZona")
        var arrDias:[Dia] = []
        arrDias.append(Dia(id: 1, name: "Domingo", checked: doBool))
        arrDias.append(Dia(id: 2, name: "Lunes", checked: luBool))
        arrDias.append(Dia(id: 3, name: "Martes", checked: maBool))
        arrDias.append(Dia(id: 4, name: "Miércoles", checked: miBool))
        arrDias.append(Dia(id: 5, name: "Jueves", checked: juBool))
        arrDias.append(Dia(id: 6, name: "Viernes", checked: viBool))
        arrDias.append(Dia(id: 7, name: "Sábado", checked: saBool))
        let horario = Horario(days: arrDias, hour_start: openHour, hour_end: closeHour)
        let price = Int(precioTF.text ?? "0") ?? 0
        let comedor = Comedor(horarios: [horario], correo: correoTF.text!, telefono: telefonoTf.text!, direccion: locationTV.text, cobro: price, requisitos: requisitosTV.text, voluntarios: voluntariosG, donantes: [], zona: idZona, status: statusG, longitud: lon, latitud: lat, nombre: nombreTF.text!, responsable: responsableTF.text!, user_id: String(SNId))
        if update{
            putComedor(request: comedor)
        }else{
            postComedor(request: comedor)
            
        }
    }
    
    func putComedor(request: Comedor) {
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/comedores/"+comedorId ) else {
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
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
          
            if error != nil {
                print("Hubo un error")
                self.showCanonAlert(title: "Error", msg: "No se ha actualizado la información del comedor correctamente." + error.debugDescription)
                return
            }
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200 {
                print(":;;;;;;;STATUS 200 PUT Comedor :::::")
                print(endpoint.absoluteString)
                print(status)
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Ėxito", msg: "Se ha actualizado la información del comedor.")
            }else{
                print(":;;;;;;;ERROR STATUS COmEDORRR :::::")
                print(String((response as! HTTPURLResponse).statusCode))
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Error", msg: "No se ha actualizado la información del comedor." )
            }
        }
        tarea.resume()
    }
    
    func postComedor(request: Comedor) {
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/comedores" ) else {
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
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
          
            if error != nil {
                print("Hubo un error")
                self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el comedor correctamente." + error.debugDescription)
                return
            }
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200 || status == 201{
                print(":;;;;;;;STATUS 200 Comedor :::::")
                self.showCanonAlert(title: "Ėxito", msg: "Se ha dado de alta el comedor correctamente.")
            }else{
                print(":;;;;;;;ERROR STATUS SACERRRRR :::::")
                print(String((response as! HTTPURLResponse).statusCode))
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Error", msg: "No se ha dado de alta el comedor correctamente." )
            }
        }
        tarea.resume()
    }
    
    func addTapGestures(){
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TF1))
        updateLocationSV.addGestureRecognizer(tapG1)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFLu))
        LuV.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFMa))
        MaV.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFMi))
        MiV.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFJu))
        JuV.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFVi))
        ViV.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFSa))
        SaV.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFDo))
        DoV.addGestureRecognizer(tap7)
            
    }
    
    @objc func TF1(gesture: UIGestureRecognizer) {
        print("Actualizar direccion click")
        performSegue(withIdentifier: "map", sender: nil)
    }
    
    @objc func TFLu(gesture: UIGestureRecognizer) {
        luBool = !luBool
        formatoDaysActive(txt: luLbl, view: LuV, bool: luBool)
    }
    @objc func TFMa(gesture: UIGestureRecognizer) {
        maBool = !maBool
        formatoDaysActive(txt: maLbl, view: MaV, bool: maBool)
    }
    @objc func TFMi(gesture: UIGestureRecognizer) {
        miBool = !miBool
        formatoDaysActive(txt: miLbl, view: MiV, bool: miBool)
    }
    @objc func TFJu(gesture: UIGestureRecognizer) {
        juBool = !juBool
        formatoDaysActive(txt: juLbl, view: JuV, bool: juBool)
    }
    @objc func TFVi(gesture: UIGestureRecognizer) {
        viBool = !viBool
        formatoDaysActive(txt: viLbl, view: ViV, bool: viBool)
    }
    @objc func TFSa(gesture: UIGestureRecognizer) {
        saBool = !saBool
        formatoDaysActive(txt: saLbl, view: SaV, bool: saBool)
    }
    @objc func TFDo(gesture: UIGestureRecognizer) {
        doBool = !doBool
        formatoDaysActive(txt: doLbl, view: DoV, bool: doBool)
    }
    
    func showCanonAlert(title:String, msg:String){
        DispatchQueue.main.async {
            self.progress.stopAnimating()
            self.progress.isHidden=true
            self.alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
    }
 
    func formatoDaysActive(txt:UILabel, view:UIView, bool:Bool){
        if bool {
            txt.textColor=azulito
            view.layer.shadowColor = azulito?.cgColor
        }else{
            txt.textColor = .gray
            view.layer.shadowColor = UIColor.gray.cgColor
        }
    }
    
    func formatoDaysViews(){
        LuV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        MaV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        MiV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        JuV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        ViV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        SaV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        DoV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        LuV.layer.cornerRadius = 5
        MaV.layer.cornerRadius = 5
        MiV.layer.cornerRadius = 5
        JuV.layer.cornerRadius = 5
        ViV.layer.cornerRadius = 5
        SaV.layer.cornerRadius = 5
        DoV.layer.cornerRadius = 5

        LuV.layer.shadowRadius = 4
        MaV.layer.shadowRadius = 4
        MiV.layer.shadowRadius = 4
        JuV.layer.shadowRadius = 4
        ViV.layer.shadowRadius = 4
        SaV.layer.shadowRadius = 4
        DoV.layer.shadowRadius = 4
        
        LuV.layer.shadowOpacity = 0.5
        MaV.layer.shadowOpacity = 0.5
        MiV.layer.shadowOpacity = 0.5
        JuV.layer.shadowOpacity = 0.5
        ViV.layer.shadowOpacity = 0.5
        SaV.layer.shadowOpacity = 0.5
        DoV.layer.shadowOpacity = 0.5
        
        LuV.layer.shadowColor = UIColor.gray.cgColor
        MaV.layer.shadowColor = UIColor.gray.cgColor
        MiV.layer.shadowColor = UIColor.gray.cgColor
        JuV.layer.shadowColor = UIColor.gray.cgColor
        ViV.layer.shadowColor = UIColor.gray.cgColor
        SaV.layer.shadowColor = UIColor.gray.cgColor
        DoV.layer.shadowColor = UIColor.gray.cgColor
        
        LuV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        MaV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        MiV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        JuV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        ViV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        SaV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        DoV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func formatoHeadView(){
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setDelegates(){
        openPV.delegate=self
        openPV.dataSource=self
        closePV.delegate=self
        closePV.dataSource=self
        precioTF.delegate=self
        telefonoTf.delegate=self
        correoTF.delegate=self
        nombreTF.delegate=self
        responsableTF.delegate=self
        requisitosTV.delegate=self
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
        telefonoTf.inputAccessoryView = doneToolbar
        precioTF.inputAccessoryView = doneToolbar
        requisitosTV.inputAccessoryView = doneToolbar
        locationTV.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        telefonoTf.resignFirstResponder()
        precioTF.resignFirstResponder()
        requisitosTV.resignFirstResponder()
        locationTV.resignFirstResponder()
    }
    

}

extension Actividades_CrearComedor: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
        case openPV:
            count = arrOpen.count
        case closePV:
            count = arrOpen.count
        default:
            break
        }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case openPV:
            return arrOpen[row]
        case closePV:
            return arrOpen[row]
        default:
            return arrOpen[row]
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case openPV:
            openHour=arrOpen[row]
            print("selecciono open")
        case closePV:
            print("selecciono close")
            closeHour=arrOpen[row]
        default:
            print("selecciono otro")
        }
    }
    
}

//MARK: - TextField Delegate Implementation
extension Actividades_CrearComedor: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.nextTextField(textField)
        return true
    }
}

extension Actividades_CrearComedor: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == requisitosTV{
            //print(textView.text)
            charsLbl.text="\(textView.text.count)/250"
           
        }
        if textView.text.count>250 {
            textView.text=textView.text.substring(to: 250)
            charsLbl.text="\(textView.text.count)/250"
        }
    }
}

struct Comedor: Codable {
    var horarios: [Horario]
    var correo: String
    var telefono: String //+52
    var direccion: String
    var cobro: Int
    var requisitos: String
    var voluntarios: Int
    var donantes: [Int]
    var zona: Int
    var status: Int//1,0
    var longitud: Double
    var latitud: Double
    var nombre : String
    var responsable: String
    var user_id:String
}

struct Horario: Codable {
    var days: [Dia]
    var hour_start: String
    var hour_end: String
}

struct Dia: Codable {
    var id: Int
    var name: String
    var checked: Bool
}

