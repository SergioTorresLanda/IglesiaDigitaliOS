//
//  Home_Actividades.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 03/03/23.
//

import UIKit

class Home_Actividades: UIViewController {

    @IBOutlet weak var zonaPV: UIPickerView!
    @IBOutlet weak var mesesPV: UIPickerView!
    @IBOutlet weak var tipoPV: UIPickerView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var viewHead: UIView!
    
    var arrZona = ["Alvaro Obregón",
                   "Azcapotzalco",
                   "Benito Juárez",
                   "Coyoacán",
                   "Cuajimalpa de Morelos",
                   "Cuauhtémoc",
                   "Gustavo A. Madero",
                   "Iztacalco","Tlalpan","Xochimilco"]
    var arrMeses=["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    var arrTipos=["Asistente","Donante","Organizador","Voluntario"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        zonaPV.delegate=self
        zonaPV.dataSource=self
        mesesPV.delegate=self
        mesesPV.dataSource=self
        tipoPV.delegate=self
        tipoPV.dataSource=self
        
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            print("selecciono")
        default:
            print("selecciono otro")
        }
    }
}
