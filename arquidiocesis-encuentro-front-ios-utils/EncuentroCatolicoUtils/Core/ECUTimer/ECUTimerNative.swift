//
//  ECUTimerNative.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 19/10/22.
//

import UIKit

public final class ECUTimerNative {
    //MARK: - Protocol Proprties
    weak public var delegate: ECUTimerDelegate?
    public var countDown: Int = 0 {
        didSet {
            guard oldValue != countDown else {
                return
            }
            
            updateCountdown()
        }
    }
    
    //MARK: - Properties
    private var timer: Timer?
    private var timestamp: Double?
    private let notificationToBackground = UIApplication.didEnterBackgroundNotification
    private let notificationBecomeActive = UIApplication.didBecomeActiveNotification
    
    //MARK: - Life Cycle
    public init() {
        setupEvents()
    }
    
    deinit {
        stopTimer()
        removeEvents()
    }
    
    //MARK: - Events
    @objc func onBecomeActive() {
        guard let timestamp = timestamp else {
            return
        }
        
        let diffComponents = Calendar.current.dateComponents([.second], from: Date(timeIntervalSince1970: timestamp), to: Date())

        start(to: self.countDown - (diffComponents.second ?? 0))
    }
    
    @objc func onBackground() {
        timestamp = Date().timeIntervalSince1970
        stopTimer()
    }
    
    @objc private func updateCountDown() {
        countDown -= 1
    }
}

//MARK: - ECUTimer
extension ECUTimerNative: ECUTimer {
    public func start(to countDown: Int) {
        stopTimer()
        self.countDown = countDown
        setTimer()
    }
    
    public func stop() {
        self.countDown = 0
    }
    
    public func pause() {
        stopTimer()
    }
    
    public func `continue`() {
        setTimer()
    }
}

//MARK: - Private functions
extension ECUTimerNative {
    private func setTimer() {
        guard countDown > 0 else {
            return
        }
        
        self.timer = Timer.scheduledTimer(
            timeInterval    :   1,
            target          :   self,
            selector        :   #selector(updateCountDown),
            userInfo        :   nil,
            repeats         :   true
        )
    }
    
    private func updateCountdown() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.delegate?.timer(onUpdate: self.countDown)
            
            if self.countDown <= 0 {
                self.stopTimer()
                self.delegate?.timerOnStop()
            }
        }
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func setupEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(onBackground), name: notificationToBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onBecomeActive), name: notificationBecomeActive, object: nil)
    }
    
    private func removeEvents() {
        NotificationCenter.default.removeObserver(self, name: notificationToBackground, object: nil)
        NotificationCenter.default.removeObserver(self, name: notificationBecomeActive, object: nil)
    }
}
