//
//  ECUTimerDelegate.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 19/10/22.
//

import Foundation

public protocol ECUTimerDelegate: AnyObject {
    //MARK: - Methods
    @MainActor
    func timerOnStop()
    @MainActor
    func timer(onUpdate countdown: Int)
}
