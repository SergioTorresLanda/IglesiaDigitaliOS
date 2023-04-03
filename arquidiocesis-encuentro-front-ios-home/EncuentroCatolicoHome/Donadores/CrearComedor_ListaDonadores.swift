//
//  CrearComedor_ListaDonadores.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 28/03/23.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class CrearComedor_ListaDonadores: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var donadoresTV: UITableView!
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    var alertFields : AcceptAlert?
    var arrDonadores:[Donador]=[]
    var comedorId=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatoHeadView()
        donadoresTV.delegate=self
        donadoresTV.dataSource=self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getInfoCom()
    }
    
    func getInfoCom() {
        showProgress()
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
                        let don=Donador(id: Int(object["FIDONANTEID"] as? String ?? "0"),
                                        bancarios: "",
                                        comentarios: object["FCCOMENTARIOS"] as? String ?? "",
                                        correo: object["FCCORREO"] as? String ?? "",
                                        comedor_id: Int(comedorId)!,
                                        nombre: object["FCNOMBRE"] as? String ?? "",
                                        telefono: object["FCTELEFONO"] as? String ?? "",
                                        tipo_don: "En especie",
                                        user_id: Int(object["FIUSERID"] as? String ?? "0"))
                        arrDonadores.append(don)
                    }
                }
                self.hideProgress()
                DispatchQueue.main.async {
                    self.donadoresTV.reloadData()
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
        print("")
        return arrDonadores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DONCELL", for: indexPath) as! DonadorTVC
        //cell.delegate = self
        cell.selectionStyle = .none
       
        if indexPath.row >= arrDonadores.startIndex && indexPath.row < arrDonadores.endIndex {
                print(":::SETUPP Comedores::: ")
                print(String(indexPath.row))
            cell.setDonador(data: arrDonadores[indexPath.row])
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
