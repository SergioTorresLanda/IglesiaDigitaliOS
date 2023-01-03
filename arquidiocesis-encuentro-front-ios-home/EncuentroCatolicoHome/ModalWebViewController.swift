//
//  ModalWebViewController.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 17/11/21.
//

import UIKit
import WebKit

open class ModalWebViewController: UIViewController {

// MARK: @IBOUTLET -
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var iconCross: UIImageView!
    @IBOutlet weak var viewContentButton: UIView!
    @IBOutlet weak var seeMoreBtn: UIButton!
    
// MARK: LOCAL VAR -
    var url = ""
    var viewType = ""
    
// MARK: LIFE CYCLE FUNCTIONS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        validateTypeModal(type: viewType)
        setupWebView(webURL: url)

    }
    
    private func setupWebView(webURL: String) {
        myWebView.contentMode = .scaleToFill
        myWebView.load(NSURLRequest(url: NSURL(string: webURL)! as URL) as URLRequest)
        seeMoreBtn.layer.cornerRadius = 8
        if #available(iOS 15.0, *) {
            myWebView.setAllMediaPlaybackSuspended(true) { }
        }
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        iconCross.addGestureRecognizer(tapBack)
    }
    
    private func validateTypeModal(type: String) {
        switch type {
        case "VIDEO":
            viewContentButton.isHidden = false
        default:
            viewContentButton.isHidden = true
        }
    }
    
// MARK: @IBACTIONS -
    @IBAction func seeMoreAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func TapBack() {
        self.dismiss(animated: false, completion: nil)
    }

//MARK: - Inicialización
    class public func showWebModal(url: String, type: String) -> ModalWebViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ModalWebViewController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "webViewModal") as! ModalWebViewController
        
        view.url = url
        view.viewType = type
        
        return view
    }
    
}
