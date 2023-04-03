//
//  PickerControllerDelegate.swift
//  PriestMyChurches
//
//  Created by Edgar Hernandez Solis on 13/02/21.
//

import Foundation

protocol PickerControllerDelegate: AnyObject {
    func closeAction(pickerType: PickerType)
    func acceptAction(pickerType: PickerType, selectedText: String)
}
