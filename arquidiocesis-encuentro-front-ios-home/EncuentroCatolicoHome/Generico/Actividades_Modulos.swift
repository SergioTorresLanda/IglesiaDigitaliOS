//
//  Actividades_Modulos.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 24/05/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_Modulos: UIViewController {

    
    @IBOutlet weak var createView: UIView!
    
    @IBOutlet weak var comSV: UIStackView!
    @IBOutlet weak var despSV: UIStackView!
    @IBOutlet weak var tipoPV: UIPickerView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHead: UIView!
    
    @IBOutlet weak var nothingLbl: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var createLbl: UILabel!
    let arrType=["-Seleccionar-","Donador","Voluntario","Participante"]
    var arrMeses=["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    var tipoSelect="-Seleccionar-"
    var tipoSelectInt=0
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var actividades : [ActividadGenerica] = []
    var actividadesFiltro : [ActividadGenerica] = []
    let profile = UserDefaults.standard.string(forKey: "profile")
    var update = false
    var eventoId = 0
    var tipoEvento = 0
    var isCapable=true
    var alertFields : AcceptAlertLogin?
    var actividad : ActividadGenerica?
    let defaults=UserDefaults.standard
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "actor" {
            let vc = segue.destination as! Actividades_CrearActor
            vc.tipo_actor = tipoSelectInt
            vc.eventoId = sender as! Int
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(Home_Actividades.TF1))
        createView.addGestureRecognizer(tapG1)
        
        tipoPV.delegate=self
        tipoPV.dataSource=self
        tableView.delegate=self
        tableView.dataSource=self
        validateProfile()
        
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(Actividades_Modulos.TF2))
        comSV.addGestureRecognizer(tapG2)
        
        let tapG3 = UITapGestureRecognizer(target: self, action: #selector(Actividades_Modulos.TF3))
        despSV.addGestureRecognizer(tapG3)
    }
    
    @objc func TF2(gesture: UIGestureRecognizer) {
        print("comedoresClick")
        upgradeCount()
        performSegue(withIdentifier: "comedores", sender: self)
        //self.navigationController?.popViewController(animated: false)
    }
    @objc func TF3(gesture: UIGestureRecognizer) {
        print("despClick")
        upgradeCount()
        performSegue(withIdentifier: "despensas", sender: self)
        //self.navigationController?.popViewController(animated: false)
    }
    
    func upgradeCount(){
        var num = defaults.integer(forKey: "shouldGoBackAuto")
        num+=1
        defaults.set(num, forKey: "shouldGoBackAuto")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var x = defaults.integer(forKey: "clickBack")
        var num = defaults.integer(forKey: "shouldGoBackAuto")
        if num > 0 && x==1 {
            num -= 1
            defaults.set(num, forKey: "shouldGoBackAuto")
            self.navigationController?.popViewController(animated: false)
        }
        actividades=[]
        actividadesFiltro=[]
        tableView.reloadData()
        getActividadesList()
        initialConfig()
    }
    
    func initialConfig(){
        createView.isHidden=true
        update=false
        createLbl.text="Crear una actividad "
        tipoPV.selectRow(0, inComponent: 0, animated: true)
        //zonaPV.selectRow(0, inComponent: 0, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    func validateProfile(){
        print("PERFIL GEN:::: ")
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
    
    @objc func TF1(gesture: UIGestureRecognizer) {
        print("crear click")
        let storyboard = UIStoryboard(name: "CrearComedorSB", bundle: Bundle(for: Actividades_CrearModulo.self))
        let view = storyboard.instantiateViewController(withIdentifier: "CrearModulo") as! Actividades_CrearModulo
        view.update=update
        view.eventoId=eventoId
        view.tipoEvento=tipoEvento
        print("se envia tipo ::")
        print(tipoEvento)
        view.c=actividad
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func getActividadesList() {
        startShimmer()
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/genericos") else { return }
        var request = URLRequest(url: apiURL)
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let allData = data else {
                self.finishQuery()
                return
            }
            let responseData = String(data: allData, encoding: String.Encoding.utf8)
            print("RESPONSE DATA")
            print(responseData)
            print("Actividades creadas:: ")
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
            if let object = x as? [String: Any] {
                var hourStart = "00:01"
                var hourEnd = "00:01"
                var dias : [Dia] = []
                if let arr2 = object["horarios"] as? [[String:Any]],
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
                
                let actividadGenericaLocal=ActividadGenerica(horarios: [Horario(days: dias, hour_start: hourStart, hour_end: hourEnd)],
                                                             responsable: object["responsable"]  as? String ?? "sinResponsable",
                                                             correo: object["correo"]  as? String ?? "sinCorreo",
                                                             telefono: object["telefono"]  as? String ?? "sinTelefono",
                                                             direccion: object["direccion"]  as? String ?? "sinDireccion",
                                                             cobro: object["cobro"]  as? Int ?? 0,
                                                             descripcion: object["descripcion"]  as? String ?? "sinDescripcion",
                                                             publico: object["publico"]  as? String ?? "sinPublico",
                                                             voluntariosBool: object["voluntariosBool"]  as? Int ?? 0,
                                                             donantesBool: object["donantesBool"]  as? Int ?? 0,
                                                             voluntariosTxt: object["voluntariosTxt"]  as? String ?? "sinVoluntariosTxt",
                                                             donantesTxt: object["donantesTxt"]  as? String ?? "sinDonantesTxt",
                                                             status: object["status"]  as? Int ?? 0,
                                                             nombre: object["nombre"]  as? String ?? "sinNombre",
                                                             userId: object["userId"]  as? Int ?? 0,
                                                             eventoId: object["eventoId"]  as? Int ?? 0,
                                                             tipoEvento: object["tipoEvento"]  as? Int ?? 0 )
                
                if object["status"] as? Int ?? 0 == 1 {
                    if object["userId"] as? Int ?? 0 == SNId{
                        DispatchQueue.main.async {
                            self.update=true
                            self.eventoId=object["eventoId"] as? Int ?? 0
                            self.tipoEvento=object["tipoEvento"] as? Int ?? 0
                            self.actividad=actividadGenericaLocal
                            self.createLbl.text="Actualizar mi actividad "
                        }
                    }
                    actividades.append(actividadGenericaLocal)
                    print("ACTIVIDADES::::XXX")
                    print(actividades)
                }
            } else {
                print("JSON2 is invalid")
                finishQuery()
            }
        }
        actividadesFiltro=actividades
        finishQuery()
    }
    
    func finishQuery(){
        DispatchQueue.main.async {
            if self.isCapable{
            self.createView.isHidden=false
            }
            self.hideOrShowLbl()
            self.stopShimmer()
            self.tableView.reloadData()
        }
    }
    
    func hideOrShowLbl(){
        if actividadesFiltro.count>0{
            nothingLbl.isHidden=true
        }else{
            nothingLbl.isHidden=false
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
    

    @IBAction func backClick(_ sender: Any) {
        defaults.set(1, forKey: "clickBack")
        self.navigationController?.popViewController(animated: false)
    }
    
    func showCanonAlert(title:String, msg:String){
        DispatchQueue.main.async {
            self.progress.stopAnimating()
            self.progress.isHidden=true
            self.alertFields = AcceptAlertLogin.showAlert(titulo: title, mensaje: msg)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
    }

}

extension Actividades_Modulos: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        startShimmer()
        print("selecciono::")
        let t=arrType[row]
        print(t)
        tipoSelect=arrType[row]
        tipoSelectInt=row
        switch row {
            case 0: //todos
                actividadesFiltro=actividades
            case 1://Donador
            print("selecciono don")
                actividadesFiltro=actividades.filter{$0.donantesBool==1}
            case 2://Voluntario
                print("selecciono voluns")
                actividadesFiltro=actividades.filter{$0.voluntariosBool==1}
            case 3://participante
                print("selecciono participante")
                actividadesFiltro=actividades
        default:
            print("no pasa")
        }
        hideOrShowLbl()
        tableView.reloadData()
        stopShimmer()
    }
}

extension Actividades_Modulos: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var noris = 0
        noris = actividadesFiltro.count
        print(":::NORIS:::"+String(noris))
        return noris
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACTCELL", for: indexPath) as! GenericCell
        cell.delegate = self
        cell.selectionStyle = .none
      
        if indexPath.row >= actividadesFiltro.startIndex && indexPath.row < actividadesFiltro.endIndex {
                print(":::SETUPP Actividades::: ")
                print(String(indexPath.row))
            cell.setData(data: actividadesFiltro[indexPath.row], tipoSelect: tipoSelect)
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

extension Actividades_Modulos:ActividadCellDelegate{
    func cellAction(sender:ActividadGenerica) {
        print("recibio accion act")
        switch tipoSelect{
        case "Donador":
            if isCapable {
                self.performSegue(withIdentifier: "actor", sender: sender.eventoId)
            }else{
                self.showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para realizar una donación." )
            }
        case "Voluntario":
            print("accion voluntario")
            if isCapable {
                self.performSegue(withIdentifier: "actor", sender: sender.eventoId)
            }else{
                self.showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para ser voluntario." )
            }
        case "Participante":
            print("accion voluntario")
            if isCapable {
                self.performSegue(withIdentifier: "actor", sender: sender.eventoId)
            }else{
                self.showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para beneficiarte de esta actividad." )
            }
        default:
            print("accion ninguno, no pasa")
        }
    }
}
