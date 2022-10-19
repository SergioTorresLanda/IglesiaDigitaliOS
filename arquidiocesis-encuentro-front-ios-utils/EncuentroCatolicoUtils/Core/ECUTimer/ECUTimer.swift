//
//  ECUTimer.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 19/10/22.
//

import Foundation

public protocol ECUTimer: AnyObject {
    //MARK: - Properties
    var countDown: Int { get set }
    var delegate: ECUTimerDelegate? { get set }
    
    //MARK: - Methods
    func start(to countDown: Int)
    func stop()
    func pause()
    func `continue`()
}
