//
//  WebViewViewController.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 30/04/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var screenURL: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: screenURL ?? "www.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
}
