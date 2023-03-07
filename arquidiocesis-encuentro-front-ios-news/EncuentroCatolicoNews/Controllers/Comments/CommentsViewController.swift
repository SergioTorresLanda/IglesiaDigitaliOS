//
//  CommentsViewController.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 18/11/21.
//

import Foundation
import UIKit

class CommentsViewController: UIViewController, CommentsCellDelegate, RSCommentsViewProtocols, UIViewControllerTransitioningDelegate, FeedViewControllerDelegate{
    
    func reloadTblData() {
        commentsArray.removeAll()
        self.presenter?.getComments(isFromPage: false, isRefresh: false, post: newPost)
    }
    
// MARK: LOCAL VAR -
    var presenter: RSCommentsPresenterProtocol?
    var commentsArray =  [CmComments]()
    var newCommentsArray = [CmComments]()
    var newPost: Posts?
    var userPicker: [PickerUserPost]?
    private let shimmer = Shimmer()
    let name = UserDefaults.standard.string(forKey: "COMPLETENAME")
    var arrayRelations = [ResultsRelations]()
    var defaults = UserDefaults.standard
    var globalIndx = 0
    
// MARK: @IBOUTELTS -
    @IBOutlet var barraNav: UIView!
    @IBOutlet weak var tblview: UITableView!{
        didSet { tblview.tableFooterView = UIView() }
    }
    
    @IBOutlet weak var viewArriba: UIView!
    
    
// MARK: LIFE CYCLE VIEW FUNCS -
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECNews - CommentsVC ")
    }
    
// MARK: SETUP FUNC -
    private func setUpView(){
        self.presenter?.getComments(isFromPage: false, isRefresh: false, post: newPost)
        shimmer.startLoader(view: self.view, rows: [75, 200, 100, 200
                                                    , 220])
        barraNav.layer.cornerRadius = 30
        barraNav.layer.shadowRadius = 5
        barraNav.layer.shadowOpacity = 0.5
        barraNav.layer.shadowColor = UIColor.black.cgColor
        barraNav.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        viewArriba.layer.cornerRadius=30
        viewArriba.layer.shadowRadius = 5
        viewArriba.layer.shadowOpacity = 0.5
        viewArriba.layer.shadowColor = UIColor.black.cgColor
        viewArriba.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tblview.dataSource = self
        tblview.delegate = self
        tblview.showsVerticalScrollIndicator = false
        tblview.separatorStyle = .none
        tblview.register(UINib(nibName: "CommentsCell", bundle: Bundle(for: CommentsCell.self)), forCellReuseIdentifier: "CommentsCell")
        
    }
    
// MARK: @IBACTIONS -
    @IBAction func btnBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    let viewComment = CommentModal.showModalComment(type: "Comment")
    func btnsActions(strBtnSelected: String, indx: Int, snder: UIButton) {
        switch strBtnSelected{
        case "Responder":
            viewComment.nameImg = name ?? ""
            viewComment.newPost = newPost
            viewComment.arrayRelations = arrayRelations
            viewComment.presenter = presenter
            viewComment.transitioningDelegate = self
            self.present(viewComment, animated: true)
            
        case "Like":
            print("Manda a llamar el sercivio")
        case "Editar":
            editPost(id: indx, snder: snder)
        case "Eliminar":
            let pos = indx - 1
            globalIndx = pos
            if indx == 0 {
                self.presenter?.makeDelteComment(commentId: newPost?.id ?? 0, type: "posts")
            }else{
                self.presenter?.makeDelteComment(commentId: commentsArray[pos].id ?? 0, type: "comments")
            }
           
        default:
            break
            
        }
    }
    
// MARK: SERVICES RESPONSE -
    // repsponse list comments
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments]) {
        shimmer.stopLoader()
        self.commentsArray.removeAll()
        self.commentsArray = comments
        tblview.reloadData()
//        shimmer.stopLoader()
        presenter?.requestRelations(SNId: UserDefaults.standard.integer(forKey: "SNId"))
    }
    
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors) {
        shimmer.stopLoader()
    }
                                    
    func successGetRelations(data: RelationsData) {
        let addUser = ResultsRelations(id: nil, image: nil, name: defaults.string(forKey: "COMPLETENAME"), type: 1)
        arrayRelations = data.result ?? arrayRelations
        arrayRelations.append(addUser)
        shimmer.stopLoader()
    }
                                    
    func failGetRelations(mesage: String) {
        shimmer.stopLoader()
    }
    
    // response add Comment
    func didFinishAddPostCommnet(isReload: Bool) {
//        let comModal = CommentModal()
//        comModal.didFinishAddPostCommnet(isReload: true)
        commentsArray.removeAll()
        viewComment.dismiss(animated: true, completion: nil)
        shimmer.startLoader(view: self.view, rows: [75, 200, 100, 200
                                                    , 220])
        self.presenter?.getComments(isFromPage: false, isRefresh: false, post: newPost)
    }
    
// MARK: GENERAL FUNCTIONS -
    func editPost(id: Int, snder: UIButton) {
        guard let vc = CreatePostRouter.createModule() as? RedSocial_CrearPost else { return }
        vc.hasManyGroups = false
        vc.editPost = true
        let indx = id - 1
        if id == 0 {
            vc.typeData = "Normal"
            vc.newPostsInfo = newPost
        }else{
            vc.typeData = "Comment"
            vc.comm = commentsArray[indx]
        }
        vc.delegateTbl = self
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
}

// MARK: TABLE DELEGATES -
extension CommentsViewController: UITableViewDataSource{
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsCell else { return UITableViewCell() }
        
        cell.lblName.adjustsFontSizeToFitWidth = true
        cell.btnResponder.tag = indexPath.row
        cell.btnOracion.tag = indexPath.row
        cell.btnMoreActions.tag = indexPath.row
        cell.delegateComment = self
        cell.ctnView.constant = indexPath.row == 0 ? 0.0 : 16.0
        
        if indexPath.row == 0 {
            let iDate = newPost?.createdAt
            let stDate = "\(iDate ?? 0)"
            var imgUrl2 = ""
            if (newPost?.author?.image) != nil {
                imgUrl2=(newPost?.author?.image)!
            }
            cell.setupData(id: newPost?.id ?? -1, strName: newPost?.scope?.name ?? newPost?.author?.name ?? "", strComment: newPost?.content ?? "", stDate: Date(timeIntervalSince1970: TimeInterval(stDate) ?? 0.0).formatRelativeString(), strSecondDate: Date(timeIntervalSince1970: TimeInterval(stDate) ?? 0.0).formatRelativeString(), imgName: name ?? "", reaction: newPost?.reaction?.type ?? 0, likes: newPost?.totalReactions ?? 0, imgUrl: imgUrl2)
            
            return cell
        }
        
        cell.setUpNewData(commnts: commentsArray[indexPath.row - 1])
        
        return cell
    }
    
}

// MARK: TABLE DELEGATES -
extension CommentsViewController: UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        let viewFooter = UIView()
        viewFooter.layer.backgroundColor = UIColor.clear.cgColor
        return viewFooter
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return 166
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
}

// MARK: SERVICES RESPONSS -
extension CommentsViewController {
    func successDeleteComment(type: String) {
        print(commentsArray)
        if type == "comments" {
            self.presenter?.getComments(isFromPage: false, isRefresh: false, post: newPost)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func failDeleteComment(message: String) {
        print(message)
        
    }
}

