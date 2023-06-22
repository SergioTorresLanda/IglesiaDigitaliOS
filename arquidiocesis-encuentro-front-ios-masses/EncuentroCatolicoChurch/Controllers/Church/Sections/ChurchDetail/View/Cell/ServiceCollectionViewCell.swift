//
//  ServiceCollectionViewCell.swift
//

import UIKit
import AlamofireImage

class ServiceCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Static values for init
    static let reuseIdentifier = "ServiceCollectionViewCell"
    static let nib = UINib(nibName: ServiceCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: ServiceCollectionViewCell.self))
    let isPrayer = UserDefaults.standard.bool(forKey: "isPriest")
    
    //MARK: - IBOutlets
//    @IBOutlet weak var serviceIconImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var availableDaysLabel: UILabel!
    @IBOutlet weak var availableHoursLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
//    @IBOutlet weak var btnClose: UIButton!
//    @IBOutlet weak var btnFirstEdit: UIButton!
//    @IBOutlet weak var btnSecondEdit: UIButton!
    
    //MARK: - IBActions
    @IBAction func deleteAction() {
        let alert = UIAlertController(title: "Iglesia Digital", message: "Se eliminara", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let deleteAction = UIAlertAction(title: "Borrar", style: .destructive) {
            [weak self]
            _ in
            if let collection = self?.collectionView,
               let index = self?.indexPath {
                self?.delegate?.delete(collectionView: collection, at: index)
            }
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        controller?.present(alert, animated: true)
    }
    
    @IBAction func editDaysAction() {
        if let controller = controller {
            let pickerController = PickerViewController.getInstance()
            pickerController?.delegate = self
            pickerController?.presentPicker(in: controller)
        }
    }
    
    @IBAction func editHoursAction() {
        if let controller = controller {
            let pickerController = DatePickerViewController.getInstance()
            pickerController?.delegate = self
            pickerController?.presentPicker(in: controller)
        }
    }
    
    //MARK: - Local variables
    weak var delegate: ServiceCellDelegate?
    weak var controller: UIViewController? = UIApplication.topViewController()
    let arrWeek:[String]=["Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"]
    //MARK: Init
   // func fill(with mass: ChurchDetail, index: Int) {
    func fill(with mass: NewMassesData, index: Int) {
        self.cardView.layer.cornerRadius = 10
        self.cardView.ShadowCard()
        print(mass.daysStr ?? "0")
        serviceNameLabel.text = arrWeek[Int(mass.daysStr!) ?? 0]
        availableHoursLabel.numberOfLines = 0
        availableHoursLabel.text = mass.hour
        availableHoursLabel.adjustsFontSizeToFitWidth = true
        deleteBtn.setTitle("", for: .normal)
        deleteBtn.isHidden=false
    }
    
    func fillService(with service: ChurchDetail.Service) {
        self.cardView.layer.cornerRadius = 10
        self.cardView.ShadowCard()
        lblTo.adjustsFontSizeToFitWidth = true
        lblDescription.adjustsFontSizeToFitWidth = true
        lblTo.text = "Dirigido a: " + service.geared_toward!
        lblTo.isHidden = false
        lblDescription.text = service.description
        serviceNameLabel.text = service.type?.name ?? ""
        lblDescription.isHidden = false
        availableHoursLabel.isHidden=true
        availableDaysLabel.numberOfLines=4
        availableDaysLabel.text! = ""
        var array: [XX] = []
        service.schedules?.forEach({ element in
            element.days?.forEach({ day in
                array.append(XX(day: day, start: element.hour_start ?? "00:00", end: element.hour_end ?? "00:00"))
                
            })
        })
        
        array.forEach({item in
            if item.day.checked == true {
                print("CHEKED:::")
                print(item.day.name)
                if item.start=="00:00" && item.end=="00:00"{
                    availableDaysLabel.text! += item.day.name! + ": Horario flexible \n"
                }else{
                    availableDaysLabel.text! += item.day.name! + ": " + item.start + " a " + item.end + "\n"
                }
            }
        })
        //validateRole()
    }
    
//    func validateRole() {
//        switch isPrayer {
//        case true:
////            self.btnClose.isHidden = false
//            self.btnFirstEdit.isHidden = false
//            self.btnSecondEdit.isHidden = false
//        case false:
//            self.btnClose.isHidden = true
//            self.btnFirstEdit.isHidden = true
//            self.btnSecondEdit.isHidden = true
//        }
//    }

}

//MARK: Protocol delegate
protocol ServiceCellDelegate: AnyObject {
    func editHours(collectionView: UICollectionView, at indexPath: IndexPath, hours: String)
    func editDays(collectionView: UICollectionView, at indexPath: IndexPath, days: String)
    func delete(collectionView: UICollectionView, at indexPath: IndexPath)
}

struct XX: Codable {
    let day: ChurchDetail.Day
    let start: String
    let end: String
}
//MARK: - Picker controller delegates
extension ServiceCollectionViewCell: PickerControllerDelegate {
    
    func closeAction(pickerType: PickerType) {}
    
    func acceptAction(pickerType: PickerType, selectedText: String) {
        switch pickerType {
        case .date:
            if let collection = self.collectionView,
               let index = self.indexPath {
                delegate?.editHours(collectionView: collection, at: index, hours: selectedText)
                availableHoursLabel.text = "\(selectedText) hrs, \(availableHoursLabel.text ?? "")"
            }
        case .plain:
            if let collection = self.collectionView,
               let index = self.indexPath {
                delegate?.editDays(collectionView: collection, at: index, days: selectedText)
                availableDaysLabel.text = selectedText
            }
        }
    }
    
}



extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
