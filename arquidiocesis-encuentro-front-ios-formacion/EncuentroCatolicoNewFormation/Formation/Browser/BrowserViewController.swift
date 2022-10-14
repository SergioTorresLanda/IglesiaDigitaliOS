//
//  BrowserViewController.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Desarrollo on 10/05/21.
//

import UIKit
import WebKit
import Foundation

class BrowserViewController: UIViewController, WKNavigationDelegate, URLSessionDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var btnDownload: UIButton!
    var defaultSession: URLSession!
    var downloadTask: URLSessionDownloadTask!
    var screenURL: String!
    var btnDownloadFile: UIButton?
    
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: screenURL ?? "www.com")!
        btnDownload.setTitle("", for: .normal)
        showLoading()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        if let _ = URL(string: String(url.absoluteString)){
            let backgroundSessionConfig = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
            defaultSession = Foundation.URLSession(configuration: backgroundSessionConfig, delegate: self, delegateQueue: OperationQueue.main)
        }
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle().getBundle(), compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
        alert.dismiss(animated: false, completion: nil)
    } // show indicator

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        alert.dismiss(animated: false, completion: nil)
    }  // hide indicator

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error){
        alert.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnDownload(_ sender: UIButton) {
        if let url = URL(string: screenURL){
            downloadTask = defaultSession.downloadTask(with: url)
            downloadTask.resume()
        }
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
}

extension BrowserViewController: URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let docDirectoryPath: String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: docDirectoryPath.appendingFormat("/BiliotecaVirtual.pdf"))
        
        do {
            try fileManager.removeItem(at: destinationURLForFile)
        }
        catch{
        }
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            showFilePath(path: destinationURLForFile.path)
        }else{
            do {
                try fileManager.moveItem(at: location, to: destinationURLForFile)
                showFilePath(path: destinationURLForFile.path)
            }catch{
                
            }
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        downloadTask = nil
    }
}
