//
//  CrearModulo_ListaParticipantes.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 24/05/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class CrearModulo_ListaParticipantes: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var nothingLbl: UILabel!
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tipoPV: UIPickerView!
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    let arrType=["Todos","Donadores","Voluntarios","Participantes"]
    var alertFields : AcceptAlert?
    var arrActores:[Actor]=[]
    var arrActoresFiltro:[Actor]=[]
    var actividadId=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatoHeadView()
        // Do any additional setup after loading the view.
        tipoPV.delegate=self
        tipoPV.dataSource=self
        tableView.delegate=self
        tableView.dataSource=self
        nothingLbl.isHidden=true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getInfoActores()
    }
    
    func getInfoActores() {
        arrActores=[]
        arrActoresFiltro=[]
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
                        let act=Actor(nombre: object["nombre"] as? String ?? "noName",
                                      correo: object["correo"] as? String ?? "noEmail",
                                      telefono: object["telefono"] as? String ?? "noPhone",
                                      status: object["status"] as? Int ?? 0,
                                      comentarios: object["comentarios"] as? String ?? "noComments",
                                      user_id: object["user_id"] as? Int ?? 0,
                                      evento_id: object["evento_id"] as? Int ?? 0,
                                      tipo_actor: object["tipo_actor"] as? Int ?? 0,
                                      actor_id: object["actor_id"] as? Int ?? 0)
                                      
                        arrActores.append(act)
                    }
                }
                arrActoresFiltro=arrActores
                DispatchQueue.main.async {
                    self.hideProgress()
                    self.hideOrShowLbl()
                    self.tableView.reloadData()
                }
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

    func filterData(type:Int){
        print("selecciono::")
        let t=arrType[type]
        print(t)
        switch type {
            case 1://don
            print("selecciono dons")
            arrActoresFiltro=arrActores.filter{$0.tipo_actor==1}
            case 2://vol
            print("selecciono voluns")
            arrActoresFiltro=arrActores.filter{$0.tipo_actor==2}
            case 3://participante
            print("selecciono part")
            arrActoresFiltro=arrActores.filter{$0.tipo_actor==3}
        default://0
            arrActoresFiltro=arrActores
        }
        hideOrShowLbl()
        tableView.reloadData()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension CrearModulo_ListaParticipantes: UIPickerViewDelegate, UIPickerViewDataSource {
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
        filterData(type: row)
        // closeHour=arrType[row]
    }
    
    ////tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("")
        return arrActoresFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ACTORCELL", for: indexPath) as! ActorCell
        //cell.delegate = self
        cell.selectionStyle = .none
       
        if indexPath.row >= arrActoresFiltro.startIndex && indexPath.row < arrActoresFiltro.endIndex {
                print(":::SETUPP ACTOR::: ")
                print(String(indexPath.row))
            cell.setData(data: arrActoresFiltro[indexPath.row])
        }else{
            print("ERROR INDEX PATH: "+String(indexPath.row))
        }
        return cell
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
    
    func hideOrShowLbl(){
        if arrActoresFiltro.count>0{
            nothingLbl.isHidden=true
        }else{
            nothingLbl.isHidden=false
        }
    }
    
    func formatoHeadView(){
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
    }

    
}
