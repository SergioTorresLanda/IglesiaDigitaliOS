//
//  SMainVC.swift
//  baz-buy
//
//  Created by Monserrat Caballero on 28/10/20.
//

import UIKit
import AVFoundation

protocol SQRPresenterToViewProtocol: class {
    var _presenter : SQRViewToPresenterProtocol? { set get }
    func setData()
    
    func sendRequest(data: [String])
    func sendRequestFailure(code: Int, msg: String)
}

public class SQRMainVC: UIViewController {
    
    var _presenter: SQRViewToPresenterProtocol?
    
    private var viewContent :  UIView!
    
    private lazy var contentViewSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    
    private lazy var mainView : UIView =
        {
        let view = UIView()
        view.frame.size = self.contentViewSize
        return view
    }()
    
    private lazy var safeArea = { () -> UILayoutGuide in
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide
        }else{
            return self.view.layoutMarginsGuide
        }
    }()
    
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    private var qrInfo: String?

    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _presenter?.getData()
    }
    
    
    @objc func dismissView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SQRMainVC: SQRPresenterToViewProtocol, AVCaptureMetadataOutputObjectsDelegate {
    func sendRequest(data: [String]) {
//        self.spinner.stop()
//        self.spinner.removeFromSuperview()
//        self.checkScanQr()
        _presenter?.goNext(self.qrInfo!, data[1])
    }
    
    func sendRequestFailure(code: Int, msg: String) {
//        self.spinner.stop()
//        self.spinner.removeFromSuperview()
//        debugPrint("Code --> :\(code), Message --> \(msg)")
        
//        if let navigation   =   self.navigationController {
////            if msg.contains("Sesión invalida.") {
////                BACUBaseViewController.setExitFlag(on: true)
////                self.alertInternet.show(navigation: navigation, viewSource: self.view, errorMessage: ErrorMessage.invalidSession.rawValue, stateAlertError: StateAlertError.Acept, statusImage: StatusPointer.danger, titleCancelButton: nil)
////
////                self.alertInternet.alertPassword?.closureAcept = { [weak self] in
////                    self?.alertInternet.hide(navigation: navigation)
////                    self?._presenter?.cancelNext(toRoot: true)
////                }
////            } else if code == 599 {
////                self.alertInternet.show(navigation: navigation, viewSource: self.view, errorMessage: ErrorMessage.internteError.rawValue, stateAlertError: StateAlertError.Acept, statusImage: StatusPointer.danger, titleCancelButton: nil)
////
////                self.alertInternet.alertPassword?.closureAcept = { [weak self] in
////                    self?.alertInternet.hide(navigation: navigation)
////                    self?._presenter?.cancelNext(toRoot: false)
////                }
////            } else {
////                self.alertInternet.show(navigation: navigation, viewSource: self.view, errorMessage: msg, stateAlertError: StateAlertError.TryAgain, statusImage: StatusPointer.danger, titleCancelButton: "Cancelar")
////
////                self.alertInternet.alertPassword?.closureAcept = { [weak self] in
////                    self?.alertInternet.hide(navigation: navigation)
////                    self?.callRequest(code: (self?.qrInfo)!)
////                }
////
////                self.alertInternet.alertPassword?.closureCancel = { [weak self] in
////                    self?.alertInternet.hide(navigation: navigation)
////                    self?._presenter?.cancelNext(toRoot: false)
////                }
////            }
//        }
    }
    
    func setData() {
        self.view.backgroundColor = .white
        self.view.addSubview(mainView)
        //a MANO
       // mainView.setConstraintsToBordersAndSizes(topAnchor: view.topAnchor, bottomAnchor: view.bottomAnchor, leftAnchor: view.leftAnchor, rightAnchor: view.rightAnchor, width: nil, height: nil)
        
         captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { failed(); return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            metadataOutput.rectOfInterest = CGRect(x: mainView.center.x-140, y: mainView.center.y-140, width: 280, height: 280)
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = mainView.bounds

        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        mainView.layer.addSublayer(previewLayer)

        let cgRect = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        viewContent = UIImageView()
        viewContent.frame = cgRect
        viewContent.backgroundColor = UIColor.black.withAlphaComponent(0.4)

        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(x: viewContent.center.x-140, y: viewContent.center.y-140, width: 280, height: 280), cornerWidth: 25, cornerHeight: 25)
        path.closeSubpath()

        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 3.0
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor

        viewContent.layer.addSublayer(shape)

        path.addRect(CGRect(origin: .zero, size: viewContent.frame.size))

        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        viewContent.layer.mask = maskLayer
        viewContent.clipsToBounds = true

        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: viewContent.center.x-157.5, y: 50, width: 315, height: 104)

        //let infoText = "qr_info".getStringFrom()
        let infoText = "Pago con QR"
        textLayer.string = infoText

        let fontName: CFString = "Avenir-Medium" as CFString
        textLayer.font = CTFontCreateWithName(fontName, 20, nil)
        textLayer.fontSize = CGFloat(20)

        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.contentsScale = UIScreen.main.scale
        viewContent.layer.addSublayer(textLayer)
        
        let button = UIButton()
        let image = UIImage(named: "backIconScanner", in: Bundle.init(for: SQRMainVC.self), compatibleWith: nil)!
        button.addTarget(self, action: #selector(dismissView(_:)), for: .touchUpInside)
        
        let imageView = UIImageView()
        imageView.image = image
        
        let backView = UIView(frame: CGRect(x: 0, y: 50, width: 50, height: 50))
        backView.addSubview(imageView)
        backView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            button.topAnchor.constraint(equalTo: backView.topAnchor),
            button.bottomAnchor.constraint(equalTo: backView.bottomAnchor)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10.0),
            imageView.heightAnchor.constraint(equalToConstant: 15.0),
            imageView.widthAnchor.constraint(equalToConstant: 10.0),
            imageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10.0)
        ])
        
        mainView.addSubview(backView)

        previewLayer.addSublayer(viewContent.layer)

        captureSession.startRunning()

        let visibleRect = previewLayer.metadataOutputRectConverted(fromLayerRect: CGRect(x: viewContent.center.x-125, y: viewContent.center.y-125, width: 250, height: 250))
        metadataOutput.rectOfInterest = visibleRect

    }
    
    func failed() {
        let ac = UIAlertController(title: "Escaneo no disponible", message: "Tu dispositivo no soporta el escaneo de código QR de un artículo. Por favor usa un dispositivo con cámara", preferredStyle: .alert)

        let action = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.destructive) { [weak self] UIAlertAction in
            self?._presenter?.cancelNext(toRoot: true)
        }
        ac.addAction(action)
        present(ac, animated: true)
        captureSession = nil
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //super.navigation(navAction: .back, title: "buy".getStringFrom())
        print("VC ECScanner - SQRMainVC ")

        if (captureSession?.isRunning == false) {
                captureSession.startRunning()
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
       
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            captureSession = nil
        }

       // dismiss(animated: true)
    }

    func found(code: String) {
        self.qrInfo = code
        
        callRequest(code: code)
        
    }
    
    func callRequest(code: String) {
        UIApplication.shared.open(URL(string: "bancoaztecadl://?sendToAcc")!, options: [:], completionHandler: nil)
    }

    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
}

