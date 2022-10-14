//
//  CommentsViewController.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import UIKit

class CommentsViewController: UIViewController, CommentsViewProtocol {
    
// MARK: VIPER VAR -
    var presenter: CommentsPresneterProtocol?
    
// MARK: GLOBAL VAR -
    var commentsList: [CommentsList] = []
    var ratings = [Double]()
    var rate = 0
    var locationID = 0
    var queryParam = ""
    var colorHolder = UIColor.init(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
    var normalColor = UIColor.init(red: 54/117, green: 54/120, blue: 54/123, alpha: 1)
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var pos = 0
    var reviewID = 0
    var oldHeightCard : CGFloat = 0.0
    var oldMyHeightCard: CGFloat = 0.0
    var isCommentEdited = false
    let transition = SlideTransition()
    static let singleton = CommentsViewController()
    var yesDelete = "false"
    var nameChurch = ""
    var isFormDelete = false
    var AllData: Comments!
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblTitleNavBar: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblStarNumber: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTitleCard: UILabel!
    @IBOutlet weak var cardTextView: UITextView!
    @IBOutlet weak var lblCalifica: UILabel!
    @IBOutlet weak var starCard1: UIImageView!
    @IBOutlet weak var starCard2: UIImageView!
    @IBOutlet weak var starCard3: UIImageView!
    @IBOutlet weak var starCard4: UIImageView!
    @IBOutlet weak var starCard5: UIImageView!
    @IBOutlet weak var btnQuestion: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPublicar: UIButton!
    @IBOutlet weak var stackStars: UIStackView!
    //@IBOutlet weak var heightCardComent: NSLayoutConstraint!
    
    @IBOutlet weak var cardFirstComment: UIView!
    @IBOutlet weak var userImgCard: UIImageView!
    @IBOutlet weak var btnOptions: UIButton!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var lblNameUser: UILabel!
    @IBOutlet weak var starComm1: UIImageView!
    @IBOutlet weak var starComm2: UIImageView!
    @IBOutlet weak var starComm3: UIImageView!
    @IBOutlet weak var starComm4: UIImageView!
    @IBOutlet weak var starComm5: UIImageView!
    @IBOutlet weak var lblDateComment: UILabel!
    @IBOutlet weak var iconAddComment: UIImageView!
    @IBOutlet weak var btnAddComment: UIButton!
   // @IBOutlet weak var heightMyComment: NSLayoutConstraint!
   // @IBOutlet weak var contraintUp: NSLayoutConstraint!
    @IBOutlet weak var heightComments: NSLayoutConstraint!
    @IBOutlet weak var contentFirstCard: UIView!
    @IBOutlet weak var contentSecondCard: UIView!
    
// MARK: LIFE CYCLE APP FUNCITONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        initUI()
        setupGestures()
        presenter?.requestListComments(queryParams: queryParam)
        if #available(iOS 13.0, *) {
            let interaction = UIContextMenuInteraction(delegate: self)
            btnOptions.addInteraction(interaction)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func initTableView() {
        commentsTable.delegate = self
        commentsTable.dataSource = self
        self.commentsTable.reloadData()
    }
    
     func initUI() {
        lblMainTitle.text = nameChurch
        userImgCard.layer.cornerRadius = userImgCard.bounds.width / 2
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        cardView.layer.cornerRadius = 10
        cardFirstComment.layer.cornerRadius = 10
        btnCancel.layer.cornerRadius = 8
        btnPublicar.layer.cornerRadius = 8
        btnCancel.borderButtonColor(color: UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        cardTextView.textColor = colorHolder
        cardTextView.delegate = self
        cardView.ShadowCard()
        cardFirstComment.ShadowCard()
    }
    
    private func setupGestures() {
        let tapStarI = UITapGestureRecognizer(target: self, action: #selector(TapStarI))
        starCard1.addGestureRecognizer(tapStarI)
        
        let tapStarII = UITapGestureRecognizer(target: self, action: #selector(TapStarII))
        starCard2.addGestureRecognizer(tapStarII)
        
        let tapStarIII = UITapGestureRecognizer(target: self, action: #selector(TapStarIII))
        starCard3.addGestureRecognizer(tapStarIII)
        
        let tapStarIV = UITapGestureRecognizer(target: self, action: #selector(TapStarIV))
        starCard4.addGestureRecognizer(tapStarIV)
        
        let tapStarV = UITapGestureRecognizer(target: self, action: #selector(TapStarV))
        starCard5.addGestureRecognizer(tapStarV)
        
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperview))
        self.view.addGestureRecognizer(tapSuperview)
        
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
        
    }
    
// MARK: @IBACTIONS -
    @IBAction func questionAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        //self.navigationController?.popViewController(animated: true)
        self.view.endEditing(true)
        
        if isCommentEdited == true {
            contentFirstCard.isHidden = true
            btnAddComment.isHidden = true
            iconAddComment.isHidden = true
            contentSecondCard.isHidden = false
            cardTextView.text = "Escribe tu comentario..."
            lblComment.text = AllData.my_review?.review
            userImgCard.DownloadStaticImage(AllData.my_review?.devotee?.image_url ?? "")
            lblNameUser.text = "\(AllData.my_review?.devotee?.name ?? "") \(AllData.my_review?.devotee?.first_surname ?? "") \(AllData.my_review?.devotee?.second_surname ?? "")"
            ratings.append(AllData.my_review?.rating ?? 0.0)
            reviewID = AllData.my_review?.id ?? 0
            fillStars(rating: AllData.my_review?.rating ?? 0.0)
        }else{
            if cardTextView.text != "Escribe tu comentario..." {
                let view = AlertComments.showAertDelete(titulo: "¿Quieres elimnar tu comentario?", mensaje: "NotEdited")
                view.transitioningDelegate = self
                self.present(view, animated: true, completion: nil)
            }else{
                iconAddComment.isHidden = false
                btnAddComment.isHidden = false
                contentSecondCard.isHidden = true
                contentFirstCard.isHidden = true
                cardTextView.text = "Escribe tu comentario..."
            }
            
        }
        
    }
    
    @IBAction func publicAction(_ sender: Any) {
        if cardTextView.text != "Escribe tu comentario..." && cardTextView.text != ""{
            ratings.removeAll()
            present(alertLoader, animated: true, completion: nil)
            if isCommentEdited == false {
                presenter?.makePostComment(locationID: locationID, rating: rate, comment: cardTextView.text)
            }else{
                print(rate)
                presenter?.makePutComment(locationID: locationID, rating: rate, comment: cardTextView.text, reviewID: reviewID, type: "PUT")
            }
        }
    }
    
    @IBAction func addComentAction(_ sender: Any) {
        iconAddComment.isHidden = true
        btnAddComment.isHidden = true
        contentSecondCard.isHidden = true
        contentFirstCard.isHidden = false
        cardTextView.text = "Escribe tu comentario..."
    }
    
// MARK: @OBJC FUNTIONS -
    @objc func TapStarI() {
        selectRatingStar(indexStar: 1)
    }
    
    @objc func TapStarII() {
        selectRatingStar(indexStar: 2)
    }
    
    @objc func TapStarIII() {
        selectRatingStar(indexStar: 3)
    }
    
    @objc func TapStarIV() {
        selectRatingStar(indexStar: 4)
    }
    
    @objc func TapStarV() {
        selectRatingStar(indexStar: 5)
    }
    
    @objc func TapSuperview() {
        self.view.endEditing(true)
    }
    
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
// MARK: SERVICES API FUNCTIONS -
    func successRequestComments(data: Comments) {
        isCommentEdited = false
        AllData = data
        if data.my_review == nil && data.other_reviews?.count != 0 {
            if isFormDelete == true {
                iconAddComment.isHidden = false
                btnAddComment.isHidden = false
                contentSecondCard.isHidden = true
                contentFirstCard.isHidden = true
                cardTextView.text = "Escribe tu comentario..."
            }else{
                self.cardTextView.text = "Escribe tu comentario..."
                btnAddComment.isHidden = true
                iconAddComment.isHidden = true
                contentSecondCard.isHidden = true
                contentFirstCard.isHidden = false
            }
                       
        }else if data.my_review == nil && data.other_reviews?.count == 0 {
            if isFormDelete == true {
                iconAddComment.isHidden = false
                btnAddComment.isHidden = false
                contentSecondCard.isHidden = true
                contentFirstCard.isHidden = true
                cardTextView.text = "Escribe tu comentario..."
            }else{
                self.cardTextView.text = "Escribe tu comentario..."
                btnAddComment.isHidden = true
                iconAddComment.isHidden = true
                contentSecondCard.isHidden = true
                contentFirstCard.isHidden = false
            }
            
        }else{
            btnAddComment.isHidden = true
            iconAddComment.isHidden = true
            contentFirstCard.isHidden = true
            contentSecondCard.isHidden = false
            
            cardTextView.text = "Escribe tu comentario..."
            lblComment.text = data.my_review?.review
            userImgCard.DownloadStaticImage(data.my_review?.devotee?.image_url ?? "")
            lblNameUser.text = "\(data.my_review?.devotee?.name ?? "") \(data.my_review?.devotee?.first_surname ?? "") \(data.my_review?.devotee?.second_surname ?? "")"
            ratings.append(data.my_review?.rating ?? 0.0)
            reviewID = data.my_review?.id ?? 0
            fillStars(rating: data.my_review?.rating ?? 0.0)
            
            lblDateComment.text = timeInterval(timeAgo: data.my_review?.creation_date ?? "")
            
        }
        
        if data.other_reviews?.count != 0 {
            data.other_reviews?.forEach({ item in
                ratings.append(item.rating ?? 0.0)
            })
            commentsList = data.other_reviews ?? commentsList
            initTableView()
        }
        
        if ratings.count != 0 {
            calculateRating(arrayRating: ratings)
        }else{
            let imgEmpty = UIImage(named: "Trazado 6945", in: Bundle.local, compatibleWith: nil)
            if #available(iOS 13.0, *) {
               // let imgFill = UIImage(named: "Trazado 6941")
                star1.image = imgEmpty
                star2.image = imgEmpty
                star3.image = imgEmpty
                star4.image = imgEmpty
                star5.image = imgEmpty
                
            }
        }
        
        if ratings.count == 1 {
            lblStarNumber.text = "1 comentario"
        }else{
            lblStarNumber.text = "\(ratings.count) comentarios"
        }
        
        guard let comm = data.other_reviews else { return }
        if comm.count != 0 {
            heightComments.constant = CGFloat(120 * comm.count)
        }
        isFormDelete = false
        alertLoader.dismiss(animated: true, completion: nil)
        
    }
    
    func failRequestComments() {
        alertLoader.dismiss(animated: true, completion: nil)
    }
    
    func successPostComment() {
        isCommentEdited = false
        self.presenter?.requestListComments(queryParams: self.queryParam)
   
    }
    
    func failPostComment() {
        alertLoader.dismiss(animated: true, completion: nil)
    }
    
    func successPutComment() {
        self.presenter?.requestListComments(queryParams: self.queryParam)
    }
    
    func failPutCmment() {
        DispatchQueue.main.async {
            self.alertLoader.dismiss(animated: true, completion: nil)
        }
        
    }
    
    let dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    func timeInterval(timeAgo:String) -> String {
        let df = DateFormatter()
        
        df.dateFormat = dateFormat
        guard let dateWithTime = df.date(from: timeAgo) else {return ""}
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "hace \(year)" + " " + " año" : "hace \(year)" + " " + "años"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "hace \(month)" + " " + "mes" : "hace \(month)" + " " + "meses"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "hace \(day)" + " " + "día" : "hace \(day)" + " " + "dias"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "hace \(hour)" + " " + "hora" : "hace \(hour)" + " " + "horas"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "hace \(minute)" + " " + "minuto" : "hace \(minute)" + " " + "minutos"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "hace \(second)" + " " + "segundo" : "\(second)" + " " + "segundos"
        } else {
            return "hace un momento"
            
        }
    }
    
// MARK:  GENERAL FUNCITONS -
    func addComentButtonMode() {
        iconAddComment.isHidden = false
        btnAddComment.isHidden = false
        contentSecondCard.isHidden = true
        contentFirstCard.isHidden = true
        cardTextView.text = "Escribe tu comentario..."
    }
    
// MARK: LOGIC DATA FUNCTIONS -
    func calculateRating(arrayRating: [Double]) {
        let average = arrayRating.reduce(0, +)
       // lblStarNumber.text = "\(Int(average) / arrayRating.count)"
        let imgFill = UIImage(named: "Trazado 6941", in: Bundle.local, compatibleWith: nil)
        let imgEmpty = UIImage(named: "Trazado 6945", in: Bundle.local, compatibleWith: nil)
        
        let finalRate = Int(average) / arrayRating.count
        if #available(iOS 13.0, *) {
           // let imgFill = UIImage(named: "Trazado 6941")
            
            switch finalRate {
            case 0:
                print("Average 0")
            case 1:
                star1.image = imgFill
                star2.image = imgEmpty
                star3.image = imgEmpty
                star4.image = imgEmpty
                star5.image = imgEmpty
                
            case 2:
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgEmpty
                star4.image = imgEmpty
                star5.image = imgEmpty
                
            case 3:
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgEmpty
                star5.image = imgEmpty
                
            case 4:
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgFill
                star5.image = imgEmpty
                
            case 5:
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgFill
                star5.image = imgFill
                
            default:
                break
            }
        }
        
    }
    
    func fillStars(rating: Double) {
        let imgFill = UIImage(named: "Trazado 6941", in: Bundle.local, compatibleWith: nil)
        let imgEmpty = UIImage(named: "Trazado 6945", in: Bundle.local, compatibleWith: nil)
        print(rating, "$$$")
        
        if #available(iOS 13.0, *) {
           // let imgFill = UIImage(named: "Trazado 6941")
            
            if rating == 0.0 {
                print("Is zero")
                starComm1.image = imgEmpty
                starComm2.image = imgEmpty
                starComm3.image = imgEmpty
                starComm4.image = imgEmpty
                starComm5.image = imgEmpty
            }else if rating <= 1.0 {
                starComm1.image = imgFill
                starComm2.image = imgEmpty
                starComm3.image = imgEmpty
                starComm4.image = imgEmpty
                starComm5.image = imgEmpty
            }else if rating  <= 2.0 {
                starComm1.image = imgFill
                starComm2.image = imgFill
                starComm3.image = imgEmpty
                starComm4.image = imgEmpty
                starComm5.image = imgEmpty
            }else if rating <= 3.0 {
                starComm1.image = imgFill
                starComm2.image = imgFill
                starComm3.image = imgFill
                starComm4.image = imgEmpty
                starComm5.image = imgEmpty
            }else if rating <= 4.0 {
                starComm1.image = imgFill
                starComm2.image = imgFill
                starComm3.image = imgFill
                starComm4.image = imgFill
                starComm5.image = imgEmpty
            }else if rating <= 5.0 {
                starComm1.image = imgFill
                starComm2.image = imgFill
                starComm3.image = imgFill
                starComm4.image = imgFill
                starComm5.image = imgFill
            }

        }
    }
    
