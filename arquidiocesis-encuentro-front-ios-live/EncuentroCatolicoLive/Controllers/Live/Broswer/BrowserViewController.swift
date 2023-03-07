//
//  BrowserViewController.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Desarrollo on 10/05/21.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    var screenURL: String!
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: screenURL ?? "www.com")!
        showLoading()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
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

}
