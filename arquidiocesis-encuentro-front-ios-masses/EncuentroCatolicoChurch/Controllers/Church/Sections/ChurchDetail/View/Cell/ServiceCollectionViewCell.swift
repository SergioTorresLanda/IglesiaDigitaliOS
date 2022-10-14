//
//  ServiceCollectionViewCell.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 04/10/20.
//  Copyright © 2020 Linko. All rights reserved.
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
        let alert = UIAlertController(title: "Encuentro", message: "Se eliminara", preferredStyle: .actionSheet)
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
    
    //MARK: Init
   // func fill(with mass: ChurchDetail, index: Int) {
    func fill(with mass: Array<Array<NewMassesData>>, index: Int) {
        self.cardView.layer.cornerRadius = 10
        self.cardView.ShadowCard()
        
        print(mass[index].first?.daysStr ?? "")
        serviceNameLabel.text = mass[index].first?.daysStr
        availableHoursLabel.numberOfLines = 0
        
        var hours = [String]()
        mass[index].forEach { item in
            hours.append(item.hour)
        }
        let sortedHour = hours.sorted()
        availableHoursLabel.text = sortedHour.joined(separator: ", ")
        availableHoursLabel.adjustsFontSizeToFitWidth = true
        deleteBtn.setTitle("", for: .normal)
        print(mass[index])
        print()

    }
    
    func fillService(with service: ChurchDetail, index: Int) {
        self.cardView.layer.cornerRadius = 10
        self.cardView.ShadowCard()
        lblTo.adjustsFontSizeToFitWidth = true
        lblDescription.adjustsFontSizeToFitWidth = true
        lblTo.text = service.services?[index].geared_toward 
        lblTo.isHidden = false
        lblDescription.text = service.services?[index].description
        lblDescription.isHidden = false
//        if let url = URL(string: service.imageUrl ?? "") {
//            serviceIconImage.af.setImage(withURL: url, completion:  {
//                [weak self] _ in
//                self?.serviceIconImage.image = self?.serviceIconImage.image?.withRenderingMode(.alwaysTemplate)
//                self?.serviceIconImage.tintColor = .eDarkGold
//            })
//        }
        
        let serviceName = "Servicios"
//        self.serviceIconImage.image = UIImage(named: "encuentro-icon")
//        self.serviceIconImage.tintColor = .eDarkGold
        
        var arrayDays: [String] = []
        
        service.services?[index].schedules?.forEach({ element in
            print(element, "*******")
            element.days?.forEach({ day in
                if day.checked == true {
                    arrayDays.append(day.name ?? "")
                }
            })
            
        })
        
        if arrayDays.count == 7 {
            availableDaysLabel.text = "Lunes a Domingo"
        }else{
            availableDaysLabel.text = "\(arrayDays.first ?? "") a \(arrayDays.last ?? "")"
        }
        
        let horaS = service.services?[index].schedules?.first?.hour_start//service.services?.first?.schedules?.first?.hour_start
        let horaE = service.services?.first?.schedules?.first?.hour_end
        serviceNameLabel.text = service.services?[index].type?.name ?? ""
        availableHoursLabel.text = "\(horaS ?? "") hrs."
        deleteBtn.setTitle("", for: .normal)
        
//        validateRole()
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
protocol ServiceCellDelegate: class {
    func editHours(collectionView: UICollectionView, at indexPath: IndexPath, hours: String)
    func editDays(collectionView: UICollectionView, at indexPath: IndexPath, days: String)
    func delete(collectionView: UICollectionView, at indexPath: IndexPath)
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
