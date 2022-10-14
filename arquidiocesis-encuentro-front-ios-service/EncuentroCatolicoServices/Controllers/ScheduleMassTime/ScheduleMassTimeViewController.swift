//
//  ScheduleMassTimeViewController.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 28/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class ScheduleMassTimeViewController: UIViewController, ScheduleMassTimeViewProtocol {
    
    @IBOutlet weak var lblDate      : UILabel!
    @IBOutlet weak var collection   : UICollectionView!
    @IBOutlet weak var txtIntention : UITextField!
    @IBOutlet weak var txtName      : UITextField!
    @IBOutlet weak var btnNext      : UIButton!
    
    let viewBundle = Bundle.init(identifier: "mx.arquidiocesis.EncuentroCatolicoServices")
    var presenter: ScheduleMassTimePresenterProtocol?
    var maseDate: Date!
    var location: Assigned!
    let picker = UIPickerView()
    let pckData: Array<String> = ["Catálogo de intenciones",
                                  "Por el cumpleaños de",
                                  "Por el aniversario de matrimonio de",
                                  "Por el favor concedido a",
                                  "Por el logro de",
                                  "Por la salud de",
                                  "Por la pronta recuperación de",
                                  "Por el eterno descanso de",
                                  "Por el aniversario luctuoso de",
                                  "Por una intención especial de",
                                  "Por las necesidades de"]
    var newArray = [CatalogIntentions]()
    var dates: Array<String> = []//["10:00"]
    var arrayListIntentions : [ListIntentions2] = []
    var datesCompleteStr = ["10:00"]
    var oldHour = ""
    var selectedHourIndex: Int?
    var service_id = 32
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let accptaAlert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "No se cuenta con horarios disponibles")
    let transition = SlideTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.requestCatalogIntentions()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = .init(identifier: "es_MX")
        let date = dateFormatter.string(from: maseDate)
        self.presenter?.requestGetHours(locationID: "\(location.id ?? 0)", dateStr: date)
        
        txtIntention.inputView = picker
        picker.delegate = self
        txtIntention.addBottomBorderWithColor(color: UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0), width: 1.0)
        txtName.addBottomBorderWithColor(color: UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1.0), width: 1.0)
//        txtName.returnKeyType = .done
        txtName.delegate = self
        txtIntention.returnKeyType = .done
        txtIntention.delegate = self
        btnNext.layer.cornerRadius = 8
        if maseDate != nil{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d , MMMM - yyyy"
            dateFormatter.locale = .init(identifier: "es_MX")
            var text = dateFormatter.string(from: maseDate)
            text = text.replacingOccurrences(of: ",", with: "de")
            text = text.replacingOccurrences(of: "-", with: "del")
            lblDate.text = text
        }
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapRequestIntention(_ sender: Any) {
        guard let description = txtIntention.text,
            let selectedHour = selectedHourIndex,
            let location = location.id
            else {
                return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = .init(identifier: "es_MX")
        let date = dateFormatter.string(from: maseDate)
      //  let service_id = 32
        showLoading()
        presenter?.sendService(date: date, hour: arrayListIntentions[selectedHour].start_time ?? "", description: txtName.text ?? "", location: location, service_id: service_id)
    }
    
    func setupCollectionDelegate() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "MassTimeCVC", bundle: viewBundle), forCellWithReuseIdentifier: "cell")
        collection.reloadData()
    }
    
    func loadResult(data: ServicesResponse) {
        hideLoading()
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name("intentionCreated"), object: nil)
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: viewBundle, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func hideLoading() {
        self.alert.dismiss(animated: false, completion: nil)
    }
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        alert.dismiss(animated: false, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.alert.dismiss(animated: true, completion: nil)
            })
            let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alerta, animated: true, completion: nil)
        })
    }
    
    func succesCatalog(data: [CatalogIntentions]) {
        print(data)
        newArray = data
        
    }
    
    func failCatalog() {
        
    }
    
    func successHours(data: [ListIntentions2]) {
        print(data)
        arrayListIntentions = data
        
        if data.count == 0 {
            accptaAlert.transitioningDelegate = self
            self.present(accptaAlert, animated: true, completion: nil)
        }else{
            setupCollectionDelegate()
        }
        
    }
    
    func failHours() {
        
    }
    
}
extension ScheduleMassTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayListIntentions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MassTimeCVC
        cell.lblTime.text = arrayListIntentions[indexPath.row].start_time
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        for element in collection.visibleCells{
            let cellToClear = element as! MassTimeCVC
            cellToClear.imgView.image =  UIImage(named: "dot", in: viewBundle, compatibleWith: nil)
            cellToClear.cellView.borderColor = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0)
        }
        let cell = collection.cellForItem(at: indexPath) as! MassTimeCVC
        cell.imgView.image = UIImage(named: "dotFilled", in: viewBundle, compatibleWith: nil)
        cell.cellView.borderColor = UIColor(red: 0.0745, green: 0.1529, blue: 0.4863, alpha: 1.0)
        selectedHourIndex = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160.0, height: 40.0)
    }
}

extension UITextField {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        var bottomBorder = UIView()
        bottomBorder = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = color
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: width).isActive = true
        layoutIfNeeded()
    }
}

extension ScheduleMassTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.adjustsFontSizeToFitWidth = true
       // label.font = UIFont (name: "Helvetica Neue", size: 10)
        label.text =  newArray[row].name
        label.textAlignment = .center
        return label
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return newArray[row].name
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtIntention.text = newArray[row].name
        service_id = newArray[row].id ?? 0
        self.view.endEditing(true)
    }

}

extension ScheduleMassTimeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        print("Hola desde el dismiss delegate")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.navigationController?.popViewController(animated: true )
          
        }
       
        return transition
    }
}

extension ScheduleMassTimeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                do {
                    let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
                    if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                        return false
                    }
                }
                catch {
                    print("ERROR")
                }
            return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
