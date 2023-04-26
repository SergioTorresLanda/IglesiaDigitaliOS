//
//  ViewController.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 21/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary
import RealmSwift
import Alamofire


class Actividades_Despensas: UIViewController {
    
    @IBOutlet weak var zonaPV: UIPickerView!
    @IBOutlet weak var mesesPV: UIPickerView!
    @IBOutlet weak var tipoPV: UIPickerView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var comedoresBtn: UIButton!
    @IBOutlet weak var nothingLbl: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var viewS: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createBtn: UIView!
    @IBOutlet weak var createLbl: UILabel!
    @IBOutlet weak var comedoresSV: UIStackView!
    
    var arrZona = ["Todas","Álvaro Obregón","Azcapotzalco","Benito Juárez",
                   "Coyoacán","Cuajimalpa de Morelos","Cuauhtémoc","Gustavo A. Madero",
                   "Iztacalco","Iztapalapa", "La Magdalena Contreras", "Miguel Hidalgo", "Milpa Alta", "Tláhuac","Tlalpan","Venustiano Carranza","Xochimilco"]
    
    let mapaIdZonas = ["Álvaro Obregón":10, "Azcapotzalco":2, "Benito Juárez":14, "Coyoacán":3, "Cuajimalpa de Morelos":4, "Cuauhtémoc":15, "Gustavo A. Madero":5, "Iztacalco":6, "Iztapalapa":7, "La Magdalena Contreras":8, "Miguel Hidalgo":16, "Milpa Alta":9, "Tláhuac":11, "Tlalpan":12, "Venustiano Carranza":17, "Xochimilco":13]
    var arrMeses=["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    var arrTipos=["Asistente","Donante","Organizador","Voluntario"]
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var despensas : [Despensa] = []
    var despensasFiltro : [Despensa] = []
    let profile = UserDefaults.standard.string(forKey: "profile")
    var update = false
    var despensaId = 123456
    var isCapable=true

    //let shimmer = Shimmer()
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "crear" {
            let vc = segue.destination as! Actividades_CrearDespensa
            vc.despensaId = despensaId
            vc.update=update
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zonaPV.delegate=self
        zonaPV.dataSource=self
        mesesPV.delegate=self
        mesesPV.dataSource=self
        tipoPV.delegate=self
        tipoPV.dataSource=self
        tableView.delegate=self
        tableView.dataSource=self
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
        addTapGestures()
        validateProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        despensas=[]
        despensasFiltro=[]
        tableView.reloadData()
        getDespensasList()
        initialConfig()
    }
    
    func initialConfig(){
        createBtn.isHidden=true
        //tipoPV.selectRow(0, inComponent: 0, animated: true)
        //zonaPV.selectRow(0, inComponent: 0, animated: true)
    }
    
    func validateProfile(){
        print("PERFIL :::: ")
        print(profile!)
        switch profile {
        case UserProfileEnum.fiel.rawValue, UserProfileEnum.sacerdote.rawValue:
            isCapable=false
            print("will never show create btn")
        default:
            print("buen perfil")
        }
    }
    
    func getDespensasList() {
        startShimmer()
        //let defaults = UserDefaults.standard
        //let idUser = defaults.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/despensas") else { return }
        var request = URLRequest(url: apiURL)
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let allData = data else {
                self.finishQuery()
                return
            }
            //let responseData = String(data: allData, encoding: String.Encoding.utf8)
            print("Despensas creadas:: ")
            //print(responseData)
           
            self.readJson(data: allData)
        }
            work.resume()
    }
    
    private func readJson(data:Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [Any] {
                print("JSON is array") //esta es la opcion buena
                updateOrCreate(rD: object)
            } else {
                self.finishQuery()
                print("JSON is invalid")
            }
        } catch {
            self.finishQuery()
            print("JSON error")
            print(error.localizedDescription)
        }
    }
    
    func updateOrCreate(rD:Array<Any>){
        print("MI ID ESS:::")
        print(SNId)
        for x in rD{
            print(x)
            if let object = x as? [String: Any] {
                print("El User ID es :::")
                print(object["user_id"] as? Int ?? 12345)
                if object["user_id"] as? Int ?? 12345 == SNId{
                    print("Tengo una despensa biatch")
                    print(object)
                    DispatchQueue.main.async {
                        self.update=true
                        self.despensaId=object["despensa_id"] as? Int ?? 12345
                        self.createLbl.text="Actualizar mi despensa "
                    }
                }
                getDataForArr(object:object)
            } else {
                print("JSON2 is invalid")
            }
        }
        despensasFiltro=despensas
        finishQuery()
    }
    