    func selectRatingStar(indexStar: Int) {
        if #available(iOS 13.0, *) {
            let imgFill = UIImage(systemName: "star.fill")
            let imgEmpty = UIImage(systemName: "star")
            
            switch indexStar {
            case 1:
                if rate != 1 {
                    starCard1.image = imgFill
                    starCard2.image = imgEmpty
                    starCard3.image = imgEmpty
                    starCard4.image = imgEmpty
                    starCard5.image = imgEmpty
                    rate = 1
                    
                }else{
                    
                    starCard1.image = imgEmpty
                    rate = 0
                }
                
            case 2:
                if rate != 2 {
                    starCard1.image = imgFill
                    starCard2.image = imgFill
                    starCard3.image = imgEmpty
                    starCard4.image = imgEmpty
                    starCard5.image = imgEmpty
                    rate = 2
                    
                }else{
                    starCard1.image = imgEmpty
                    starCard2.image = imgEmpty
                    rate = 0
                }
                
            case 3:
                if rate != 3 {
                    starCard1.image = imgFill
                    starCard2.image = imgFill
                    starCard3.image = imgFill
                    starCard4.image = imgEmpty
                    starCard5.image = imgEmpty
                    rate = 3
                    
                }else{
                    starCard1.image = imgEmpty
                    starCard2.image = imgEmpty
                    starCard3.image = imgEmpty
                    rate = 0
                    
                }
                
            case 4:
                if rate != 4 {
                    starCard1.image = imgFill
                    starCard2.image = imgFill
                    starCard3.image = imgFill
                    starCard4.image = imgFill
                    starCard5.image = imgEmpty
                    rate = 4
                    
                }else{
                    starCard1.image = imgEmpty
                    starCard2.image = imgEmpty
                    starCard3.image = imgEmpty
                    starCard4.image = imgEmpty
                    rate = 0
                    
                }
                
            case 5:
                if rate != 5 {
                    starCard1.image = imgFill
                    starCard2.image = imgFill
                    starCard3.image = imgFill
                    starCard4.image = imgFill
                    starCard5.image = imgFill
                    rate = 5
                    
                }else{
                    starCard1.image = imgEmpty
                    starCard2.image = imgEmpty
                    starCard3.image = imgEmpty
                    starCard4.image = imgEmpty
                    starCard5.image = imgEmpty
                    rate = 0
                    
                }
                
            default:
                break
            }
            
        }
        
    }
    
}

