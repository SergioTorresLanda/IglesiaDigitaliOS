//
//  Home_Actividades.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 03/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary
import RealmSwift
import Alamofire
import EncuentroCatolicoVirtualLibrary

class Home_Actividades: UIViewController {

    @IBOutlet weak var zonaPV: UIPickerView!
    @IBOutlet weak var mesesPV: UIPickerView!
    @IBOutlet weak var tipoPV: UIPickerView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var zonaLbl: UILabel!
    
    @IBOutlet weak var nothingLbl: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var viewS: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createBtn: UIView!
    @IBOutlet weak var createLbl: UILabel!
    @IBOutlet weak var comedoresSV: UIStackView!
    
    @IBOutlet weak var despensasSV: UIStackView!
    var arrZona = ["Todas","Álvaro Obregón","Azcapotzalco","Benito Juárez",
                   "Coyoacán","Cuajimalpa de Morelos","Cuauhtémoc","Gustavo A. Madero",
                   "Iztacalco","Iztapalapa", "La Magdalena Contreras", "Miguel Hidalgo", "Milpa Alta", "Tláhuac","Tlalpan","Venustiano Carranza","Xochimilco"]
    
    let mapaIdZonas = ["Álvaro Obregón":10, "Azcapotzalco":2, "Benito Juárez":14, "Coyoacán":3, "Cuajimalpa de Morelos":4, "Cuauhtémoc":15, "Gustavo A. Madero":5, "Iztacalco":6, "Iztapalapa":7, "La Magdalena Contreras":8, "Miguel Hidalgo":16, "Milpa Alta":9, "Tláhuac":11, "Tlalpan":12, "Venustiano Carranza":17, "Xochimilco":13]
    var arrMeses=["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    var arrTipos=["Donante","Voluntario","Solicitante"]
    var tipoSelect="Donante"
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var comedores : [Comedor] = []
    var comedoresFiltroParti : [Comedor] = []
    var comedoresFiltro : [Comedor] = []
    let profile = UserDefaults.standard.string(forKey: "profile")
    var update = false
    var comedorId = "00"
    var isCapable=true
    var alertFields : AcceptAlert?

    //let shimmer = Shimmer()
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "donar" {
            let vc = segue.destination as! Actividades_CrearDonador
            let c = sender as! Comedor
            vc.comedorId = Int(c.id) ?? 0
        }
        if segue.identifier == "participar" {
            let vc = segue.destination as! Actividades_CrearVoluntario
            let c = sender as! Comedor
            vc.comedorId = Int(c.id) ?? 0
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
    
    func validateProfile(){
        print("PERFIL :::: ")
        print(profile!)
        switch profile {
        case UserProfileEnum.fiel.rawValue, UserProfileEnum.sacerdote.rawValue:
            isCapable=false
            print("will never show create")
        default:
            print("buen perfil")
        }
        
        let autoLogin = UserDefaults.standard.bool(forKey: "autoLogin")
        if autoLogin {
            isCapable=false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        comedores=[]
        comedoresFiltro=[]
        comedoresFiltroParti=[]
        tableView.reloadData()
        getComedoresList()
        initialConfig()
    }
    
    func initialConfig(){
        createBtn.isHidden=true
        tipoPV.selectRow(0, inComponent: 0, animated: true)
        zonaPV.selectRow(0, inComponent: 0, animated: true)
    }
    
    func getComedoresList() {
        startShimmer()
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/comedores") else { return }
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
            //print(responseData)
            print("Comedores creados:: ")
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
                print("JSON is invalid")
                finishQuery()
            }
        } catch {
            print("JSON error")
            print(error.localizedDescription)
            finishQuery()
        }
    }
    
    func updateOrCreate(rD:Array<Any>){
        print("MI ID ESS:::")
        print(SNId)
        for x in rD{
            if let object = x as? [String: Any] { //esta deberia ser la buena
                if object["FIUSERID"] as? String ?? "" == String(SNId){
                    DispatchQueue.main.async {
                        self.update=true
                        self.comedorId=object["FCCOMEDORID"] as? String ?? "0"
                        self.createLbl.text="Actualizar mi comedor "
                    }
                }
                var hourStart = "00:01"
                var hourEnd = "00:01"
                var dias : [Dia] = []
                if let arr2 = object["FCHORARIOS"] as? [[String:Any]],
                   let hora = arr2.first {
                    hourStart = hora["hour_start"] as? String ?? "00:02"
                    hourEnd = hora["hour_end"] as? String ?? "00:02"
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
                if object["FCSTATUS"] as? Int ?? 0 == 1 {
                    print("COMEDOR:::")
                    print(object)
                comedores.append(Comedor(horarios: [Horario(days: dias,
                                                            hour_start: hourStart,
                                                            hour_end: hourEnd)],
                                         correo: object["FCCORREO"] as? String ?? "sinCorreo",
                                         telefono: object["FCTELEFONO"]  as? String ?? "sinTelefono",
                                         direccion: object["FCDIRECCION"]  as? String ?? "sinDireccion",
                                         cobro: object["FCCOBRO"] as? Int ?? 0,
                                         requisitos: object["FCREQUISITOS"]  as? String ?? "sinRequisitos",
                                         voluntarios: object["FCVOLUNTARIOS"] as? Int ?? 0,
                                         donantes: [0],//no trae la data correcta de donantes
                                         zona: object["FIZONA"] as? Int ?? 0,
                                         status: object["FCSTATUS"] as? Int ?? 0,
                                         longitud: object["FNLONGITUD"] as? Double ?? 0.0,
                                         latitud: object["FNLATITUD"] as? Double ?? 0.0,
                                         nombre: object["FCNOMBRECOM"]  as? String ?? "sinNombre",
                                         responsable: object["FCRESPONSABLE"]  as? String ?? "sinResponsable",
                                         user_id: object["FIUSERID"]  as? String ?? "nouserId",
                                         id: object["FCCOMEDORID"] as? String ?? "0"))
                }else{
                    print("status inactivo :::")
                    print(object["FCCOMEDORID"] as? String ?? "no id")
                }
            } else {
                print("JSON2 is invalid")
                finishQuery()
            }
        }
        comedoresFiltroParti=comedores
        comedoresFiltro=comedores
        finishQuery()
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
        //shimmer.startLoader(view: viewS, rows: [100, 200, 100, 200, 100])
    }
    
    func stopShimmer(){
        progress.stopAnimating()
        progress.isHidden=true
        //shimmer.stopLoader()
    }
    //TAP GESTURES
    func addTapGestures(){
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(Home_Actividades.TF1))
        createBtn.addGestureRecognizer(tapG1)
        
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(Home_Actividades.TF2))
        despensasSV.addGestureRecognizer(tapG2)
  
    }
    
