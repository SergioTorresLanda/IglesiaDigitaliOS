//
//  Actividades_CrearDespensa.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 21/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class Actividades_CrearDespensa: UIViewController {
    
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var responsableTF: UITextField!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var progressLoad: UIActivityIndicatorView!
    @IBOutlet weak var viewProgress: UIView!
    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var telefonoTF: UITextField!
    @IBOutlet weak var direc1TV: UITextView!
    
    @IBOutlet weak var direcEntregaTV: UITextView!
    @IBOutlet weak var updateDirec1SV: UIStackView!
    @IBOutlet weak var updateDirecEntregaSV: UIStackView!
    
    @IBOutlet weak var descTV: UITextView!
    @IBOutlet weak var descCountLbl: UILabel!
    
    @IBOutlet weak var recepcionSwitch: UISwitch!
    @IBOutlet weak var armadoSwitch: UISwitch!
    @IBOutlet weak var entregaSwitch: UISwitch!
    
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var entregaSV: UIStackView!
    @IBOutlet weak var armadoSV: UIStackView!
    @IBOutlet weak var recepcionSV: UIStackView!
    @IBOutlet weak var requisDonacionTV: UITextView!
    @IBOutlet weak var requisDonacionCountLbl: UILabel!
    
    @IBOutlet weak var zonaPV: UIPickerView!
    
    @IBOutlet weak var rechoraIniPV: UIPickerView!
    @IBOutlet weak var rechoraFinPV: UIPickerView!
    
    @IBOutlet weak var armHoraIniPV: UIPickerView!
    @IBOutlet weak var armHoraFinPV: UIPickerView!
    
    @IBOutlet weak var entHoraIniPV: UIPickerView!
    @IBOutlet weak var entHoraFinPV: UIPickerView!
    
    @IBOutlet weak var recFechaTF: UITextField!
    @IBOutlet weak var recFechaFinTF: UITextField!
    
    @IBOutlet weak var armFechaTF: UITextField!
    @IBOutlet weak var armFechaFinTF: UITextField!
    
    @IBOutlet weak var entFechaTF: UITextField!
    @IBOutlet weak var entFechaFinTF: UITextField!
    
    @IBOutlet weak var recLuV: UIView!
    @IBOutlet weak var recMaV: UIView!
    @IBOutlet weak var recMiV: UIView!
    @IBOutlet weak var recJuV: UIView!
    @IBOutlet weak var recViV: UIView!
    @IBOutlet weak var recSaV: UIView!
    @IBOutlet weak var recDoV: UIView!

    @IBOutlet weak var recLuLbl: UILabel!
    @IBOutlet weak var recMaLbl: UILabel!
    @IBOutlet weak var recMiLbl: UILabel!
    @IBOutlet weak var recJuLbl: UILabel!
    @IBOutlet weak var recViLbl: UILabel!
    @IBOutlet weak var recSaLbl: UILabel!
    @IBOutlet weak var recDoLbl: UILabel!
    
    @IBOutlet weak var armLuV: UIView!
    @IBOutlet weak var armMaV: UIView!
    @IBOutlet weak var armMiV: UIView!
    @IBOutlet weak var armJuV: UIView!
    @IBOutlet weak var armViV: UIView!
    @IBOutlet weak var armSaV: UIView!
    @IBOutlet weak var armDoV: UIView!
    
    @IBOutlet weak var armLuLbl: UILabel!
    @IBOutlet weak var armMaLbl: UILabel!
    @IBOutlet weak var armMiLbl: UILabel!
    @IBOutlet weak var armJuLbl: UILabel!
    @IBOutlet weak var armViLbl: UILabel!
    @IBOutlet weak var armSaLbl: UILabel!
    @IBOutlet weak var armDoLbl: UILabel!
    
    @IBOutlet weak var entLuV: UIView!
    @IBOutlet weak var entMaV: UIView!
    @IBOutlet weak var entMiV: UIView!
    @IBOutlet weak var entJuV: UIView!
    @IBOutlet weak var entViV: UIView!
    @IBOutlet weak var entSaV: UIView!
    @IBOutlet weak var entDoV: UIView!
    
    @IBOutlet weak var entLuLbl: UILabel!
    @IBOutlet weak var entMaLbl: UILabel!
    @IBOutlet weak var entMiLbl: UILabel!
    @IBOutlet weak var entJuLbl: UILabel!
    @IBOutlet weak var entViLbl: UILabel!
    @IBOutlet weak var entSaLbl: UILabel!
    @IBOutlet weak var entDoLbl: UILabel!
    
    @IBOutlet weak var guardarBtn: UIButton!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    @IBOutlet weak var recView: UIView!
    @IBOutlet weak var armView: UIView!
    @IBOutlet weak var entView: UIView!
    
    
    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    let datePicker3 = UIDatePicker()
    let datePicker4 = UIDatePicker()
    let datePicker5 = UIDatePicker()
    let datePicker6 = UIDatePicker()
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var alertFields : AcceptAlert?
    var azulito=UIColor(named: "azulActivo",in: Bundle(for: Actividades_CrearDespensa.self), compatibleWith: nil)
    var luBoolRec=false
    var maBoolRec=false
    var miBoolRec=false
    var juBoolRec=false
    var viBoolRec=false
    var saBoolRec=false
    var doBoolRec=false
    
    var luBoolArm=false
    var maBoolArm=false
    var miBoolArm=false
    var juBoolArm=false
    var viBoolArm=false
    var saBoolArm=false
    var doBoolArm=false
    
    var luBoolEnt=false
    var maBoolEnt=false
    var miBoolEnt=false
    var juBoolEnt=false
    var viBoolEnt=false
    var saBoolEnt=false
    var doBoolEnt=false
    
    var donInt=0
    var armInt=0
    var entInt=0
    
    var openHourRec=""
    var closeHourRec=""
    var openHourArm=""
    var closeHourArm=""
    var openHourEnt=""
    var closeHourEnt=""
    
    var statusG=1
    
    let arrHours=["00:00","01:00","02:00","03:00","04:00","05:00","06:00",
                 "07:00","08:00","09:00","10:00","11:00","12:00",
                 "13:00","14:00","15:00","16:00","17:00","18:00",
                 "19:00","20:00","21:00","22:00","23:00"]
    let mapaIdZonas = ["Álvaro Obregón":10, "Azcapotzalco":2, "Benito Juárez":14, "Coyoacán":3, "Cuajimalpa de Morelos":4, "Cuauhtémoc":15, "Gustavo A. Madero":5, "Iztacalco":6, "Iztapalapa":7, "La Magdalena Contreras":8, "Miguel Hidalgo":16, "Milpa Alta":9, "Tláhuac":11, "Tlalpan":12, "Venustiano Carranza":17, "Xochimilco":13]
    let arrZonas = ["--Seleccionar--","Álvaro Obregón", "Azcapotzalco", "Benito Juárez", "Coyoacán", "Cuajimalpa de Morelos", "Cuauhtémoc", "Gustavo A. Madero", "Iztacalco", "Iztapalapa", "La Magdalena Contreras", "Miguel Hidalgo", "Milpa Alta", "Tláhuac", "Tlalpan","Venustiano Carranza", "Xochimilco"]
    var zonaId = 0
    let defaults=UserDefaults.standard
    var update = false
    var despensaId = 654321
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.isHidden=true
        addTapGestures()
        preFormatoDaysViews()
        formatoHeadView()
        addDoneButtonOnKeyboard()
        setFieldsText()
        setDelegates()
        if update{
            viewProgress.isHidden=false
            progressLoad.startAnimating()
            titleLbl.text="Actualizar despensa"
            //verDonsSV.isHidden=false
            //verVolunsSV.isHidden=false
            getInfoDesp()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let adress = defaults.string(forKey: "lastAdressDespRec") ?? "Actualiza la ubicación de tu recepción de despensas en el mapa para obtener la dirección."
        direc1TV.text=adress
        let adress2 = defaults.string(forKey: "lastAdressDespEnt") ?? "Actualiza la ubicación de tu recepción de despensas en el mapa para obtener la dirección."
        direcEntregaTV.text=adress2
        progress.isHidden=true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.descCountLbl.text="\(self.descTV.text.count)/250"
        self.requisDonacionCountLbl.text="\(self.requisDonacionTV.text.count)/250"
    }
    
    func getInfoDesp() {
        //let idUser = defaults.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/act-voluntariado/despensas/"+String(despensaId)) else { return }
        var request = URLRequest(url: apiURL)
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let allData = data else { return }
            //let responseData = String(data: allData, encoding: String.Encoding.utf8)
            print("DESPENSA:: "+String(self.despensaId))
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
            print("JSON2 XX is valid")
            self.hideProgress()
            print(object)
            var diasRec : [Dia] = []
            var diasArm : [Dia] = []
            var diasEnt : [Dia] = []
            if let arrHorarios = object["horarios"] as? [Any]{//[String:Any]
               if let hora = arrHorarios.first as? [String:Any]{
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
                        print("no hay daysen horarios[0] XXX")
                    }
                }else{
                    print("no hay horarios[0] XXX")
                }
                
                if let hora = arrHorarios.second as? [String:Any]{
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
                         print("no hay daysen horarios[1] XXX")
                     }
                 }else{
                     print("no hay horarios[1] XXX")
                 }
                
                if arrHorarios.count>2{
                    if let hora = arrHorarios[2] as? [String:Any]{
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
                            print("no hay daysen horarios[2] XXX")
                        }
                        
                    }else{
                        print("hora no es [string,any]")
                    }
                }else{
                    print("no hay horarios[2] XXX")
                    print(arrHorarios.count)
                }
            
            }else{
                print("no se encontro -horarios- como [Any]")
            }
            
            var fechaRec = ""
            var fechaRecFin = ""
            var fechaArm = ""
            var fechaArmFin = ""
            var fechaEnt = ""
            var fechaEntFin = ""
            if let fecRecibido = object["fecha_recibido"] as? [String:Any]{
                fechaRec=fecRecibido["fecha_inicio"] as? String ?? "xx/xx/xxxx"
                fechaRecFin=fecRecibido["fecha_final"] as? String ?? "xx/xx/xxxx"
                openHourRec = fecRecibido["hora_inicio"] as? String ?? "00:02"
                closeHourRec = fecRecibido["hora_final"] as? String ?? "00:02"
            }
            if let fecArmado = object["fecha_armado"] as? [String:Any]{
                fechaArm=fecArmado["fecha_inicio"] as? String ?? "xx/xx/xxxx"
                fechaArmFin=fecArmado["fecha_final"] as? String ?? "xx/xx/xxxx"
                openHourArm = fecArmado["hora_inicio"] as? String ?? "00:02"
                closeHourArm = fecArmado["hora_final"] as? String ?? "00:02"
            }
            if let fecEnt = object["fecha_repartido"] as? [String:Any]{
                fechaEnt=fecEnt["fecha_inicio"] as? String ?? "xx/xx/xxxx"
                fechaEntFin=fecEnt["fecha_final"] as? String ?? "xx/xx/xxxx"
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
                                 horarios: [HorarioX(days: diasRec),
                                            HorarioX(days: diasArm),
                                           HorarioX(days: diasEnt)],
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
            //horarios: [Horario(days: dias, hour_start: openHour,hour_end: closeHour)],
                setupData(c:c)
            } else {
                print("JSON2 XX is invalid")
                self.hideProgress()
            }
    }
    
    func hideProgress(){
        DispatchQueue.main.async {
            self.viewProgress.isHidden=true
            self.progressLoad.stopAnimating()
        }
    }
    
    func setupData(c:Despensa){
        DispatchQueue.main.async {
            self.statusSwitch.setOn(c.estatus==1, animated: true)
            self.statusG = c.estatus
            self.responsableTF.text=c.responsable
            self.correoTF.text=c.correo
            self.telefonoTF.text=c.telefono
            self.direc1TV.text=c.direccion
            
            self.zonaPV.selectRow(self.arrZonas.firstIndex(of: self.mapaIdZonas.first(where: { $0.value == c.zona })!.key) ?? 0, inComponent: 0, animated: false)
            self.zonaId=c.zona
            self.descTV.text=c.descripcion_despensa
            self.descCountLbl.text="\(self.descTV.text.count)/250"
            self.requisDonacionTV.text=c.requisitos_donacion
            self.requisDonacionCountLbl.text="\(self.requisDonacionTV.text.count)/250"
           
            self.recepcionSwitch.setOn(c.req_donador==1, animated: true)
            self.armadoSwitch.setOn(c.req_armado==1, animated: true)
            self.entregaSwitch.setOn(c.req_entrega==1, animated: true)
            self.recView.isHidden = c.req_donador==0
            self.armView.isHidden = c.req_armado==0
            self.entView.isHidden = c.req_entrega==0
            self.donInt=c.req_donador
            self.armInt=c.req_armado
            self.entInt=c.req_entrega
            
            self.rechoraIniPV.selectRow(self.arrHours.firstIndex(of: c.fecha_recibido.hora_inicio) ?? 0, inComponent: 0, animated: true)
            self.rechoraFinPV.selectRow(self.arrHours.firstIndex(of: c.fecha_recibido.hora_final) ?? 0, inComponent: 0, animated: true)
            
            self.armHoraIniPV.selectRow(self.arrHours.firstIndex(of: c.fecha_armado.hora_inicio) ?? 0, inComponent: 0, animated: true)
            self.armHoraFinPV.selectRow(self.arrHours.firstIndex(of: c.fecha_armado.hora_final) ?? 0, inComponent: 0, animated: true)
            
            self.entHoraIniPV.selectRow(self.arrHours.firstIndex(of: c.fecha_repartido.hora_inicio) ?? 0, inComponent: 0, animated: true)
            self.entHoraFinPV.selectRow(self.arrHours.firstIndex(of: c.fecha_repartido.hora_final) ?? 0, inComponent: 0, animated: true)
            
            self.recFechaTF.text = c.fecha_recibido.fecha_inicio
            self.recFechaFinTF.text = c.fecha_recibido.fecha_final
            
            self.armFechaTF.text = c.fecha_armado.fecha_inicio
            self.armFechaFinTF.text = c.fecha_armado.fecha_final
            
            self.entFechaTF.text = c.fecha_repartido.fecha_inicio
            self.entFechaFinTF.text = c.fecha_repartido.fecha_final
            //self.pickerView(self.myPickerView, didSelectRow: 0, inComponent: 0)
            for day in c.horarios[0]!.days {// dias de recepcion
                switch day.id{
                case 1 :
                    self.doBoolRec = true
                    self.formatoDaysActive(txt: self.recDoLbl, view: self.recDoV, bool: self.doBoolRec)
                case 2 :
                    self.luBoolRec = true
                    self.formatoDaysActive(txt: self.recLuLbl, view: self.recLuV, bool: self.luBoolRec)
                case 3 :
                    self.maBoolRec = true
                    self.formatoDaysActive(txt: self.recMaLbl, view: self.recMaV, bool: self.maBoolRec)
                case 4 :
                    self.miBoolRec = true
                    self.formatoDaysActive(txt: self.recMiLbl, view: self.recMiV, bool: self.miBoolRec)
                case 5 :
                    self.juBoolRec = true
                    self.formatoDaysActive(txt: self.recJuLbl, view: self.recJuV, bool: self.juBoolRec)
                case 6 :
                    self.viBoolRec = true
                    self.formatoDaysActive(txt: self.recViLbl, view: self.recViV, bool: self.viBoolRec)
                case 7 :
                    self.saBoolRec = true
                    self.formatoDaysActive(txt: self.recSaLbl, view: self.recSaV, bool: self.saBoolRec)
                default:
                    print("no pasa")
                }
            }
            for day in c.horarios[1]!.days {// dias de recepcion
                switch day.id{
                case 1 :
                    self.doBoolArm = true
                    self.formatoDaysActive(txt: self.armDoLbl, view: self.armDoV, bool: self.doBoolArm)
                case 2 :
                    self.luBoolArm = true
                    self.formatoDaysActive(txt: self.armLuLbl, view: self.armLuV, bool: self.luBoolArm)
                case 3 :
                    self.maBoolArm = true
                    self.formatoDaysActive(txt: self.armMaLbl, view: self.armMaV, bool: self.maBoolArm)
                case 4 :
                    self.miBoolArm = true
                    self.formatoDaysActive(txt: self.armMiLbl, view: self.armMiV, bool: self.miBoolArm)
                case 5 :
                    self.juBoolArm = true
                    self.formatoDaysActive(txt: self.armJuLbl, view: self.armJuV, bool: self.juBoolArm)
                case 6 :
                    self.viBoolArm = true
                    self.formatoDaysActive(txt: self.armViLbl, view: self.armViV, bool: self.viBoolArm)
                case 7 :
                    self.saBoolArm = true
                    self.formatoDaysActive(txt: self.armSaLbl, view: self.armSaV, bool: self.saBoolArm)
                default:
                    print("no pasa")
                }
            }
            for day in c.horarios[2]!.days {// dias de recepcion
                switch day.id{
                case 1 :
                    self.doBoolEnt = true
                    self.formatoDaysActive(txt: self.entDoLbl, view: self.entDoV, bool: self.doBoolEnt)
                case 2 :
                    self.luBoolEnt = true
                    self.formatoDaysActive(txt: self.entLuLbl, view: self.entLuV, bool: self.luBoolEnt)
                case 3 :
                    self.maBoolEnt = true
                    self.formatoDaysActive(txt: self.entMaLbl, view: self.entMaV, bool: self.maBoolEnt)
                case 4 :
                    self.miBoolEnt = true
                    self.formatoDaysActive(txt: self.entMiLbl, view: self.entMiV, bool: self.miBoolEnt)
                case 5 :
                    self.juBoolEnt = true
                    self.formatoDaysActive(txt: self.entJuLbl, view: self.entJuV, bool: self.juBoolEnt)
                case 6 :
                    self.viBoolEnt = true
                    self.formatoDaysActive(txt: self.entViLbl, view: self.entViV, bool: self.viBoolEnt)
                case 7 :
                    self.saBoolEnt = true
                    self.formatoDaysActive(txt: self.entSaLbl, view: self.entSaV, bool: self.saBoolEnt)
                default:
                    print("no pasa")
                }
            }
            self.hideProgress()
        }
    }
    
    @IBAction func switchRecibirClick(_ sender: Any) {
        //recepcionSV.isHidden = !recepcionSwitch.isOn
        recView.isHidden = !recepcionSwitch.isOn
        if recepcionSwitch.isOn{
            donInt=1
        }else{
            donInt=0
        }
    }
    
    @IBAction func switchArmarClick(_ sender: Any) {
        armView.isHidden = !armadoSwitch.isOn
        if armadoSwitch.isOn{
            armInt=1
        }else{
            armInt=0
        }
    }
    
    @IBAction func switchEntregarClick(_ sender: Any) {
        entView.isHidden = !entregaSwitch.isOn
        if entregaSwitch.isOn{
            entInt=1
        }else{
            entInt=0
        }
    }
    
    @IBAction func switchStatusClick(_ sender: Any) {
        if statusSwitch.isOn{
            statusG=1
        }else{
            statusG=0
        }
    }
    
    @IBAction func guardarClick(_ sender: Any) {
        progress.isHidden=false
        progress.startAnimating()
        //validacion de campos
        if !responsableTF.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El nombre del responsable no puede quedar vacío." )
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
         if !telefonoTF.hasText{
             showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono no puede quedar vacío." )
             return
         }
        if telefonoTF.text!.count>10 || telefonoTF.text!.count<10 {
            showCanonAlert(title: "Datos faltantes", msg: "El campo de teléfono debe contener 10 caracteres." )
            return
        }
        if !direc1TV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "Actualiza la ubicación de recepción de despensas." )
            return
        }else{
            defaults.set(direc1TV.text, forKey: "lastAdressDespRec")
        }
        
        if !descTV.hasText{
            showCanonAlert(title: "Datos faltantes", msg: "El campo \"Descripción\" no puede quedar vacío." )
            return
        }
        
        if zonaId == 1 || zonaId==0{
            showCanonAlert(title: "Datos faltantes", msg: "Selecciona la zona (alcaldía) para la recepción/armado de despensas." )
            return
        }
    
        var horarioRec:HorarioX? = nil
        if donInt == 1 {
            if recFechaTF.text! == "dd/mm/aaaa"{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona una fecha de inicio para recepción de despensas o desactiva la opción \"Solicitar donativos\"." )
                return
            }
            if recFechaFinTF.text! == "dd/mm/aaaa"{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona una fecha de cierre para recepción de despensas o desactiva la opción \"Solicitar donativos\"." )
                return
            }
            if !luBoolRec && !maBoolRec && !miBoolRec && !juBoolRec && !viBoolRec && !saBoolRec && !doBoolRec{
                showCanonAlert(title: "Datos faltantes", msg: "Activa por lo menos un día a la semana para recepción de despensas o desactiva la opción \"Solicitar donativos\"." )
                return
            }
            if openHourRec==""{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de apertura para recepción de despensas o desactiva la opción \"Solicitar donativos\"." )
                return
            }
            if closeHourRec==""{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de cierre para recepción de despensas o desactiva la opción \"Solicitar donativos\"." )
                return
            }
       
            var arrDias:[Dia] = []
            arrDias.append(Dia(id: 1, name: "Domingo", checked: doBoolRec))
            arrDias.append(Dia(id: 2, name: "Lunes", checked: luBoolRec))
            arrDias.append(Dia(id: 3, name: "Martes", checked: maBoolRec))
            arrDias.append(Dia(id: 4, name: "Miércoles", checked: miBoolRec))
            arrDias.append(Dia(id: 5, name: "Jueves", checked: juBoolRec))
            arrDias.append(Dia(id: 6, name: "Viernes", checked: viBoolRec))
            arrDias.append(Dia(id: 7, name: "Sábado", checked: saBoolRec))
            horarioRec = HorarioX(days: arrDias)//, hour_start: openHourRec, hour_end: closeHourRec)
        }
        
        var horarioArm:HorarioX? = nil
        if armInt == 1 {
            if armFechaTF.text! == "dd/mm/aaaa"{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona una fecha de inicio para armado de despensas o desactiva la opción \"Solicitar ayuda para armado\"." )
                return
            }
            if armFechaFinTF.text! == "dd/mm/aaaa"{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona una fecha de cierre para armado de despensas o desactiva la opción \"Solicitar ayuda para armado\"." )
                return
            }
            if !luBoolArm && !maBoolArm && !miBoolArm && !juBoolArm && !viBoolArm && !saBoolArm && !doBoolArm {
                showCanonAlert(title: "Datos faltantes", msg: "Activa por lo menos un día a la semana para armado de despensas o desactiva la opción \"Solicitar ayuda para armado\"." )
                return
            }
            if openHourArm==""{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de apertura para armado de despensas o desactiva la opción \"Solicitar ayuda para armado\"." )
                return
            }
            if closeHourArm==""{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de cierre para armado de despensas o desactiva la opción \"Solicitar ayuda para armado\"." )
                return
            }
       
            var arrDiasArm:[Dia] = []
            arrDiasArm.append(Dia(id: 1, name: "Domingo", checked: doBoolArm))
            arrDiasArm.append(Dia(id: 2, name: "Lunes", checked: luBoolArm))
            arrDiasArm.append(Dia(id: 3, name: "Martes", checked: maBoolArm))
            arrDiasArm.append(Dia(id: 4, name: "Miércoles", checked: miBoolArm))
            arrDiasArm.append(Dia(id: 5, name: "Jueves", checked: juBoolArm))
            arrDiasArm.append(Dia(id: 6, name: "Viernes", checked: viBoolArm))
            arrDiasArm.append(Dia(id: 7, name: "Sábado", checked: saBoolArm))
            horarioArm = HorarioX(days: arrDiasArm)//, hour_start: openHourArm, hour_end: closeHourArm)
        }
        
        var horarioEnt:HorarioX? = nil
        if entInt == 1 {
            if entFechaTF.text! == "dd/mm/aaaa"{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona una fecha de inicio para entrega de despensas o desactiva la opción \"Solicitar apoyo para entrega\"." )
                return
            }
            if entFechaFinTF.text! == "dd/mm/aaaa"{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona una fecha de cierre para entrega de despensas o desactiva la opción \"Solicitar apoyo para entrega\"." )
                return
            }
            if !luBoolEnt && !maBoolEnt && !miBoolEnt && !juBoolEnt && !viBoolEnt && !saBoolEnt && !doBoolEnt {
                showCanonAlert(title: "Datos faltantes", msg: "Activa por lo menos un día a la semana para entrega de despensas o desactiva la opción \"Solicitar apoyo para entrega\"." )
                return
            }
            if openHourEnt==""{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de apertura para entrega de despensas o desactiva la opción \"Solicitar apoyo para entrega\"." )
                return
            }
            if closeHourEnt==""{
                showCanonAlert(title: "Datos faltantes", msg: "Selecciona un horario de cierre para entrega de despensas o desactiva la opción \"Solicitar apoyo para entrega\"." )
                return
            }
            if !direcEntregaTV.hasText{
                showCanonAlert(title: "Datos faltantes", msg: "Actualiza la ubicación de entrega de despensas o desactiva la opción \"Solicitar apoyo para entrega\"." )
                return
            }else{
                defaults.set(direcEntregaTV.text, forKey: "lastAdressDespEnt")
            }
        
            var arrDiasEnt:[Dia] = []
            arrDiasEnt.append(Dia(id: 1, name: "Domingo", checked: doBoolEnt))
            arrDiasEnt.append(Dia(id: 2, name: "Lunes", checked: luBoolEnt))
            arrDiasEnt.append(Dia(id: 3, name: "Martes", checked: maBoolEnt))
            arrDiasEnt.append(Dia(id: 4, name: "Miércoles", checked: miBoolEnt))
            arrDiasEnt.append(Dia(id: 5, name: "Jueves", checked: juBoolEnt))
            arrDiasEnt.append(Dia(id: 6, name: "Viernes", checked: viBoolEnt))
            arrDiasEnt.append(Dia(id: 7, name: "Sábado", checked: saBoolEnt))
            horarioEnt = HorarioX(days: arrDiasEnt) //,hour_start: openHourEnt, hour_end: closeHourEnt)
        }
        
        var horariosG:[HorarioX?]=[]
        horariosG.append(horarioRec)
        horariosG.append(horarioArm)
        horariosG.append(horarioEnt)
        
        let tel = "+52"+telefonoTF.text!
        let latRec = defaults.double(forKey: "latitudeRec")
        let lonRec = defaults.double(forKey: "longitudeRec")
        let latEnt = defaults.double(forKey: "latitudeEnt")
        let lonEnt = defaults.double(forKey: "longitudeEnt")//
        
        let desp = Despensa(responsable: responsableTF.text!,
                            req_donador: donInt,
                            req_armado: armInt,
                            req_entrega: entInt,
                            direccion: direc1TV.text,
                            horarios: horariosG,
                            fecha_recibido: FechaX(fecha_inicio: recFechaTF.text!,
                                                   fecha_final: recFechaFinTF.text!,
                                                   hora_inicio:openHourRec,
                                                   hora_final: closeHourRec),
                            fecha_armado: FechaX(fecha_inicio: armFechaTF.text!,
                                                 fecha_final: armFechaFinTF.text!,
                                                 hora_inicio: openHourArm,
                                                 hora_final:closeHourArm),
                            fecha_repartido: FechaX(fecha_inicio: entFechaTF.text!,
                                                    fecha_final: entFechaFinTF.text!,
                                                    hora_inicio:openHourEnt,
                                                    hora_final: closeHourEnt),
                            user_id: SNId,
                            correo: correoTF.text!,
                            telefono:tel,
                            estatus:statusG,
                            descripcion_despensa: descTV.text!,
                            direccion_entrega: direc1TV.text!,
                            requisitos_donacion: requisDonacionTV.text!,
                            zona: zonaId,
                            longitud: lonRec,
                            latitud: latRec,
                            longitud_entrega: lonEnt,
                            latitud_entrega: latEnt)
        if update{
            print("UPDate:::")
            print(despensaId)
            print(desp)
            putDespensa(request: desp)
        }else{
            print("Create:::")
            print(desp)
            postDespensa(request: desp)
        }
    }
    
    func postDespensa(request: Despensa) {
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/despensas" ) else {
            print("Error formando url despensa")
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
                print("Hubo un error 070")
                self.showCanonAlert(title: "Error", msg: "No se ha dado de alta la actividad de despensas correctamente." + error.debugDescription)
                return
            }
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200 || status == 201{
                print(":;;;;;;;STATUS 200 POST DESPP :::::")
                self.showCanonAlert(title: "Ėxito", msg: "Se ha dado de alta la actividad de despensas correctamente.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.alertFields?.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                print(":;;;;;;;ERROR STATUS POST DESPP :::::")
                print(String((response as! HTTPURLResponse).statusCode))
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Error", msg: "No se ha dado de alta la actividad de despensas correctamente." )
            }
        }
        tarea.resume()
    }
    
    func putDespensa(request: Despensa) {
        let dictionary = request
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/act-voluntariado/despensas/"+String(despensaId) ) else {
            print("Error formando url despensa")
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
                print("Hubo un error 070")
                self.showCanonAlert(title: "Error", msg: "No se ha actualizado de alta la actividad de despensas correctamente." + error.debugDescription)
                return
            }
            let status = (response as! HTTPURLResponse).statusCode
            if status == 200 || status == 201{
                print(":;;;;;;;STATUS 200 PUT DESPENSA :::::")
                self.showCanonAlert(title: "Ėxito", msg: "Se ha actualizado la actividad de despensas correctamente.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                    self.alertFields?.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                print(":;;;;;;;ERROR STATUS PUT DESPENSA :::::")
                print(String((response as! HTTPURLResponse).statusCode))
                let responseData = String(data: data!, encoding: String.Encoding.utf8)
                print(responseData!)
                self.showCanonAlert(title: "Error", msg: "No se ha actualizado la actividad de despensas correctamente." )
            }
        }
        tarea.resume()
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        let tapG1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFLocUpdate1))
        updateDirec1SV.addGestureRecognizer(tapG1)
        let tapG2 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFLocUpdate2))
        updateDirecEntregaSV.addGestureRecognizer(tapG2)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFLu))
        recLuV.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFMa))
        recMaV.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFMi))
        recMiV.addGestureRecognizer(tap3)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFJu))
        recJuV.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFVi))
        recViV.addGestureRecognizer(tap5)
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFSa))
        recSaV.addGestureRecognizer(tap6)
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFDo))
        recDoV.addGestureRecognizer(tap7)
        
        let tap11 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFLuArm))
        armLuV.addGestureRecognizer(tap11)
        let tap22 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFMaArm))
        armMaV.addGestureRecognizer(tap22)
        let tap33 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFMiArm))
        armMiV.addGestureRecognizer(tap33)
        let tap44 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFJuArm))
        armJuV.addGestureRecognizer(tap44)
        let tap55 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFViArm))
        armViV.addGestureRecognizer(tap55)
        let tap66 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFSaArm))
        armSaV.addGestureRecognizer(tap66)
        let tap77 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFDoArm))
        armDoV.addGestureRecognizer(tap77)
        
        let tap111 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFLuEnt))
        entLuV.addGestureRecognizer(tap111)
        let tap222 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFMaEnt))
        entMaV.addGestureRecognizer(tap222)
        let tap333 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFMiEnt))
        entMiV.addGestureRecognizer(tap333)
        let tap444 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFJuEnt))
        entJuV.addGestureRecognizer(tap444)
        let tap555 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFViEnt))
        entViV.addGestureRecognizer(tap555)
        let tap666 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFSaEnt))
        entSaV.addGestureRecognizer(tap666)
        let tap777 = UITapGestureRecognizer(target: self, action: #selector(Actividades_CrearDespensa.TFDoEnt))
        entDoV.addGestureRecognizer(tap777)
        
        datePicker.datePickerMode = .date
        datePicker2.datePickerMode = .date
        datePicker3.datePickerMode = .date
        datePicker4.datePickerMode = .date
        datePicker5.datePickerMode = .date
        datePicker6.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker2.addTarget(self, action: #selector(dateChange2(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker3.addTarget(self, action: #selector(dateChange3(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker4.addTarget(self, action: #selector(dateChange4(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker5.addTarget(self, action: #selector(dateChange5(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker6.addTarget(self, action: #selector(dateChange6(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker2.frame.size = CGSize(width: 0, height: 300)
        datePicker3.frame.size = CGSize(width: 0, height: 300)
        datePicker4.frame.size = CGSize(width: 0, height: 300)
        datePicker5.frame.size = CGSize(width: 0, height: 300)
        datePicker6.frame.size = CGSize(width: 0, height: 300)
        
        if #available(iOS 13.4, *) {
          datePicker.preferredDatePickerStyle = .wheels
          datePicker2.preferredDatePickerStyle = .wheels
          datePicker3.preferredDatePickerStyle = .wheels
          datePicker4.preferredDatePickerStyle = .wheels
          datePicker5.preferredDatePickerStyle = .wheels
          datePicker6.preferredDatePickerStyle = .wheels
        }
        
        recFechaTF.inputView=datePicker
        recFechaFinTF.inputView=datePicker2
    
        armFechaTF.inputView=datePicker3
        armFechaFinTF.inputView=datePicker4
    
        entFechaTF.inputView=datePicker5
        entFechaFinTF.inputView=datePicker6
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        recFechaTF.text=formatDate(date: datePicker.date)
    }
    @objc func dateChange2(datePicker: UIDatePicker) {
        recFechaFinTF.text=formatDate(date: datePicker.date)
    }
    @objc func dateChange3(datePicker: UIDatePicker) {
        armFechaTF.text=formatDate(date: datePicker.date)
    }
    @objc func dateChange4(datePicker: UIDatePicker) {
        armFechaFinTF.text=formatDate(date: datePicker.date)
    }
    @objc func dateChange5(datePicker: UIDatePicker) {
        entFechaTF.text=formatDate(date: datePicker.date)
    }
    @objc func dateChange6(datePicker: UIDatePicker) {
        entFechaFinTF.text=formatDate(date: datePicker.date)
    }
    
    func formatDate(date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    @objc func TFLocUpdate1(gesture: UIGestureRecognizer) {
        print("Actualizar direccion click")
        let storyboard = UIStoryboard(name: "CrearComedorSB", bundle: Bundle(for: CrearComedor_Mapa.self))
        let view = storyboard.instantiateViewController(withIdentifier: "mapaSB") as! CrearComedor_Mapa
        view.type="despensaRecepcion"
        self.navigationController?.pushViewController(view, animated: true)
        //performSegue(withIdentifier: "map", sender: nil)
    }
    
    @objc func TFLocUpdate2(gesture: UIGestureRecognizer) {
        print("Actualizar direccion 2 click")
        let storyboard = UIStoryboard(name: "CrearComedorSB", bundle: Bundle(for: CrearComedor_Mapa.self))
        let view = storyboard.instantiateViewController(withIdentifier: "mapaSB") as! CrearComedor_Mapa
        view.type="despensaEntrega"
        self.navigationController?.pushViewController(view, animated: true)
        //performSegue(withIdentifier: "map", sender: nil)
    }
    //Dias Recepcion
    @objc func TFLu(gesture: UIGestureRecognizer) {
        luBoolRec = !luBoolRec
        formatoDaysActive(txt: recLuLbl, view: recLuV, bool: luBoolRec)
    }
    @objc func TFMa(gesture: UIGestureRecognizer) {
        maBoolRec = !maBoolRec
        formatoDaysActive(txt: recMaLbl, view: recMaV, bool: maBoolRec)
    }
    @objc func TFMi(gesture: UIGestureRecognizer) {
        miBoolRec = !miBoolRec
        formatoDaysActive(txt: recMiLbl, view: recMiV, bool: miBoolRec)
    }
    @objc func TFJu(gesture: UIGestureRecognizer) {
        juBoolRec = !juBoolRec
        formatoDaysActive(txt: recJuLbl, view: recJuV, bool: juBoolRec)
    }
    @objc func TFVi(gesture: UIGestureRecognizer) {
        viBoolRec = !viBoolRec
        formatoDaysActive(txt: recViLbl, view: recViV, bool: viBoolRec)
    }
    @objc func TFSa(gesture: UIGestureRecognizer) {
        saBoolRec = !saBoolRec
        formatoDaysActive(txt: recSaLbl, view: recSaV, bool: saBoolRec)
    }
    @objc func TFDo(gesture: UIGestureRecognizer) {
        doBoolRec = !doBoolRec
        formatoDaysActive(txt: recDoLbl, view: recDoV, bool: doBoolRec)
    }
    //Dias Armado
    @objc func TFLuArm(gesture: UIGestureRecognizer) {
        luBoolArm = !luBoolArm
        formatoDaysActive(txt: armLuLbl, view: armLuV, bool: luBoolArm)
    }
    @objc func TFMaArm(gesture: UIGestureRecognizer) {
        maBoolArm = !maBoolArm
        formatoDaysActive(txt: armMaLbl, view: armMaV, bool: maBoolArm)
    }
    @objc func TFMiArm(gesture: UIGestureRecognizer) {
        miBoolArm = !miBoolArm
        formatoDaysActive(txt: armMiLbl, view: armMiV, bool: miBoolArm)
    }
    @objc func TFJuArm(gesture: UIGestureRecognizer) {
        juBoolArm = !juBoolArm
        formatoDaysActive(txt: armJuLbl, view: armJuV, bool: juBoolArm)
    }
    @objc func TFViArm(gesture: UIGestureRecognizer) {
        viBoolArm = !viBoolArm
        formatoDaysActive(txt: armViLbl, view: armViV, bool: viBoolArm)
    }
    @objc func TFSaArm(gesture: UIGestureRecognizer) {
        saBoolArm = !saBoolArm
        formatoDaysActive(txt: armSaLbl, view: armSaV, bool: saBoolArm)
    }
    @objc func TFDoArm(gesture: UIGestureRecognizer) {
        doBoolArm = !doBoolArm
        formatoDaysActive(txt: armDoLbl, view: armDoV, bool: doBoolArm)
    }
    //Dias Entrega
    @objc func TFLuEnt(gesture: UIGestureRecognizer) {
        luBoolEnt = !luBoolEnt
        formatoDaysActive(txt: entLuLbl, view: entLuV, bool: luBoolEnt)
    }
    @objc func TFMaEnt(gesture: UIGestureRecognizer) {
        maBoolEnt = !maBoolEnt
        formatoDaysActive(txt: entMaLbl, view: entMaV, bool: maBoolEnt)
    }
    @objc func TFMiEnt(gesture: UIGestureRecognizer) {
        miBoolEnt = !miBoolEnt
        formatoDaysActive(txt: entMiLbl, view: entMiV, bool: miBoolEnt)
    }
    @objc func TFJuEnt(gesture: UIGestureRecognizer) {
        juBoolEnt = !juBoolEnt
        formatoDaysActive(txt: entJuLbl, view: entJuV, bool: juBoolEnt)
    }
    @objc func TFViEnt(gesture: UIGestureRecognizer) {
        viBoolEnt = !viBoolEnt
        formatoDaysActive(txt: entViLbl, view: entViV, bool: viBoolEnt)
    }
    @objc func TFSaEnt(gesture: UIGestureRecognizer) {
        saBoolEnt = !saBoolEnt
        formatoDaysActive(txt: entSaLbl, view: entSaV, bool: saBoolEnt)
    }
    @objc func TFDoEnt(gesture: UIGestureRecognizer) {
        doBoolEnt = !doBoolEnt
        formatoDaysActive(txt: entDoLbl, view: entDoV, bool: doBoolEnt)
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
        formatoDaysViews(view:recLuV)
        formatoDaysViews(view:recMaV)
        formatoDaysViews(view:recMiV)
        formatoDaysViews(view:recJuV)
        formatoDaysViews(view:recViV)
        formatoDaysViews(view:recSaV)
        formatoDaysViews(view:recDoV)
        formatoDaysViews(view:armLuV)
        formatoDaysViews(view:armMaV)
        formatoDaysViews(view:armMiV)
        formatoDaysViews(view:armJuV)
        formatoDaysViews(view:armViV)
        formatoDaysViews(view:armSaV)
        formatoDaysViews(view:armDoV)
        formatoDaysViews(view:entLuV)
        formatoDaysViews(view:entMaV)
        formatoDaysViews(view:entMiV)
        formatoDaysViews(view:entJuV)
        formatoDaysViews(view:entViV)
        formatoDaysViews(view:entSaV)
        formatoDaysViews(view:entDoV)
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
        zonaPV.delegate=self
        rechoraIniPV.delegate=self
        rechoraFinPV.delegate=self
        armHoraIniPV.delegate=self
        armHoraFinPV.delegate=self
        entHoraIniPV.delegate=self
        entHoraFinPV.delegate=self
        
        zonaPV.dataSource=self
        rechoraIniPV.dataSource=self
        rechoraFinPV.dataSource=self
        armHoraIniPV.dataSource=self
        armHoraFinPV.dataSource=self
        entHoraIniPV.dataSource=self
        entHoraFinPV.dataSource=self
        
        correoTF.delegate=self
        telefonoTF.delegate=self
        responsableTF.delegate=self
        requisDonacionTV.delegate=self
        descTV.delegate=self
        direc1TV.delegate=self
        direcEntregaTV.delegate=self
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
        correoTF.inputAccessoryView = doneToolbar
        telefonoTF.inputAccessoryView = doneToolbar
        responsableTF.inputAccessoryView = doneToolbar
        requisDonacionTV.inputAccessoryView = doneToolbar
        descTV.inputAccessoryView = doneToolbar
        direc1TV.inputAccessoryView = doneToolbar
        direcEntregaTV.inputAccessoryView = doneToolbar
        recFechaTF.inputAccessoryView = doneToolbar
        recFechaFinTF.inputAccessoryView = doneToolbar
        armFechaTF.inputAccessoryView = doneToolbar
        armFechaFinTF.inputAccessoryView = doneToolbar
        entFechaTF.inputAccessoryView = doneToolbar
        entFechaFinTF.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        correoTF.resignFirstResponder()
        telefonoTF.resignFirstResponder()
        responsableTF.resignFirstResponder()
        requisDonacionTV.resignFirstResponder()
        descTV.resignFirstResponder()
        direc1TV.resignFirstResponder()
        direcEntregaTV.resignFirstResponder()
        recFechaTF.resignFirstResponder()
        recFechaFinTF.resignFirstResponder()
        armFechaTF.resignFirstResponder()
        armFechaFinTF.resignFirstResponder()
        entFechaTF.resignFirstResponder()
        entFechaFinTF.resignFirstResponder()
    }
}

