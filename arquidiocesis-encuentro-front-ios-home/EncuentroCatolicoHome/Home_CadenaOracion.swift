//
//  prayerChains.swift
//  Cadena de Oracion
//
//  Created by Branchbit on 22/03/21.
//

import UIKit
import RealmSwift
import AlamofireImage
import EncuentroCatolicoVirtualLibrary

class Home_CadenaOracion: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cardsCollection: UICollectionView!
    @IBOutlet weak var btnCreatePray: UIButton!
    @IBOutlet weak var iconCreatePray: UIImageView!
    @IBOutlet weak var customNavBar: UIView!
    
    var dbPrayers: Results<prayerChainModel>!
    let realm = try! Realm()
    var userName: String?
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var refreshControl = UIRefreshControl()
    var allData: prayerDataStruct?
    var arrayMyPraye: [Datum] = []
    var persons = ["Héctor Adomantiz Pérez", "Pedro Gomez Pérez", "Juan Hernandez Gomez"]
    var publish = "NO"
    let transition = SlideTransition()
    let imageURLDeafult = URL(string: "")
    var statePray: [Bool] = []
    var alertFields : AcceptAlert?
    
    static let singleton = Home_CadenaOracion()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionDelegate()
        cardsCollection.isHidden = true
        collection.delegate = self
        collection.dataSource = self
        
        collection.register(UINib(nibName: "prayerCell", bundle: Bundle.local), forCellWithReuseIdentifier: "prayerCell")
        collection.register(UINib(nibName: "newPrayerCell", bundle: Bundle.local), forCellWithReuseIdentifier: "newPrayerCell")
        NotificationCenter.default.addObserver(self, selector: #selector(getPrayers), name: NSNotification.Name(rawValue: "PrayerSend"), object: nil)
        try! realm.write {
          realm.deleteAll()
        }
        dbPrayers = realm.objects(prayerChainModel.self).sorted(byKeyPath: "id", ascending: false)
        getPrayers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        //dbPrayers = realm.objects(prayerChainModel.self).sorted(byKeyPath: "id", ascending: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            print(":::::::: HAY " + String(self.dbPrayers!.count) + " ELEMENTOSS ::::::")
            
        })
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collection.refreshControl = refreshControl
    }
    
    @objc func getPrayers(){
        showLoading()
        statePray=[]
        sendRESTRequest2(endPoint: "\(APIType.shared.User())/prayers", parameters: [:])
    }
    
    private func setupCollectionDelegate() {
       // cardsCollection.register(UINib(nibName: "MyPrayerCell", bundle: Bundle.local), forCellWithReuseIdentifier: "MYPRAYERCELL")
        cardsCollection.register(UINib(nibName: "MyPrayerCell", bundle: Bundle.local), forCellWithReuseIdentifier: "MyPray")
        cardsCollection.delegate = self
        cardsCollection.dataSource = self
    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp -40 =105
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func hideLoading(error: String?){
        refreshControl.endRefreshing()
        if error != nil{
            self.alert.dismiss(animated: true, completion: {
                let errorAlert = UIAlertController(title: "Alerta", message: error!, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            })
        }else{
            self.alert.dismiss(animated: true, completion: nil)
        }
    }
    
// MARK: SERVICES FUNCTIONS -
    func sendRESTRequest(endPoint: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            print("SendREST 1 SendREST 1 SendREST 1 SendREST 1 SendREST 2 SendREST 2 SendREST 2 ")
            
        })
        let singleton = ModalPrayController.singleton
        guard let endpoint: URL = URL(string: endPoint) else { return }
        var request = URLRequest(url: endpoint)
        request.timeoutInterval = 10
        let parameterDictionary: [String : Any] = [
            "fiel_id" : UserDefaults.standard.value(forKey: "id") ?? 1,
            "fiel_name" : UserDefaults.standard.value(forKey: "email") ?? "?",
            "reason" : 5,
            "description": singleton.sendText
        ]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        
        request.httpBody = httpBody
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    print("SendREST 200 ")
                    
                })
                DispatchQueue.main.async {
                    self.alert.dismiss(animated: true, completion: nil)
//                    self.sendRESTRequest(endPoint: "https://api-develop.arquidiocesis.mx/prayers", parameters: [:])
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                        self.getPrayers()
                    })
                    // self.hideLoading(error: nil)
                    APIType.shared.refreshToken()
                }
            } else {
                DispatchQueue.main.async{
                    var msgError = ""
                    switch (response as! HTTPURLResponse).statusCode {
                    case 400:
                        msgError = "Servicio no disponible, intente más tarde"
                    case 401:
                        msgError = "Acceso no autorizado "
                    case 403:
                        msgError = "Acceso denegado"
                    case 404:
                        msgError = "Servicio no encontrado, intente más tarde"
                    case 500:
                        msgError = "Error interno del servidor, por favor intente más tarde"
                    default:
                        msgError = "Ocurrió un error desconocido, intente más tarde"
                    }
                    self.alert.dismiss(animated: true, completion: nil)
                    print(msgError)
                    // self.hideLoading(error: msgError)
                    APIType.shared.refreshToken()
                    
                }
            }
        }
        tarea.resume()
    }
    
    func sendRESTRequest2(endPoint: String, parameters: [String: Any]){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            print("SendREST 2 SendREST 2 SendREST 2 SendREST 2 SendREST 2 SendREST 2 SendREST 2 ")
            
        })
        arrayMyPraye.removeAll()
        let endpoint: URL = URL(string: endPoint)!
        var request = URLRequest(url: endpoint)
        request.timeoutInterval = 4
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("Error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
            
                DispatchQueue.main.async {
                    guard let allData = data else { return }
                    guard let userHome: prayerDataStruct = try? JSONDecoder().decode(prayerDataStruct.self, from: allData) else { return }
                    self.allData = userHome
                    for element in userHome.data {
                        //let item = self.realm.objects(prayerChainModel.self).filter("id = %@", element.id)
                        let dbModel = prayerChainModel()
                        dbModel.prayer = element.datumDescription
                        dbModel.id = element.id
                        dbModel.title = element.fielName
                        dbModel.people = String(element.reaction.like)
                        dbModel.date = element.creationDate
                        dbModel.imageFiel = element.imageName ?? " "
                        //dbModel.reaction = item.first?.reaction ?? false
                        dbModel.reaction = (element.praying != 0)
                        
                        let valueOfText = UserDefaults.standard.string(forKey: "COMPLETENAME") ?? "NOVALUE"
                        self.statePray.append((element.praying != 0))
                        
                        if valueOfText == element.fielName {
                            self.arrayMyPraye.append(element)
                            print("se va agregar un elemento", valueOfText, element.fielName)
                        }
                        
                        try! self.realm.write {
                            self.realm.add(dbModel, update: .modified)
                        }
                        print("DB MODEL...DB MODEL...DB MODEL...DB MODEL...DB MODEL...DB MODEL...")
                        print(dbModel)
                    }
                    
                    print("****", self.arrayMyPraye)
                    self.collection.reloadData()
                    self.hideLoading(error: nil)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    print("STATUS 200 PRAYERS STATUS 200 PRAYERSSTATUS 200 PRAYERSSTATUS 200 PRAYERSSTATUS 200 PRAYERS")
                    //guard let userHome2: prayerDataStruct = try? JSONDecoder().decode(prayerDataStruct.self, from: data!) else { return }
                    //print(userHome2)
                })
            } else {
                
                DispatchQueue.main.async{
                    var msgError = ""
                    switch (response as! HTTPURLResponse).statusCode {
                    case 400:
                        msgError = "Error del servidor, intente más tarde"
                    case 401:
                        msgError = "Acceso no autorizado "
                    case 403:
                        msgError = "Acceso denegado"
                    case 404:
                        msgError = "Servicio no encontrado, intente más tarde"
                    case 500:
                        msgError = "Error interno del servidor, por favor intente más tarde"
                    default:
                        msgError = "Ocurrió un error desconocido, intente más tarde"
                    }
                    self.hideLoading(error: msgError)
                    APIType.shared.refreshToken()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    print("NO STATUS 200 NO PRAYERS STATUS NO 200 PRAYERS NO STATUS 200 PRAYER NO STATUS 200 PRAYERS NO STATUS 200 PRAYERS:::;;;;;;;;")
                    print(String((response as! HTTPURLResponse).statusCode))
                 })
            }
        }
        tarea.resume()
    }
    
    @objc func showPersonList(sender: UIButton) {
        print(sender.tag)
        let view = ModalPrayController.showModal(type: "LIST", personList: persons)
        self.present(view, animated: true, completion: nil)
    }
    
    @objc func refresh(){
        getPrayers()
    }
    
    @objc func prayAction(sender: UIButton) {
        print("PRAY actION :::")
        print(sender.tag)
    }
    
    @objc func reactToPromise(sender: UIButton) {
        print(":::TAGG:::")
        print(sender.tag)
        let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if newUser {//esta logueado proceder
          
        let index0 = Int(sender.accessibilityLabel ?? "0")
        let index = index0!
        //let index = indexNeg!+1
      
        print(":::INDEX:::")
        print(String(index))
        print(":::state count:::")
        print(statePray.count)
        print(":::new taggg:::")
        /*if statePray[index] == false {
            statePray[index] = true
        }else{
            statePray[index] = false
        }*/
        let cell = self.collection.cellForItem(at: [0,Int(sender.accessibilityHint ?? "1")!]) as! prayerCell
        cell.loading.isHidden = false
        cell.loading.startAnimating()
        sender.isUserInteractionEnabled = false
        
        //var react = true
        /*if sender.accessibilityLabel == "Reacted"{
            react = false
        }*/
        
        let id = self.dbPrayers[index].id
        let item = self.realm.objects(prayerChainModel.self).filter("id = %@", id).first!
        let endpoint: URL = URL(string: "\(APIType.shared.User())/prayers/\(sender.tag)/reaction")!
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            print("URLL:::;;;;;;;")
            print("\(APIType.shared.User())/prayers/\(sender.tag)/reaction")
         })
        var request = URLRequest(url: endpoint)
        request.timeoutInterval = 3
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameterDictionary: [String : Any] = [
            "fiel_id" : UserDefaults.standard.value(forKey: "id") ?? 1,
            "fiel_name" : UserDefaults.standard.value(forKey: "email") ?? "?",
            "reaction" : !item.reaction
        ]
        print(":::BODYYYYYY:::")
        print(parameterDictionary)
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.httpMethod = "POST"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in

            if error != nil {
                print("Error")
                return
            }

            if (response as! HTTPURLResponse).statusCode == 200 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    print("status 2000 status 2000 status 2000 status 2000 status 2000")
                 })
           
                DispatchQueue.main.async {

                    if item.reaction {
                        sender.accessibilityLabel = "Cancel React"
                        //let cell = self.collection.cellForItem(at: [0,Int(sender.accessibilityHint ?? "1")!]) as! prayerCell
                        let item = self.realm.objects(prayerChainModel.self).filter("id = %@", sender.tag)
                        let realm = try! Realm()
                        if let workout = item.first {
                            try! realm.write {
                                workout.people = String(Int(workout.people)! - 1)
                                workout.reaction = false
                                self.statePray[index] = false
                            }
                        }
                    }else{
                        sender.accessibilityLabel = "Reacted"
                        //let cell = self.collection.cellForItem(at: [0,Int(sender.accessibilityHint ?? "1")!]) as! prayerCell
                   
                        let item = self.realm.objects(prayerChainModel.self).filter("id = %@", sender.tag)
                        let realm = try! Realm()
                        if let workout = item.first {
                            try! realm.write {
                                workout.people = String(Int(workout.people)! + 1)
                                workout.reaction = true
                                self.statePray[index] = true
                            }
                        }
                    }
                    
                    cell.loading.stopAnimating()
                    cell.loading.isHidden = true
                    sender.isUserInteractionEnabled = true
                    self.collection.reloadData()
                    print("Reacción completada")
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                    print("status NO 2000 status NO 2000 status NO 2000 status NO 2000 status 2000")
                    guard let s = (response as? HTTPURLResponse)?.statusCode else {return}
                    print("STATUSSS ::: ")
                    print(String(s))
                 })
                DispatchQueue.main.async{
                    cell.loading.stopAnimating()
                    cell.loading.isHidden = true
                    sender.isUserInteractionEnabled = true
                    APIType.shared.refreshToken()
                }
             
            }
        }
            tarea.resume()
            
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para interactuar con el contenido.")
        }
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createPrayAction(_ sender: Any) {
        let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if newUser {//esta logueado proceder
            let view = ModalPrayController.showModal(type: "ADD", personList: persons)
            view.transitioningDelegate = self
            self.present(view, animated: true, completion: nil)
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para crear una oración.")
        }
    
    }
    
    func showCanonAlert(title:String, msg:String){
        alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
        alertFields!.view.backgroundColor = .clear
        self.present(alertFields!, animated: true)
    }
    
}

