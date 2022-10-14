//
//  DetailIntentionView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import UIKit

class DetailIntentionView: UIViewController, DetailIntentionViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: DetailIntentionPresenterProtocol?
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblTitleNavBar: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var lblCollectionStack: [UILabel]!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var tableIntentions: UITableView!
    @IBOutlet weak var heightTableIntentions: NSLayoutConstraint!
    
// MARK: GLOBAL VAR -
    var selectedCellImageViewSnapshot: UIView?
    var arrayIntentions = [Intentions]()
    var dateStr = ""
    var hourStr = ""
    let transition = SlideTransition()
    
// MARK: LIFE CYCLE FUNCS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        setupUI()
        showLoading()
//        print("/////", hourStr)
//        if hourStr.count < 8 {
//            
//            let h = hourStr.trimmingCharacters(in: .whitespaces)
//            let ha = h.prefix(2)
//            hourStr = "\(ha):00:00"
//
//        }
        presenter?.callRequestIntentionDetail(dateStr: dateStr, hourStr: hourStr)
        // "2021-09-15" "12:00:00"
    }
    
// MARK: SETUP FUNCS -
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        cardView.layer.cornerRadius = 10
        cardView.ShadowCard()
        
    }
    
    func setupDelegates() {
        tableIntentions.delegate = self
        tableIntentions.dataSource = self
        tableIntentions.reloadData()

    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
// MARK: GENERAL FUNC -
    private func shareSanpShot() {
        var sharingItems = [AnyObject]()
        sharingItems.append(cardView.asImage2())
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
// MARK: @OBJC FUNC -
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
        selectedCellImageViewSnapshot = cardView.snapshotView(afterScreenUpdates: false)
    }
    
// MARK: API SERVICES FUNCTIONS -
    func successRequestIntention(contentResponse: IntentionDetails) {
        print(contentResponse, "*****")
        
        if contentResponse.intentions?.count != 0 {
            arrayIntentions = contentResponse.intentions ?? []
            lblCollectionStack[1].text = contentResponse.location ?? ""
            lblCollectionStack[3].text = contentResponse.mass_date
            lblCollectionStack[5].text = contentResponse.mass_schedule
            UIView.animate(withDuration: 0.4) {
                self.cardView.alpha = 1
                print("si entro el alpha")
            }
            self.alertLoader.dismiss(animated: true, completion: nil)
            setupDelegates()
            
        }else{
            self.alertLoader.dismiss(animated: true, completion: nil)
            let alertII = acceptAlertService.showAlert(textAlert: "No cuentas con intenciones para este horario")
            alertII.transitioningDelegate = self
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
                self.present(alertII, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func failRequestIntention() {
    }
    
    func fatalError() {
        self.alertLoader.dismiss(animated: true, completion: nil)
        let alertI = acceptAlertService.showAlert(textAlert: "Por el momento no es posible realizar esta operación, intentelo más tarde.")
        alertI.transitioningDelegate = self
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
            self.present(alertI, animated: true, completion: nil)
        }

    }
    
    func succesPDFRequest(data: PDFObject) {
        print(data)
        let items: [Any] = [URL(string: data.url ?? "")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
    }
    
    func failPDFRequest() {
        
    }
        
// MARK: @IBACTIONS -
    @IBAction func sendACtion(_ sender: Any) {
        shareSanpShot()
    }
    
    @IBAction func downloadAction(_ sender: Any) {
        presenter?.callGetPDFRequest(dateStr: dateStr, hourStr: hourStr)
    }
    
}

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage2() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}

func getDate(str: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from: str) // replace Date String
}

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

extension DetailIntentionView: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        print("Delegate is working")
        self.navigationController?.popViewController(animated: true)
      
        return transition
    }
}