    @objc func TF1(gesture: UIGestureRecognizer) {
        print("crear click")
        let storyboard = UIStoryboard(name: "CrearComedorSB", bundle: Bundle(for: Actividades_CrearComedor.self))
        let view = storyboard.instantiateViewController(withIdentifier: "CrearComedorSB") as! Actividades_CrearComedor
        view.update=update
        view.comedorId=comedorId
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func TF2(gesture: UIGestureRecognizer) {
        print("desp click")
        performSegue(withIdentifier: "despensas", sender: self)
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func hideOrShowLbl(){
        if comedoresFiltro.count>0{
            nothingLbl.isHidden=true
        }else{
            nothingLbl.isHidden=false
        }
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
}

extension Home_Actividades:ComedorCellDelegate{
    func cellAction(sender:Comedor) {
        print("recibio accion")
        switch tipoSelect{
        case "Donante":
            if isCapable {
                self.performSegue(withIdentifier: "donar", sender: sender)
            }else{
                self.showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para realizar una donación." )
            }
        case "Voluntario":
            print("accion voluntario")
            if isCapable {
            self.performSegue(withIdentifier: "participar", sender: sender)
            }else{
                self.showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para ser voluntario." )
            }
        default:
            print("accion ninguno, no pasa")
        }
    }
}

extension Home_Actividades: UIPickerViewDelegate, UIPickerViewDataSource {
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
                comedoresFiltro=comedoresFiltroParti
            }else{
                comedoresFiltro=comedoresFiltroParti.filter{$0.zona==zonaId}
            }
            hideOrShowLbl()
            tableView.reloadData()
            stopShimmer()
        case tipoPV:
            zonaPV.selectRow(0, inComponent: 0, animated: true)
            startShimmer()
            print("selecciono::")
            let t=arrTipos[row]
            print(t)
            tipoSelect=arrTipos[row]
            switch row {
                case 0://Donante
                comedoresFiltroParti=comedores
                comedoresFiltro=comedoresFiltroParti
                case 1://voluns
                print("selecciono voluns")
                comedoresFiltroParti=comedores.filter{$0.voluntarios==1}
                comedoresFiltro=comedoresFiltroParti
                case 2://participante
                print("selecciono donans")
                comedoresFiltroParti=comedores
                comedoresFiltro=comedoresFiltroParti
            default:
                print("no pasa")
                comedoresFiltroParti=comedores
                comedoresFiltro=comedoresFiltroParti
            }
            hideOrShowLbl()
            tableView.reloadData()
            stopShimmer()
          
        default:
            print("selecciono otro")
        }
    }
}

extension Home_Actividades: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noris = 0
        noris = comedoresFiltro.count  //saintOfDay.count + realesesP
        print(":::NORIS:::"+String(noris))
        return noris
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "COMCELL", for: indexPath) as! ComedorCell
        //cell.delegate = self
        cell.selectionStyle = .none
       
        if indexPath.row >= comedoresFiltro.startIndex && indexPath.row < comedoresFiltro.endIndex {
                print(":::SETUPP Comedores::: ")
                print(String(indexPath.row))
            cell.setComedor(data: comedoresFiltro[indexPath.row], type: tipoSelect)
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
