//
//  PickerViewController.swift
//  PriestMyChurches
//
//  Created by Edgar Hernandez Solis on 13/02/21.
//

import UIKit

class PickerViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    
    //MARK: - IBActions
    @IBAction func closeAction() {
        dismiss(animated: true) {
            [weak self] in
            self?.delegate?.closeAction(pickerType: PickerType.plain)
        }
    }
    
    @IBAction func acceptAction() {
        
        let firstComponentRow = pickerView.selectedRow(inComponent: 0)
        let secondComponentRow = pickerView.selectedRow(inComponent: 1)
        
        if firstComponentRow >= 0 && secondComponentRow >= 0 {
            selectedText = "\(pickOptions[firstComponentRow])-\(pickOptions[secondComponentRow])"
        }
        
        dismiss(animated: true) {
            [weak self] in
            if let selectedText = self?.selectedText {
                self?.delegate?.acceptAction(pickerType: PickerType.plain, selectedText: selectedText)
            }
        }
    }
    
    //MARK: - Local variables
    weak var delegate: PickerControllerDelegate?
    var selectedText: String = ""
    private var pickOptions = Calendar.current.weekdaySymbols
    
    //MARK: - IBOutlets
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        pickerView.delegate = self
    }
    

    static func getInstance() -> PickerViewController? {
        
        var datePickerController: PickerViewController?
        let storyBoard = UIStoryboard(name: "PickerController", bundle: Bundle(for: PickerViewController.self))
        if let controller = storyBoard.instantiateViewController(withIdentifier: "PickerViewController") as? PickerViewController {
            datePickerController = controller
        }
        
        return datePickerController
    }
    
    func presentPicker(in controller: UIViewController) {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            controller.present(self, animated: true)
        }
    }

}

//MARK: - PickerView delegates
extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOptions[row]
    }
      
}
