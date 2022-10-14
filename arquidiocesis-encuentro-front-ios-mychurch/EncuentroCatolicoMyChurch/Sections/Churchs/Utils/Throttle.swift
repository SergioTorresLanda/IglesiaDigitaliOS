//
//  Throttle.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 17/03/21.
//

import Foundation

class Throttle {
    private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private let queue: DispatchQueue
    private let delay: TimeInterval

    init(minimumDelay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        delay = minimumDelay
        self.queue = queue
    }

    func throttle(_ block: @escaping () -> Void) {
        workItem.cancel()

        workItem = DispatchWorkItem {
            [weak self] in
            self?.previousRun = Date()
            block()
        }

        let deltaDelay = previousRun.timeIntervalSinceNow > delay ? 0 : delay
        queue.asyncAfter(deadline: .now() + Double(deltaDelay), execute: workItem)
    }
}
