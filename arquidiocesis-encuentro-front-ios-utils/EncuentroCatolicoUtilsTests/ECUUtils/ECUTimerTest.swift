//
//  ECUTimerTest.swift
//  EncuentroCatolicoUtilsTests
//
//  Created by Alejandro on 19/10/22.
//

import XCTest
@testable import EncuentroCatolicoUtils

class ECUTimerTest: XCTestCase {
    //MARK: - Properties
    let timer: ECUTimerNative = ECUTimerNative()
    var timerPromise: XCTestExpectation?
    var isValid: Bool = false
    
    //MARK: - Methods
    func testTimer() throws {
        timerPromise = expectation(description: "Timer ended happy path")
        isValid = false
        
        timer.start(to: 10)
        wait(for: [timerPromise!], timeout: 10.1)
        XCTAssert(isValid)
        
        isValid = false
        timerPromise = expectation(description: "Timer bg happy path")
        timer.start(to: 10)
        
        timer.onBackground()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.timer.onBecomeActive()
        }
        wait(for: [timerPromise!], timeout: 10.1)
        XCTAssert(isValid)
    }
}

//MARK: - ECUTimerDelegate
extension ECUTimerTest: ECUTimerDelegate {
    func timerOnStop() {
        isValid = true
        timerPromise?.fulfill()
    }
    
    func timer(onUpdate countdown: Int) {
        print("Timer: time \(countdown.secondstoTimeString())")
    }
}