extension Home_CadenaOracion:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if dbPrayers!.count + 1 == 1 {
            self.collection.setEmptyMessage("No hay oraciones")
        } else {
            self.collection.restore()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            print(":::::::: HAY " + String(self.dbPrayers!.count) + " ORACIONESS ::::::")
            print(":::::::: HAY " + String(self.statePray.count) + " STATEPRAYY ::::::")
            
        })
        return dbPrayers!.count //+ 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "prayerCell", for: indexPath) as! prayerCell
            let handsOff = UIImage(named: "handsOff", in: Bundle.local, compatibleWith: nil)
            let handsOn = UIImage(named: "handsOn", in: Bundle.local, compatibleWith: nil)
            let prayer = dbPrayers[indexPath.item]//dbPrayers[indexPath.row - 1] todos los index llevaban - 1 si se muestran mis oracciones
            let persons = Int(prayer.people) ?? 0
            if let url = URL(string: prayer.imageFiel) {
                cell.imgIcon.af.setImage(withURL: url)
            }
            
            cell.lblPrayer.adjustsFontSizeToFitWidth = true
            cell.lblStatus.adjustsFontSizeToFitWidth = true
            
            if statePray.count != 0 {
                if statePray[indexPath.item] {
                    cell.reactionImage.image = handsOn
                }else{
                    cell.reactionImage.image = handsOff
                }
            }
            if prayer.reaction {
                cell.reactionImage.image = handsOn
                if persons == 1 {//Reaccion solo mia
                    cell.prayLabel.text = "" + String(Int(prayer.people)! ) + " persona orando"
                }else{//Reaccion mia y mas
                    cell.prayLabel.text = "" + String(Int(prayer.people)!) + " personas orando"
                }
            }else{
                cell.reactionImage.image = handsOff
                if  persons == 1 {
                    cell.prayLabel.text = "" + String(Int(prayer.people)!) + " persona orando"
                }else{
                    cell.prayLabel.text = "" + String(Int(prayer.people)!) + " personas orando"
                }
                
            }
            cell.btnPersonsPraying.tag = indexPath.item
            //cell.btnPersonsPraying.addTarget(self, action: #selector(showPersonList), for: .touchUpInside)
            if prayer.imageFiel == "s/n" {
                cell.imgIcon.image = UIImage(named: "userImage",
                                             in: Bundle(for: type(of:self)),
                                             compatibleWith: nil)
            } else {
                if let url = URL(string: prayer.imageFiel) {
                    cell.imgIcon.af.setImage(withURL: url)
                }
            }

            cell.lblName.text = prayer.title
            cell.tag = prayer.id
            let isoDate = prayer.date
            //let dat = Date()
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.timeZone = TimeZone.current
            dateFormatterGet.locale = Locale(identifier: "es_MX")
            dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm:ss"
            if let date = dateFormatterGet.date(from: isoDate) {
                cell.lblStatus.text = date.timeAgoDisplay()
                
            }else{
                print("There was an error decoding the string", "????")
            }
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            cell.lblPrayer.text = prayer.prayer
            cell.btnPray.tag = prayer.id
            cell.btnPray.accessibilityLabel = "\(indexPath.item)" //  menos este (-1)
            cell.btnPray.accessibilityHint = String(indexPath.item) // menos este (-1)
            cell.btnPray.addTarget(self, action: #selector(reactToPromise), for: .touchUpInside)
            return cell
        //}
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.local)
            let vc = storyboard.instantiateViewController(withIdentifier: "cadenaVC") as! newPrayer
            vc.userName = userName
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        if indexPath.row == 0 {
            return CGSize(width: screenSize.width - 15, height: 172)
        }else{
            return CGSize(width: screenSize.width - 15, height: 152)
        }
       
    }
    
}

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 0.0941, green: 0.1216, blue: 0.5059, alpha: 1.0)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        messageLabel.sizeToFit()
        
        let imageView = UIImageView(frame: CGRect(x: messageLabel.bounds.midX + 65, y: self.bounds.midY - 130.0, width: 100.0, height: 100.0))
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(named: "sinPromesas",in: Bundle.local, with: nil)
        } else {
            
        }
        messageLabel.addSubview(imageView)
        
        self.backgroundView = messageLabel
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
}

extension Home_CadenaOracion: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        let singleton = Home_CadenaOracion.singleton
        switch singleton.publish {
        case "YES":
            print("Publica la oracion")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.present(self.alert, animated: true, completion: nil)
//                self.sendRESTRequest(endPoint: "https://api-develop.arquidiocesis.mx/prayers")
                self.sendRESTRequest(endPoint: "\(APIType.shared.User())/prayers")
            }
            
        case "ISALERT":
            print("IS FROM ALERT")
            
        default:
            print("No publiques oracion")
        }
      
        return transition
    }
}
