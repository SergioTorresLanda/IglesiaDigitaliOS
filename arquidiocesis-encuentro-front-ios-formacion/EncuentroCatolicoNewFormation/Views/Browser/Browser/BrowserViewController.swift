//
//  BrowserViewController.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Desarrollo on 10/05/21.
//

import UIKit
import WebKit
import Foundation

class BrowserViewController: UIViewController, URLSessionDelegate {

    //MARK: - @IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var viewHead: UIView!
    
    //MARK: - Properties
    var defaultSession: URLSession!
    var downloadTask: URLSessionDownloadTask!
    var screenURL: String?
    var btnDownloadFile: UIButton?
    
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHead.layer.cornerRadius = 30
        viewHead.layer.shadowRadius = 5
        viewHead.layer.shadowOpacity = 0.5
        viewHead.layer.shadowColor = UIColor.black.cgColor
        viewHead.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        guard let urlString = screenURL,
              let url = URL(string: urlString) else {
            return
        }
        
        btnDownload.setTitle("", for: .normal)
        showLoading()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        let backgroundSessionConfig = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
        
        defaultSession = Foundation.URLSession(configuration: backgroundSessionConfig, delegate: self, delegateQueue: OperationQueue.main)
    }
    
    //MARK: - Methods
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle().getBundle(), compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }

    func showFilePath(path: String){
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: path){
            if let document = NSData(contentsOfFile: path){
                let activityViewController = UIActivityViewController(activityItems: [document], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view

                self.present(activityViewController, animated: true)
            }
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
    func mostContoller() -> UIViewController?{
        if var topController: UIViewController = UIApplication.shared.keyWindow?.rootViewController{
            while (topController.presentationController != nil){
                topController = topController.presentedViewController ?? topController
            }
            return topController
        }
        return nil
    }
    
    //MARK: - @IBAction
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDownload(_ sender: UIButton) {
        guard let screenURL = screenURL,
              let url = URL(string: screenURL) else {
            return
        }

        downloadTask = defaultSession.downloadTask(with: url)
        downloadTask.resume()
    }
}

//MARK: - WKNavigationDelegate
extension BrowserViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        alert.dismiss(animated: false, completion: nil)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        onError()
    }
}

//MARK: - URLSessionDownloadDelegate
extension BrowserViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        guard let docDirectoryPath: String = path[safe: 0] else {
            return
        }
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: docDirectoryPath.appendingFormat("/BiliotecaVirtual.pdf"))
        
        do {
            try fileManager.removeItem(at: destinationURLForFile)
            if fileManager.fileExists(atPath: destinationURLForFile.path){
                showFilePath(path: destinationURLForFile.path)
                return
            }
            
            try fileManager.moveItem(at: location, to: destinationURLForFile)
            showFilePath(path: destinationURLForFile.path)
        } catch {
            
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        downloadTask = nil
        onError()
    }
}

//MARK: - Private functions
extension BrowserViewController {
    private func onError() {
        alert.dismiss(animated: true)
        
        let alert = UIAlertController(title: "Error", message: "Ocurrio algo inesperado, intentelo más tarde", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
}
