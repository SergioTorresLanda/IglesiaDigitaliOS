//
//  SubDelegateAlert.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Miguel Eduardo  Valdez Tellez  on 22/03/21.
//

import Foundation

protocol SubDelegateAlert: NSObjectProtocol {
    func refuseButton(action: AlertNotificacionVIew)
    func scheduleButton(action: AlertNotificacionVIew)
    func acceptServiceButton(action: AlertNotificacionVIew)
}
