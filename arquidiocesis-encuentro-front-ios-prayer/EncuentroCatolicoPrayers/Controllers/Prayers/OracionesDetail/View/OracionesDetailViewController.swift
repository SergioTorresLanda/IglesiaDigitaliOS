//
//  OracionesDetailViewController.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
//

import Foundation
import UIKit

class OracionesDetailViewController: UIViewController {
    
    var id: Int?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var txtText: UITextView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var vCellContainer: UIView!
    @IBOutlet weak var lblRecomend: UILabel!
    
// MARK: NEW @OUTLETS -
    @IBOutlet weak var contentCustomNavbar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblTitleNavBar: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var imgPray: UIImageView!
    @IBOutlet weak var textPray: UITextView!
    @IBOutlet weak var relatedTableView: UITableView!
    @IBOutlet weak var lblPray: UILabel!
    @IBOutlet weak var bottomHeight: NSLayoutConstraint!
    @IBOutlet weak var heightLblPray: NSLayoutConstraint!
    @IBOutlet weak var heightSimilarTable: NSLayoutConstraint!
    @IBOutlet weak var lblPrayersTitle: UILabel!
    @IBOutlet weak var btnSeemore: UIButton!
    
    var presenter: PresenterOracionesDetailProtocol?
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var similarArray : [SimilarResponse] = []
    
    override func viewDidLoad() {
        btnSeemore.layer.cornerRadius = 8
        showLoading()
        setupUI()
        setupGestures()
        self.view.backgroundColor = .white
        self.presenter?.getDataInteractorDevotions(id: self.id ?? 0)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.loadingAlert.dismiss(animated: true, completion: nil)
//        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECPrayers -OracionesDetail- OracionesDetailVC ")

    }
    
    private var datasource: DetailViewModel?
    
    private func initUI() {
        lblTitleNavBar.text = datasource?.name ?? "Oraciones"
        lblTitleNavBar.adjustsFontSizeToFitWidth = true
        imgPray.imageFromURL(urlString: datasource?.image_url ?? "")
       // self.imgImage.imageFromURL(urlString:  datasource?.image_url ?? "")
        //let demo: String = self.datasource!.description ?? ""
       // self.txtText.text = String.init().prepareForPrayer(strToChange: demo)
        print(heightLblPray.constant)
        lblPray.text = datasource?.description ?? ""
        self.view.layoutIfNeeded()
        print(heightLblPray.constant)
        similarArray = datasource?.similars ?? similarArray
        UIView.animate(withDuration: 0.4) {
            self.mainScrollView.alpha = 1
    
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }

    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        lblTitle.adjustsFontSizeToFitWidth = true
    }
    
    func setupDelegates() {
        relatedTableView.delegate = self
        relatedTableView.dataSource = self
        relatedTableView.reloadData()
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4) {
            self.mainScrollView.alpha = 1
    
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(tapBackAction))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    @IBAction func goToAgain(_ sender: Any) {
        let id = self.datasource?.similars?.first?.id ?? 0
        let detail = OracionesDetailRouter.getDetailView(id: id)
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    @IBAction func returnTo(_ sender: Any) {
        let view = OracionesRouter.getController()
        self.navigationController?.pushViewController(view, animated: false)
       
    }
    
    @IBAction func seeMoreAction(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
        let view = OracionesRouter.getController()
        self.navigationController?.pushViewController(view, animated: true)
        
    }
    
    func showLoading(){
           let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
       if #available(iOS 13.0, *) {
           imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
       } else {
           // Fallback on earlier versions
       }
           loadingAlert.view.addSubview(imageView)
           self.present(loadingAlert, animated: true, completion: nil)
       }
       
       func hideLoading(){
           loadingAlert.dismiss(animated: true, completion: nil)
       }
    
    @objc func tapBackAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OracionesDetailViewController: ViewOracionesDetailProtocol {
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.showAlert(withTitle: "Error", withMessage: message)
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
    func isSuccess(data: DetailViewModel) {
        DispatchQueue.main.async {
        self.datasource = data
        self.initUI()
        self.loadingAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension OracionesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        similarArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLSIMILAR", for: indexPath) as! SimilarCell
        cell.lblNamePray.text = similarArray[indexPath.row].name
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.ShadowCard()
        heightSimilarTable.constant = relatedTableView.contentSize.height + 40
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            self.mainScrollView.alpha = 0
        }
        mainScrollView.setContentOffset(.zero, animated: true)
        showLoading()
        presenter?.getDataInteractorDevotions(id: similarArray[indexPath.row].id ?? 0)
        
    }
    
    
}