extension CommentsViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if cardTextView.text == "" {
            cardTextView.textColor = colorHolder
            cardTextView.text = "Escribe tu comentario..."
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if cardTextView.text == "Escribe tu comentario..." {
            cardTextView.textColor = normalColor
            cardTextView.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 150    // 10 Limit Value
    }
    
}

// MARK: - UIContextMenuInteractionDelegate
extension CommentsViewController: UIContextMenuInteractionDelegate {
    @available(iOS 13.0, *)
    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint)
    -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { _ in
                // let rateMenu = self.makeRemoveRatingAction()
                // let deleteMenu = self.makeRemoveRatingAction2()
                let menu = self.makeEditMenu()
                let children = [menu]
                return UIMenu(title: "", children: children)
            })
    }
    
    @available(iOS 13.0, *)
    func makeEditMenu() -> UIMenu {
        let editImageAction = UIAction(title: "Edit Image",
                                       image: UIImage(named: ""),
                                       identifier: nil,
                                       attributes: .disabled) { _ in //.hidden - to hide the action
            print("Edit Image Action")
        }
        
        let copyAction = UIAction(title: "Editar",
                                  image: UIImage(named: ""),
                                  identifier: nil,
                                  state: .off) { _ in
            print("Edit Action")
            self.isCommentEdited = true
            self.contentSecondCard.isHidden = true
            self.contentFirstCard.isHidden = false
            self.cardTextView.text = self.lblComment.text
        }
        
        let deleteAction = UIAction(title: "Eliminar",
                                    image: UIImage(named: ""),
                                    identifier: nil,
                                    state: .off) { _ in
            print("Delete Action")
            let view = AlertComments.showAertDelete(titulo: "¿Quieres elimnar tu comentario?", mensaje: "")
            view.transitioningDelegate = self
            self.present(view, animated: true, completion: nil)
        }
        
        let shareAction = UIAction(title: "Share",
                                   image: UIImage(named: ""),
                                   identifier: nil,
                                   discoverabilityTitle:"To share the iamge to any social media") { _ in
            print("Share Action")
        }
        
        let removeAction = UIAction(title: "Remove",
                                    image: UIImage(named: ""),
                                    identifier: nil,
                                    discoverabilityTitle: nil,
                                    attributes: .destructive, //disabled, destructive, hidden
                                    handler: { _ in
                                        print("Remove Action")
                                    })
        
        return UIMenu(title: "Edit",
                      image: UIImage(named: ""),
                      options: [.displayInline], // [], .displayInline, .destructive
                      children: [copyAction, deleteAction])//[editImageAction, copyAction, shareAction, removeAction, deleteAction])
    }
    
}


