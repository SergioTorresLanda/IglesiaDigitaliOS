//
//  Actividades_CrearModulo.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 24/05/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_CrearModulo: UIViewController {

    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var guardarBtn: UIButton!
    @IBOutlet weak var listaBtn: UIButton!
    @IBOutlet weak var nombreActividadTF: UITextField!
    @IBOutlet weak var direccionTV: UITextView!
    @IBOutlet weak var actualizarDireccionSV: UIStackView!
    @IBOutlet weak var Lu: UIView!
    @IBOutlet weak var Ma: UIView!
    @IBOutlet weak var Mi: UIView!
    @IBOutlet weak var Ju: UIView!
    @IBOutlet weak var Vi: UIView!
    @IBOutlet weak var Sa: UIView!
    @IBOutlet weak var Do: UIView!
    
    @IBOutlet weak var LuLbl: UILabel!
    @IBOutlet weak var ViLbl: UILabel!
    @IBOutlet weak var MaLbl: UILabel!
    @IBOutlet weak var DoLbl: UILabel!
    @IBOutlet weak var SaLbl: UILabel!
    @IBOutlet weak var MiLbl: UILabel!
    @IBOutlet weak var JuLbl: UILabel!
    
    @IBOutlet weak var horaIniPV: UIPickerView!
    @IBOutlet weak var horaFinPV: UIPickerView!
    
    @IBOutlet weak var tipoPV: UIPickerView!
    
    @IBOutlet weak var telefonoTF: UITextField!
    @IBOutlet weak var responsableTF: UITextField!
    @IBOutlet weak var correoTF: UITextField!
    
    @IBOutlet weak var voluntariosSwitch: UISwitch!
    @IBOutlet weak var precioTF: UITextField!
    @IBOutlet weak var costoSwitch: UISwitch!
    @IBOutlet weak var precioSV: UIStackView!
    
    @IBOutlet weak var estatusSwitch: UISwitch!
    @IBOutlet weak var publicoTV: UITextView!
    
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var donativoSwitch: UISwitch!
    @IBOutlet weak var publicoCountLbl: UILabel!
    
    @IBOutlet weak var donativoSV: UIStackView!
    @IBOutlet weak var donativoTV: UITextView!
    
    @IBOutlet weak var descCountLbl: UILabel!
    @IBOutlet weak var volunsCountLbl: UILabel!
    @IBOutlet weak var volunsSV: UIStackView!
    @IBOutlet weak var voluntariosSV: UITextView!
    @IBOutlet weak var donativoCountLbl: UILabel!
    
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
    var donadoresG=0
    var openHour=""
    var closeHour=""
    var statusG=1
    let arrOpen=["00:00","01:00","02:00","03:00","04:00","05:00","06:00",
                 "07:00","08:00","09:00","10:00","11:00","12:00",
                 "13:00","14:00","15:00","16:00","17:00","18:00",
                 "19:00","20:00","21:00","22:00","23:00"]
    let arrType=[ "--Seleccionar--",
                  "Educación",
                  "Misiones",
                  "Retiros",
                  "Cursos",
                  "Encuentros",
                  "Pláticas",
                  "Adoración Nocturna"]
    let mapaIdZonas = ["Álvaro Obregón":10, "Azcapotzalco":2, "Benito Juárez":14, "Coyoacán":3, "Cuajimalpa de Morelos":4, "Cuauhtémoc":15, "Gustavo A. Madero":5, "Iztacalco":6, "Iztapalapa":7, "La Magdalena Contreras":8, "Miguel Hidalgo":16, "Milpa Alta":9, "Tláhuac":11, "Tlalpan":12, "Venustiano Carranza":17, "Xochimilco":13]
    let defaults=UserDefaults.standard
    var update = false
    var eventoId = 0
    var tipoEvento = 0
    var tipoEventoNew = 0
    var c:ActividadGenerica?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapa" {
            let vc = segue.destination as! CrearComedor_Mapa
            vc.type = "otro"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestures()
        preFormatoDaysViews()
        formatoHeadView()
        addDoneButtonOnKeyboard()
        setFieldsText()
        setDelegates()
        if update{
            //titleLbl.text="Actualizar actividad"
            setupData()
        }else{
            listaBtn.isHidden=true
        }
    }
    
    func setupData(){
        estatusSwitch.setOn(c!.status==1, animated: true)
        print("tipo:;")
        print(String(c!.tipoEvento))
        print("::tipoEvento")
        print(tipoEvento)
        tipoEventoNew=tipoEvento
        tipoPV.selectRow(c!.tipoEvento, inComponent: 0, animated: false)
        nombreActividadTF.text=c!.nombre
        direccionTV.text=c!.direccion
        
        horaIniPV.selectRow(arrOpen.firstIndex(of: c!.horarios[0].hour_start) ?? 0, inComponent: 0, animated: true)
        horaFinPV.selectRow(arrOpen.firstIndex(of: c!.horarios[0].hour_end) ?? 0, inComponent: 0, animated: true)
        openHour=c!.horarios[0].hour_start
        closeHour=c!.horarios[0].hour_end

        responsableTF.text=c!.responsable
        correoTF.text=c!.correo
        telefonoTF.text=c!.telefono
        precioSV.isHidden = c!.cobro==0
        costoSwitch.setOn(c!.cobro>0, animated: true)
        precioTF.text=String(c!.cobro)
        descTV.text=c!.descripcion
        descCountLbl.text="\(descTV.text.count)/500"
        publicoTV.text=c?.publico
        publicoCountLbl.text="\(publicoTV.text.count)/500"
        donativoSwitch.setOn(c!.donantesBool==1, animated: true)
        donativoSV.isHidden=c!.donantesBool==0
        voluntariosSwitch.setOn(c!.voluntariosBool==1, animated: true)
        volunsSV.isHidden=c!.voluntariosBool==0
        donativoTV.text=c!.donantesTxt
        donativoCountLbl.text="\(donativoTV.text.count)/500"
        voluntariosSV.text=c?.voluntariosTxt
        volunsCountLbl.text="\(voluntariosSV.text.count)/500"
        
        //self.pickerView(self.myPickerView, didSelectRow: 0, inComponent: 0)
       
        for day in c!.horarios[0].days {
            switch day.id{
            case 1 :
                doBool = true
                formatoDaysActive(txt: DoLbl, view: Do, bool: doBool)
            case 2 :
                luBool = true
                formatoDaysActive(txt: LuLbl, view: Lu, bool: luBool)
            case 3 :
                maBool = true
                formatoDaysActive(txt: MaLbl, view: Ma, bool: maBool)
            case 4 :
                miBool = true
                formatoDaysActive(txt: MiLbl, view: Mi, bool: miBool)
            case 5 :
                juBool = true
                formatoDaysActive(txt: JuLbl, view: Ju, bool: juBool)
            case 6 :
                viBool = true
                formatoDaysActive(txt: ViLbl, view: Vi, bool: viBool)
            case 7 :
                saBool = true
                formatoDaysActive(txt: SaLbl, view: Sa, bool: saBool)
            default:
                print("no pasa")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let adress = defaults.string(forKey: "lastAdressOther") ?? "Actualiza la ubicación de tu actividad en el mapa para obtener la dirección."
        direccionTV.text=adress
        progress.isHidden=true
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func listaClick(_ sender: Any) {
        
    }
    
    
    @IBAction func guardarClick(_ sender: Any) {
        progress.isHidden=false
        progress.startAnimating()
        //validacion de campos
        if tipoEventoNew==0{
            showCanonAlert(title: "Datos faltantes", msg: "Selecciona el tipo de actividad que quieres crear o actualizar." )
            return
        }
        if update && tipoEventoNew != tipoEvento{
            tipoPV.selectRow(c!.tipoEvento, inComponent: 0, animated: false)
            tipoEventoNew=tipoEvento
            showCanonAlert(title: "Atención", msg: "Para cambiar el tipo de actividad, primero debes desactivar la actual, guardar cambios y así podrás crear una nueva actividad de diferente tipo.")
            return
        }
        if !nombreActividadTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El nombre de la actividad no puede quedar vacío." )
            return
        }
        if !direccionTV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "Actualiza la ubicación de tu actividad." )
            return
        }else{
            defaults.set(direccionTV.text, forKey: "lastAdressOther")
        }
        
        if !publicoTV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "Actualiza la información del público al que va dirigida la actividad." )
            return
        }
        if !descTV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "La descripción de la actividad no puede quedar vacía." )
            return
        }
        if !luBool && !maBool && !miBool && !juBool && !viBool && !saBool && !doBool{
            showCanonAlert(title: "Datos faltantes", msg: "Activa por lo menos un día a la semana en el que esté activa tu actividad." )
            return
        }
        if openHour==""{
            showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de apertura para la actividad." )
            return
        }
        if closeHour==""{
            showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de cierre para la actividad." )
            return
        }
   
        if voluntariosSwitch.isOn{
            voluntariosG=1
        }
        if donativoSwitch.isOn{
            donadoresG=1
        }
        if estatusSwitch.isOn{
            statusG=1
        }else{
            statusG=0
        }
        let lat = defaults.double(forKey: "latitudeOther")
        let lon = defaults.double(forKey: "longitudeOther")
        //let idZona = defaults.integer(forKey: "idZona")
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
        let generico = ActividadGenerica(horarios: [horario], responsable: responsableTF.text!, correo: correoTF.text!, telefono: telefonoTF.text!, direccion: direccionTV.text!, cobro: price, descripcion: descTV.text!, publico:publicoTV.text!, voluntariosBool: voluntariosG, donantesBool: donadoresG, voluntariosTxt: voluntariosSV.text ?? "", donantesTxt: donativoTV.text ?? "", status: statusG, nombre: nombreActividadTF.text!, userId: SNId, eventoId:eventoId, tipoEvento: tipoEventoNew)
        {"cobro":0,
            "correo":"priest2@gmail.com",
            "descripcion":"Descripción amplia de la actividad. Todos los informes y detalles que escapen a la información capturada en este formulario.",
            "direccion":"Blvd. Adolfo Ruíz Cortines - Blvd. Cataratas, Jardines del Pedregal de San Ángel, 04500 Ciudad de México, CDMX, México",
            "donantesBool":0,
            "donantesTxt":"None",
            "eventoId":0,
            "horarios":[{"days":[{"checked":false,"id":0,"name":"Domingo"},{"checked":false,"id":1,"name":"Lunes"},{"checked":false,"id":2,"name":"Martes"},{"checked":false,"id":3,"name":"Miércoles"},{"checked":true,"id":4,"name":"Jueves"},{"checked":true,"id":5,"name":"Viernes"},{"checked":true,"id":6,"name":"Sábado"}],"hour_end":"04:13","hour_start":"15:13"}],
            "nombre":"Eduquese Mi Shavo",
            "publico":"Información del público al que va dirigida la actividad y más información relevante propia de la actividad.",
            "responsable":"Priesttwo",
            "status":1,
            "telefono":"5541438458",
            "tipoEvento":1,
            "userId":374,
            "voluntariosBool":0,
            "voluntariosTxt":"None"}
        print("PASO TODO BANDERA")
        if update{
            putGenerico(request: generico)
            print("::PUT::")
            print("act-voluntariado/genericos/\(eventoId)?evento=\(tipoEvento)")
        }else{
            print("POST:::")
            print(generico)
            postGenerico(request: generico)
        }
    }
    
    func postGenerico(request: ActividadGenerica) {
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/genericos?evento="+String(tipoEventoNew) ) else {
            print("Error formando url generico")
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
                print("Hubo un error 060")
                self.showCanonAlert(title: "Error", msg: "No se ha dado de alta la actividad correctamente." + error.debugDescription)
                return
            }
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200 || status == 201{
                print(":;;;;;;;STATUS 200 GENerICO :::::")
                self.showCanonAlert(title: "Ėxito", msg: "Se ha dado de alta la actividad correctamente.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.alertFields?.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                print(":;;;;;;;ERROR STATUS GENERICO :::::")
                print(String((response as! HTTPURLResponse).statusCode))
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Error", msg: "No se ha dado de alta la actividad correctamente." )
            }
        }
        tarea.resume()
    }
    
    func putGenerico(request: ActividadGenerica) {
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/genericos/\(eventoId)?evento=\(tipoEvento)") else {
            print("Error formando url generico")
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
                print("Hubo un error 060")
                self.showCanonAlert(title: "Error", msg: "No se ha actualizado la actividad correctamente." + error.debugDescription)
                return
            }
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200 || status == 201{
                print(":;;;;;;;STATUS 200 GENerICO :::::")
                self.showCanonAlert(title: "Ėxito", msg: "Se ha actualizado la actividad correctamente.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.alertFields?.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                print(":;;;;;;;ERROR STATUS GENERICO :::::")
                print(String((response as! HTTPURLResponse).statusCode))
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Error", msg: "No se ha actualizado la actividad correctamente." )
            }
        }
        tarea.resume()
    }
    
    @IBAction func switchPriceClick(_ sender: Any) {
            precioSV.isHidden = !costoSwitch.isOn
    }
    
    @IBAction func switchDonClick(_ sender: Any) {
            donativoSV.isHidden = !donativoSwitch.isOn
    }
    @IBAction func switchVolClick(_ sender: Any) {
            volunsSV.isHidden = !voluntariosSwitch.isOn
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
    
    func setFieldsText(){
        let tel = UserDefaults.standard.string(forKey: "telefono") ?? ""
        let tel2 = tel.substring(from: 3)
        telefonoTF.text=tel2
        correoTF.text=UserDefaults.standard.string(forKey: "email") ?? ""
        responsableTF.text=UserDefaults.standard.string(forKey: "nombre") ?? ""
    }
    
    func addTapGestures(){
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TF1))
        actualizarDireccionSV.addGestureRecognizer(tapG1)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFLu))
        Lu.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFMa))
        Ma.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFMi))
        Mi.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFJu))
        Ju.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFVi))
        Vi.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFSa))
        Sa.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearComedor.TFDo))
        Do.addGestureRecognizer(tap7)
            
    }
    
    @objc func TF1(gesture: UIGestureRecognizer) {
        print("Actualizar direccion click")
        performSegue(withIdentifier: "mapa", sender: nil)
    }
    
    @objc func TFLu(gesture: UIGestureRecognizer) {
        luBool = !luBool
        formatoDaysActive(txt: LuLbl, view: Lu, bool: luBool)
    }
    @objc func TFMa(gesture: UIGestureRecognizer) {
        maBool = !maBool
        formatoDaysActive(txt: MaLbl, view: Ma, bool: maBool)
    }
    @objc func TFMi(gesture: UIGestureRecognizer) {
        miBool = !miBool
        formatoDaysActive(txt: MiLbl, view: Mi, bool: miBool)
    }
    @objc func TFJu(gesture: UIGestureRecognizer) {
        juBool = !juBool
        formatoDaysActive(txt: JuLbl, view: Ju, bool: juBool)
    }
    @objc func TFVi(gesture: UIGestureRecognizer) {
        viBool = !viBool
        formatoDaysActive(txt: ViLbl, view: Vi, bool: viBool)
    }
    @objc func TFSa(gesture: UIGestureRecognizer) {
        saBool = !saBool
        formatoDaysActive(txt: SaLbl, view: Sa, bool: saBool)
    }
    @objc func TFDo(gesture: UIGestureRecognizer) {
        doBool = !doBool
        formatoDaysActive(txt: DoLbl, view: Do, bool: doBool)
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
    
    func preFormatoDaysViews(){
        formatoDaysViews(view:Lu)
        formatoDaysViews(view:Ma)
        formatoDaysViews(view:Mi)
        formatoDaysViews(view:Ju)
        formatoDaysViews(view:Vi)
        formatoDaysViews(view:Sa)
        formatoDaysViews(view:Do)
    }
    
    func formatoDaysViews(view:UIView){
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func formatoHeadView(){
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func setDelegates(){
        horaIniPV.delegate=self
        horaIniPV.dataSource=self
        horaFinPV.delegate=self
        horaFinPV.dataSource=self
        tipoPV.delegate=self
        tipoPV.dataSource=self
        
        precioTF.delegate=self
        telefonoTF.delegate=self
        correoTF.delegate=self
        nombreActividadTF.delegate=self
        responsableTF.delegate=self
        
        direccionTV.delegate=self
        publicoTV.delegate=self
        descTV.delegate=self
        donativoTV.delegate=self
        voluntariosSV.delegate=self
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
        precioTF.inputAccessoryView = doneToolbar
        responsableTF.inputAccessoryView = doneToolbar
        correoTF.inputAccessoryView = doneToolbar
        nombreActividadTF.inputAccessoryView = doneToolbar
        direccionTV.inputAccessoryView = doneToolbar

        donativoTV.inputAccessoryView = doneToolbar
        voluntariosSV.inputAccessoryView = doneToolbar
        publicoTV.inputAccessoryView = doneToolbar
        descTV.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        precioTF.resignFirstResponder()
        nombreActividadTF.resignFirstResponder()
        publicoTV.resignFirstResponder()
        descTV.resignFirstResponder()
        donativoTV.resignFirstResponder()
        voluntariosSV.resignFirstResponder()
        direccionTV.resignFirstResponder()
    }

}

extension Actividades_CrearModulo: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == donativoTV{
            donativoCountLbl.text="\(textView.text.count)/500"
            if textView.text.count>500 {
                textView.text=textView.text.substring(to: 500)
                donativoCountLbl.text="\(textView.text.count)/500"
            }
        }
        
        if textView == voluntariosSV{
            volunsCountLbl.text="\(textView.text.count)/500"
            if textView.text.count>500 {
                textView.text=textView.text.substring(to: 500)
                volunsCountLbl.text="\(textView.text.count)/500"
            }
        }
        
        if textView == publicoTV{
            publicoCountLbl.text="\(textView.text.count)/500"
            if textView.text.count>500 {
                textView.text=textView.text.substring(to: 500)
                publicoCountLbl.text="\(textView.text.count)/500"
            }
        }
        
        if textView == descTV{
            descCountLbl.text="\(textView.text.count)/500"
            if textView.text.count>500 {
                textView.text=textView.text.substring(to: 500)
                descCountLbl.text="\(textView.text.count)/500"
            }
        }
    }
}