extension Actividades_CrearDespensa: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        switch pickerView {
        case zonaPV:
            count = arrZonas.count
        default:
            count = arrHours.count
            break
        }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case zonaPV:
            return arrZonas[row]
        default:
            return arrHours[row]
        }
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case zonaPV:
            print("selecciono zona")
            zonaId=mapaIdZonas[arrZonas[row]] ?? 1
        case rechoraIniPV:
            openHourRec=arrHours[row]
        case rechoraFinPV:
            closeHourRec=arrHours[row]
        case armHoraIniPV:
            openHourArm=arrHours[row]
        case armHoraFinPV:
            closeHourArm=arrHours[row]
        case entHoraIniPV:
            openHourEnt=arrHours[row]
        case entHoraFinPV:
            closeHourEnt=arrHours[row]
        default:
            print("selecciono otro")
        }
    }
    
}

//MARK: - TextField Delegate Implementation
extension Actividades_CrearDespensa: UITextFieldDelegate {
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin editing")
    }
    
}

extension Actividades_CrearDespensa: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == requisDonacionTV{
            requisDonacionCountLbl.text="\(textView.text.count)/250"
            if textView.text.count>250 {
                textView.text=textView.text.substring(to: 250)
                requisDonacionCountLbl.text="\(textView.text.count)/250"
            }
        }
        
        if textView == descTV{
            descCountLbl.text="\(textView.text.count)/250"
            if textView.text.count>250 {
                textView.text=textView.text.substring(to: 250)
                descCountLbl.text="\(textView.text.count)/250"
            }
        }
    }
}

struct Despensa: Codable {
    var responsable: String
    var req_donador: Int
    var req_armado: Int
    var req_entrega: Int
    var direccion: String
    var horarios: [HorarioX?]
    var fecha_recibido: FechaX
    var fecha_armado: FechaX
    var fecha_repartido: FechaX
    var user_id: Int
    var correo: String
    var telefono: String
    var estatus:Int
    var descripcion_despensa:String
    var direccion_entrega:String
    var requisitos_donacion:String
    var zona: Int
    var longitud: Double
    var latitud: Double
    var longitud_entrega: Double
    var latitud_entrega: Double
}

struct FechaX: Codable {
    var fecha_inicio: String
    var fecha_final: String
    var hora_inicio:String
    var hora_final:String
}

struct HorarioX: Codable {
    var days: [Dia]
}