extension CommentsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        let singleton = CommentsViewController.singleton
        switch singleton.yesDelete {
        case "true":
            ratings.removeAll()
            isFormDelete = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.present(self.alertLoader, animated: true, completion: nil)
                self.presenter?.makePutComment(locationID: self.locationID, rating: self.rate, comment: self.cardTextView.text, reviewID: self.reviewID, type: "DELETE")
            }
        
        case "TRUE":
            addComentButtonMode()
      
        default:
            break
        }
      
        return transition
    }
}

class SlideTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    
     guard let toInfoView = transitionContext.viewController(forKey: .to),
        let fromInfoView = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toInfoView.view.bounds.width
        let finalHeight = toInfoView.view.bounds.height
        
        if isPresenting {
            
            containerView.addSubview(toInfoView.view)
            toInfoView.view.frame = CGRect(x: 0, y: fromInfoView.view.frame.height, width: finalWidth, height: finalHeight)
            
        }
        
        let transform = {
            
            toInfoView.view.transform = CGAffineTransform(translationX: 0, y: -finalHeight)
            
        }
            let identity = {
                fromInfoView.view.transform = .identity
            }
            
            let duration = self.transitionDuration(using: transitionContext)
            let isCancelled = transitionContext.transitionWasCancelled
            UIView.animate(withDuration: duration, animations: {
                self.isPresenting ? transform() : identity()
            }) { (_) in
                transitionContext.completeTransition(!isCancelled)
            }
            
        }
        
    }