func getDataForArr(object:[String: Any]){
        var diasRec : [Dia] = []
        var diasArm : [Dia] = []
        var diasEnt : [Dia] = []
        var openHourRec:String=""
        var closeHourRec:String=""
        var openHourArm:String=""
        var closeHourArm:String=""
        var openHourEnt:String=""
        var closeHourEnt:String=""
        if let arrHorarios = object["horarios"] as? [[String:Any]]{
           if let hora = arrHorarios.first {
                if let dias = hora["days"] as? [[String:Any]]{
                    if dias[0]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 1, name: "Domingo", checked: true))
                    }
                    if dias[1]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 2, name: "Lunes", checked: true))
                    }
                    if dias[2]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 3, name: "Martes", checked: true))
                    }
                    if dias[3]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 4, name: "Miércoles", checked: true))
                    }
                    if dias[4]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 5, name: "Jueves", checked: true))
                    }
                    if dias[5]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 6, name: "Viernes", checked: true))
                    }
                    if dias[6]["checked"] as? Int ?? 3 == 1 {
                        diasRec.append(Dia(id: 7, name: "Sábado", checked: true))
                    }
                }else{
                    print("no hay daysen horarios[0]")
                }
            }else{
                print("no hay horarios[0]")
            }
            
            if let hora = arrHorarios.second {
                 if let dias = hora["days"] as? [[String:Any]]{
                     if dias[0]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 1, name: "Domingo", checked: true))
                     }
                     if dias[1]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 2, name: "Lunes", checked: true))
                     }
                     if dias[2]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 3, name: "Martes", checked: true))
                     }
                     if dias[3]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 4, name: "Miércoles", checked: true))
                     }
                     if dias[4]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 5, name: "Jueves", checked: true))
                     }
                     if dias[5]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 6, name: "Viernes", checked: true))
                     }
                     if dias[6]["checked"] as? Int ?? 3 == 1 {
                         diasArm.append(Dia(id: 7, name: "Sábado", checked: true))
                     }
                 }else{
                     print("no hay daysen horarios[1]")
                 }
             }else{
                 print("no hay horarios[1]")
             }
            
            if arrHorarios.count>2{
                let hora = arrHorarios[2]
                if let dias = hora["days"] as? [[String:Any]]{
                    if dias[0]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 1, name: "Domingo", checked: true))
                    }
                    if dias[1]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 2, name: "Lunes", checked: true))
                    }
                    if dias[2]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 3, name: "Martes", checked: true))
                    }
                    if dias[3]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 4, name: "Miércoles", checked: true))
                    }
                    if dias[4]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 5, name: "Jueves", checked: true))
                    }
                    if dias[5]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 6, name: "Viernes", checked: true))
                    }
                    if dias[6]["checked"] as? Int ?? 3 == 1 {
                        diasEnt.append(Dia(id: 7, name: "Sábado", checked: true))
                    }
                }else{
                    print("no hay daysen horarios[1]")
                }
                
            }else{
                print("no hay horarios[2]")
            }
        
        }else{
            print("no se encontro -horarios- como [string Any]")
        }
        
        var fechaRec = ""
        var fechaRecFin = ""
        var fechaArm = ""
        var fechaArmFin = ""
        var fechaEnt = ""
        var fechaEntFin = ""
        if let fecRecibido = object["fecha_recibido"] as? [String:Any]{
            fechaRec = fecRecibido["fecha_inicio"] as? String ?? "xx/xx/xxxx"
            fechaRecFin = fecRecibido["fecha_final"] as? String ?? "xx/xx/xxxx"
            openHourRec = fecRecibido["hora_inicio"] as? String ?? "00:02"
            closeHourRec = fecRecibido["hora_final"] as? String ?? "00:02"
        }
        if let fecArmado = object["fecha_armado"] as? [String:Any]{
            fechaArm = fecArmado["fecha_inicio"] as? String ?? "xx/xx/xxxx"
            fechaArmFin = fecArmado["fecha_final"] as? String ?? "xx/xx/xxxx"
            openHourArm = fecArmado["hora_inicio"] as? String ?? "00:02"
            closeHourArm = fecArmado["hora_final"] as? String ?? "00:02"
        }
        if let fecEnt = object["fecha_repartido"] as? [String:Any]{
            fechaEnt = fecEnt["fecha_inicio"] as? String ?? "xx/xx/xxxx"
            fechaEntFin = fecEnt["fecha_final"] as? String ?? "xx/xx/xxxx"
            openHourEnt = fecEnt["hora_inicio"] as? String ?? "00:02"
            closeHourEnt = fecEnt["hora_final"] as? String ?? "00:02"
        }
        let tel = object["telefono"]  as? String ?? "sinTelefono"
        let tel2 = tel.substring(from: 3)
        let c = Despensa(responsable: object["responsable"] as? String ?? "NA",
                         req_donador: object["req_donador"] as? Int ?? 0,
                         req_armado: object["req_armado"] as? Int ?? 0,
                         req_entrega: object["req_entrega"] as? Int ?? 0,
                         direccion: object["direccion"] as? String ?? "NA",
                         horarios: [HorarioX(days: diasRec),HorarioX(days: diasArm),HorarioX(days: diasEnt)],
                         fecha_recibido: FechaX(fecha_inicio: fechaRec, fecha_final: fechaRecFin,hora_inicio:openHourRec, hora_final: closeHourRec),
                         fecha_armado: FechaX(fecha_inicio: fechaArm, fecha_final: fechaArmFin,hora_inicio:openHourArm, hora_final: closeHourArm),
                         fecha_repartido: FechaX(fecha_inicio: fechaEnt, fecha_final: fechaEntFin,hora_inicio:openHourEnt, hora_final: closeHourEnt),
                         user_id: object["user_id"] as? Int ?? 0,
                         correo: object["correo"] as? String ?? "NA",
                         telefono: tel2,
                         estatus: object["estatus"] as? Int ?? 0,
                         descripcion_despensa: object["descripcion_despensa"] as? String ?? "NA",
                         direccion_entrega: object["direccion_entrega"] as? String ?? "NA",
                         requisitos_donacion: object["requisitos_donacion"] as? String ?? "NA",
                         zona: object["zona"] as? Int ?? 0,
                         longitud: object["longitud"] as? Double ?? 0.0,
                         latitud: object["latitud"] as? Double ?? 0.0,
                         longitud_entrega: object["longitud_entrega"] as? Double ?? 0.0,
                         latitud_entrega: object["latitud_entrega"] as? Double ?? 0.0)
        
        if object["estatus"] as? Int ?? 0 == 1 {
            despensas.append(c)
        }else{
            print("status inactivo :::")
            print(object["despensa_id"] as? String ?? "no id")
        }
    }
    
    func finishQuery(){
        DispatchQueue.main.async {
            if self.isCapable{
            self.createBtn.isHidden=false
            }
            self.hideOrShowLbl()
            self.stopShimmer()
            self.tableView.reloadData()
        }
    }
    
    func startShimmer(){
        progress.isHidden=false
        progress.startAnimating()
    }
    
    func stopShimmer(){
        progress.stopAnimating()
        progress.isHidden=true
    }
    //TAP GESTURES
    func addTapGestures(){
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_Despensas.TF1))
        createBtn.addGestureRecognizer(tapG1)
        
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(Actividades_Despensas.TF2))
        comedoresSV.addGestureRecognizer(tapG2)
    }
    @objc func TF1(gesture: UIGestureRecognizer) {
        print("crear despensa click")
        performSegue(withIdentifier: "crear", sender: self)
    }
    
    @objc func TF2(gesture: UIGestureRecognizer) {
        print("comedoresClick")
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideOrShowLbl(){
        if despensasFiltro.count>0{
            nothingLbl.isHidden=true
        }else{
            nothingLbl.isHidden=false
        }
    }
}

