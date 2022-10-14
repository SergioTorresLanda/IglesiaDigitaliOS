//
//  CameraSessionHandler.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import AVFoundation

final class CameraSessionHandler {

    enum CameraSessionError: Error {
        case noDeviceInput, noPermission
    }

    private let session = AVCaptureSession()

    weak var previewView: LiveView? {
        didSet {
            previewView?.session = session
        }
    }

    var isRunning: Bool {
        return session.isRunning
    }

    var hasPermssion: Bool {
        return AVCaptureDevice.authorizationStatus(for: .video) == .authorized
    }

    private let sessionQueue = DispatchQueue(label: "pickle.liveView.sessionQueue")

    init() throws {
        guard hasPermssion else { throw CameraSessionError.noPermission }
    }

    func startSession() throws {
        guard
            let input = AVCaptureDevice.default(for: .video),
            let deviceInput = try? AVCaptureDeviceInput(device: input) else {
                throw CameraSessionError.noDeviceInput
        }
        if session.inputs.count == 0 {
            session.addInput(deviceInput)
        }
        sessionQueue.async { [weak self] in
            guard self?.session.isRunning == .some(false) else { return }
            self?.session.startRunning()
        }
    }

    func stopSession() {
        sessionQueue.async { [weak self] in
            self?.session.stopRunning()
        }
    }
}