extension Actividades_CrearModulo: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
        case horaIniPV:
            count = arrOpen.count
        case horaFinPV:
            count = arrOpen.count
        case tipoPV:
            count = arrType.count
        default:
            break
        }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case horaIniPV:
            return arrOpen[row]
        case horaFinPV:
            return arrOpen[row]
        case tipoPV:
            return arrType[row]
        default:
            return arrOpen[row]
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case horaIniPV:
            openHour=arrOpen[row]
            print("selecciono open")
        case horaFinPV:
            print("selecciono close")
            closeHour=arrOpen[row]
        case tipoPV:
            print("selecciono type::")
            print(row)
            tipoEventoNew = row
        default:
            print("selecciono otro")
        }
    }
    
}

//MARK: - TextField Delegate Implementation
extension Actividades_CrearModulo: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //self.nextTextField(textField)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("should change")
     
        if textField == precioTF{
            if textField.text!.count>1 {
                textField.text=textField.text!.substring(to: 1)
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin editing")
    }
    
}

struct ActividadGenerica: Codable {
    var horarios: [Horario]
    var responsable: String
    var correo: String
    var telefono: String
    var direccion: String
    var cobro: Int
    var descripcion: String
    var publico:String
    var voluntariosBool: Int
    var donantesBool: Int
    var voluntariosTxt: String
    var donantesTxt: String
    var status: Int
    var nombre : String
    var userId: Int
    var eventoId: Int
    var tipoEvento : Int
}