extension Actividades_Despensas: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
        case zonaPV:
            count = arrZona.count
        case mesesPV:
            count = arrMeses.count
        case tipoPV:
            count = arrTipos.count
            
        default:
            break
        }
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case zonaPV:
            return arrZona[row]
        case mesesPV:
            return arrMeses[row]
        case tipoPV:
            return arrTipos[row]
        default:
            return arrTipos[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case zonaPV:
            startShimmer()
            print("selecciono::")
            let zonaS=arrZona[row]
            print(zonaS)
            let zonaId=mapaIdZonas[zonaS] ?? 0
            print(zonaId)
            if zonaId==0{
                despensasFiltro=despensas
            }else{
                despensasFiltro=despensas.filter{$0.zona==zonaId}
            }
            hideOrShowLbl()
            tableView.reloadData()
            stopShimmer()
        default:
            print("selecciono otro")
        }
    }
}

extension Actividades_Despensas: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noris = 0
        noris = despensasFiltro.count  //saintOfDay.count + realesesP
        print(":::NORIS::DESP:"+String(noris))
        return noris
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "DESPCELL", for: indexPath) as! DespensaCell
        //cell.delegate = self
        cell.selectionStyle = .none
       
        if indexPath.row >= despensasFiltro.startIndex && indexPath.row < despensasFiltro.endIndex {
                print(":::SETUPP Despensas::: ")
                print(String(indexPath.row))
            cell.setDespensa(data: despensasFiltro[indexPath.row], type: "x")
        }else{
            print("ERROR INDEX PATH: "+String(indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
