//
//  CrearComedor_ListaVoluntarios.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 29/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class CrearComedor_ListaVoluntarios: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var volunsTV: UITableView!
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var alertFields : AcceptAlert?
    var arrVoluntarios:[Voluntario]=[]
    var comedorId="00"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatoHeadView()
        volunsTV.delegate=self
        volunsTV.dataSource=self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getInfoCom()
    }
    
    func getInfoCom() {
        showProgress()
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
                        var multiUser : [Invitado] = []
                        let invs: [[String:Any]] = object["FCMULTIUSER"] as! [[String:Any]]
                        for v in invs {
                            let n = v["nombre"] as? String ?? "noName"
                            let tel = v["telefono"] as? String ?? "noPhone"
                            multiUser.append(Invitado(nombre: n, telefono: tel))
                        }
                        let vol=Voluntario(id: 0,
                                           correo: object["FCCORREO"] as? String ?? "",
                                           comedor_id: 0,
                                           voluntario: object["FCVOLUNTARIO"] as? String ?? "",
                                           telefono: object["FCTELEFONO"] as? String ?? "",
                                           multiuser: multiUser,
                                           user_id: 0,
                                           responsable: "",
                                           nombre_comedor: "",
                                           direccion: "")
                        arrVoluntarios.append(vol)
                        if let inv = object["FCMULTIUSER"] as? [Invitado]{
                            print("parsea a invitado")
                            print(inv)
                        }else{
                            print("no parsea a invitado")
                        }
                    }
                }
                self.hideProgress()
                DispatchQueue.main.async {
                    self.volunsTV.reloadData()
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
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
      ////tabla
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          print("NORIS::")
          print(arrVoluntarios.count)
          return arrVoluntarios.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          print("c4r@")
          let cell = tableView.dequeueReusableCell(withIdentifier: "VOLCELL", for: indexPath) as! VoluntariosCell
          //cell.delegate = self
          cell.selectionStyle = .none
         
          if indexPath.row >= arrVoluntarios.startIndex && indexPath.row < arrVoluntarios.endIndex {
                  print(":::SETUPP Voluntss::: ")
                  print(String(indexPath.row))
              cell.setVoluntario(data: arrVoluntarios[indexPath.row])
              //cell.delegate=self
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
      
      func formatoHeadView(){
          viewHead.layer.cornerRadius = 30
          viewHead.layer.shadowRadius = 5
          viewHead.layer.shadowOpacity = 0.5
          viewHead.layer.shadowColor = UIColor.black.cgColor
          viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
      }

  }
