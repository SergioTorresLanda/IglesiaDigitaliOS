//
//  ChurchesCardViewCell.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 04/08/21.
//

import UIKit

class ChurchesCardViewCell: UICollectionViewCell {
    
    var picker: UIPickerView!
    var array =  ["Sacristán", "Secretaria/o", "Catequista", "Diácono permanente", "Ministro de la Eucaristía", "Lector/a institudio/a", "Acólito instituido", "Cantor/a en liturgia", "Pastoral"]
    var arrayNames = [String]()
    var arrayIds = [Int]()
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var churchImg: UIImageView!
    @IBOutlet weak var lblChurchName: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblAsk: UILabel!
    @IBOutlet weak var fieldServices: UITextField!
    @IBOutlet weak var lineaView: UIView!
    @IBOutlet weak var subCardView: UIView!
    
// MARK: LIFE CYCLE CELL -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupPickerField(vc: AnyObject, dataNames: [String], dataId: [Int], type:String) {
        print("SEtUP PICKER:: " + type)
        arrayNames = dataNames
        arrayIds = dataId
        fieldServices.delegate = self
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: cardView.frame.width, height: 200)) 
        picker.showsSelectionIndicator = true
        //lblAsk.text="Qué servicio prestas a la "+type
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.acceptPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        fieldServices.inputView = picker
        fieldServices.inputAccessoryView = toolBar
        picker.delegate = self
        picker.dataSource = self
    }
    
    @objc func acceptPicker() {
        self.endEditing(true)
    }
    
    @objc func cancelPicker() {
        fieldServices.text = ""
        self.endEditing(true)
        print("Cancel")
    }

}

extension ChurchesCardViewCell: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayNames[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fieldServices.text = arrayNames[row]
        let singleton = ProfileInfoView.singleton
        singleton.selectedServiceID = arrayIds[row]
        
    }
    
}

extension ChurchesCardViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            fieldServices.text = arrayNames[0]
        }
       
    }
    
}
