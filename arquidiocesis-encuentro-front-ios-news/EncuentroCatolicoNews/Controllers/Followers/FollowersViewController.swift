//
//  FollowersViewController.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//

import UIKit

class FollowersViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblNameProfile: UILabel!
    @IBOutlet weak var segmentedControlView: UIStackView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet public weak var loadingView: UIView!
    @IBOutlet public weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingView2: UIView!
    @IBOutlet weak var publicacionesBtn: UIButton!
    @IBOutlet weak var viewG: UIView!
    //Nuevos para perfil
    @IBOutlet weak var publicV: UIView!
    @IBOutlet weak var numPublic: UILabel!
    @IBOutlet weak var publicLbl: UILabel!
    @IBOutlet weak var followersV: UIView!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var followedV: UIView!
    @IBOutlet weak var numFollowed: UILabel!
    @IBOutlet weak var followedLbl: UILabel!
    
    @IBOutlet weak var headerSVHeight: NSLayoutConstraint!
    @IBOutlet weak var headerSV: UIStackView!
    
    @IBOutlet weak var followSV: UIStackView!
    @IBOutlet weak var followBtn: UIView!
    @IBOutlet weak var iconFollow: UIImageView!
    @IBOutlet weak var lblFollow: UILabel!
    
    // MARK: Properties
    var presenter: FollowersPresenterProtocol?
    var dispatchGroup = DispatchGroup()
    let sm = DispatchSemaphore(value: 0)
    private let shimmer = Shimmer()
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    let userID = UserDefaults.standard.integer(forKey: "id")
    var arrFollowers: [Followers] = []
    var arrFollowed: [Followers] = []
    var arrInfoToShow: [Followers] = []
    var isFollowers = true
    let name = UserDefaults.standard.string(forKey: "COMPLETENAME")
    var numF=0
    var numF2=0
    var azulito=UIColor(named: "azulActivo",in: Bundle(for: Home_RedSocial.self), compatibleWith: nil)
    public var isPrefetching = false
    var newPosts = [Posts]()
    var disclaimer = 0
    
    var profileSNid = 0
    var userName = ""
    var userImg = ""
    var type = ""
    var follow = false
    var timesCall=0
    var numFllws = 0
    var numFllwrs = 0
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        formatoViewG()
        setTapGestures()
        formatoSegmentNew()
        shimmer.startLoader(view: loadingView2, rows: [75, 200, 100, 200, 220])
        formatoPublishActive(bool:true)
        tblView.delegate = self
        tblView.dataSource = self

        let nib = UINib(nibName: "FollowersTableViewCell", bundle: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoNews"))
        tblView.register(nib, forCellReuseIdentifier: "FollowersTableViewCell")

        let nib2 = UINib(nibName: "FeedTVC", bundle: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoNews"))
        tblView.register(nib2, forCellReuseIdentifier: "FeedTVC")
        
        lblNameProfile.text = UserDefaults.standard.string(forKey: "COMPLETENAME")
        
        imgProfile.layer.borderWidth = 0.5
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.clipsToBounds = true
        imgProfile.makeRounded()
        lblNameProfile.text=userName
        if userImg == "self"{
            headerSV.isHidden=false
            headerSVHeight.constant=50
            followSV.isHidden=true
            if let imageString = UserDefaults.standard.string(forKey: "imageUrl") {
                imgProfile.loadS(urlS:imageString)
            }
        }else{
            headerSV.isHidden=true
            headerSVHeight.constant=15
            followSV.isHidden=false
            changeFollowBtn()
            followBtn.layer.cornerRadius = 10
            followBtn.layer.shadowColor = UIColor.gray.cgColor
            followBtn.layer.shadowOpacity = 0.5
            followBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
            followBtn.layer.shadowRadius = 1
            imgProfile.loadS(urlS: userImg)
        }
        if profileSNid==0{
            profileSNid=SNId
        }
        
        actionsLoad()
    }
    
    func actionsLoad(){
        let dQ = DispatchQueue.global(qos: .background)
        dispatchGroup.enter()
        dQ.async {
            self.presenter?.getNewPostsF(isFromPage: false, isRefresh: false)
            self.sm.wait()
            self.presenter?.getFollowers(snId:self.profileSNid)
            self.sm.wait()
            self.presenter?.getFollowed(snId:self.profileSNid)
            self.sm.wait()
            self.dispatchGroup.leave()
        }
 
        dispatchGroup.notify(queue: .main) {
            print("NOTIFYY")
            self.numPublic.text="\(self.newPosts.count)"
            self.numFollowers.text="\(self.arrFollowers.count)"
            self.numFollowed.text="\(self.arrFollowed.count)"
            self.numFllws=self.arrFollowed.count
            self.numFllwrs=self.arrFollowers.count
            self.tblView.reloadData()
            self.shimmer.stopLoader()
            print("shimmer.stopLoader()")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECNews - FollowersVC ")
    }
    
    @IBAction func popView(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: false)
        _ = navigationController?.popViewController(animated: true)
        RealmManager.clearDataBase()
    }
    
    @IBAction func publicacionesClick(_ sender: Any) {
        _ = navigationController?.popViewController(animated: false)
        RealmManager.clearDataBase()
    }
    
    func setTapGestures(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(FollowersViewController.tFpublics))
        publicV.isUserInteractionEnabled = true
        publicV.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(FollowersViewController.tFfollowers))
        followersV.isUserInteractionEnabled = true
        followersV.addGestureRecognizer(tap2)
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(FollowersViewController.tFfollowed))
        followedV.isUserInteractionEnabled = true
        followedV.addGestureRecognizer(tap3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(unFollow))
        followBtn.isUserInteractionEnabled = true
        followBtn.addGestureRecognizer(tap)
    }
    
    func changeFollowBtn(){
   
        if follow {
            lblFollow.text = "Siguiendo"
            lblFollow.textColor = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1.0)
            iconFollow.image = UIImage(named: "iconFollow2", in: Bundle.local, compatibleWith: nil)
        }else{
            lblFollow.text = "Seguir"
            lblFollow.textColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1.0)
            iconFollow.image = UIImage(named: "iconFollow", in: Bundle.local, compatibleWith: nil)
        }
        
    }
    
    @objc func unFollow(){
        let follow2=follow
        print("unfollow")
        print("SE DEBERIA DE CAMBIAR EL ESTATUS")
        var t = 5
        switch type {
        case "Church":
            t = 2
        case "Community":
            t = 3
        default:
            t = 1
        }
        let f = Followers(image: userImg, name: userName, isFollow: follow2, userId: profileSNid, entityId: profileSNid, entityType: t)
        presenter?.followAndUnFollowedService(follower: f)//Followers
        follow = !follow
        changeFollowBtn()
        //delegate?.actionSelected(follower: follower, and: index ?? 0)*/
    }
    
    @objc func tFpublics(sender:UITapGestureRecognizer) {
        disclaimer=0
        formatoPublishActive(bool: true)
        formatoFollowedActive(bool: false)
        formatoFollowersActive(bool: false)
        tblView.reloadData()
    }
    
    @objc func tFfollowers(sender:UITapGestureRecognizer) {
        formatoPublishActive(bool: false)
        formatoFollowedActive(bool: false)
        formatoFollowersActive(bool: true)
        //presenter?.getFollowers()
        disclaimer=1
        arrInfoToShow = arrFollowers
        isFollowers = true
        tblView.reloadData()
    }
    
    @objc func tFfollowed(sender:UITapGestureRecognizer) {
        formatoPublishActive(bool: false)
        formatoFollowedActive(bool: true)
        formatoFollowersActive(bool: false)
        disclaimer=1
        //presenter?.getFollowed()
        arrInfoToShow = arrFollowed
        isFollowers = false
        tblView.reloadData()
    }
    
    // MARK: Formatos
    func formatoViewG(){
        viewG.layer.cornerRadius = 30
        viewG.layer.shadowRadius = 5
        viewG.layer.shadowOpacity = 0.5
        viewG.layer.shadowColor = UIColor.black.cgColor
        viewG.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func formatoPublishActive(bool:Bool){
        if bool {
            publicLbl.textColor=azulito
            numPublic.textColor=azulito
            publicV.layer.shadowColor = azulito?.cgColor
        }else{
            publicLbl.textColor = .gray
            numPublic.textColor = .gray
            publicV.layer.shadowColor = UIColor.gray.cgColor
        }
    }
    func formatoFollowersActive(bool:Bool){
        if bool {
            followersLbl.textColor=azulito
            numFollowers.textColor=azulito
            followersV.layer.shadowColor = azulito?.cgColor
        }else{
            followersLbl.textColor = .gray
            numFollowers.textColor = .gray
            followersV.layer.shadowColor = UIColor.gray.cgColor
        }
    }
    func formatoFollowedActive(bool:Bool){
        if bool {
            followedLbl.textColor=azulito
            numFollowed.textColor=azulito
            followedV.layer.shadowColor = azulito?.cgColor
        }else{
            followedLbl.textColor = .gray
            numFollowed.textColor = .gray
            followedV.layer.shadowColor = UIColor.gray.cgColor
        }
    }
    
    func formatoSegmentNew(){
        publicV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        followedV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        followersV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        publicV.layer.cornerRadius = 10
        followedV.layer.cornerRadius = 10
        followersV.layer.cornerRadius = 10
        publicV.layer.shadowRadius = 4
        publicV.layer.shadowOpacity = 0.5
        followedV.layer.shadowRadius = 4
        followedV.layer.shadowOpacity = 0.5
        followersV.layer.shadowRadius = 4
        followersV.layer.shadowOpacity = 0.5
        publicV.layer.shadowColor = UIColor.gray.cgColor
        publicV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        followedV.layer.shadowColor = UIColor.gray.cgColor
        followedV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        followersV.layer.shadowColor = UIColor.gray.cgColor
        followersV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

extension FollowersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if disclaimer == 0{
            return newPosts.count
        }else{
            return arrInfoToShow.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if disclaimer==0 {
         
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTVC", for: indexPath) as? FeedTVC else {
                return UITableViewCell()
            }
            if indexPath.row >= newPosts.startIndex && indexPath.row < newPosts.endIndex {
                //if newPosts[indexPath.row].author?.id == SNId{
                  //  cell.btnMoreActions.isHidden = false
                //}else{
            cell.btnMoreActions.isHidden = true
            cell.actionsView.isHidden = true
                //}
            cell.newPost = newPosts[indexPath.row]
            cell.newreactionButton.tag = indexPath.row
            cell.btnMoreActions.tag = indexPath.row
            cell.btnMoreActions.tag = indexPath.row
            cell.btnComments.tag = indexPath.row
            cell.btnShared.tag = indexPath.row
            cell.btnFollow.tag = indexPath.row
            cell.indexpath = indexPath.row
         
            //cell.delegate = self

            if newPosts[indexPath.row].scope?.id != nil && newPosts[indexPath.row].scope?.name != nil{
                cell.nameLabel.text = newPosts[indexPath.row].scope?.name
                cell.userImage.image = UIImage(named: "iconProfile", in: Bundle.local, compatibleWith: nil)
            }else{
                cell.nameLabel.text = newPosts[indexPath.row].author?.name
                if (newPosts[indexPath.row].author?.image) != nil{
                    cell.userImage.loadS(urlS: (newPosts[indexPath.row].author?.image)!)
                }else{
                    cell.userImage.image = UIImage(named: "iconProfile", in: Bundle.local, compatibleWith: nil)
                }
            }

            cell.lblCommentsCount.isHidden = false
            cell.commentImageView.isHidden = false
            cell.contentLabel.text = newPosts[indexPath.row].content
            cell.pistId = newPosts[indexPath.row].id ?? 0
            let iDate = newPosts[indexPath.row].createdAt
            let strDate = "\(iDate ?? 0)"
            cell.dateLabel.text = Date(timeIntervalSince1970: TimeInterval(strDate) ?? 0.0).formatRelativeString()
//            cell.reactionImageContainerView.isHidden = false
            cell.lblCommentsCount.text = "\(newPosts[indexPath.row].totalComments ?? 0)"
            cell.lblSharedCount.text = "0"
            cell.reactionsCountLabel.text = "\(newPosts[indexPath.row].totalReactions ?? 0)"
//            let stImgReation = newPosts[indexPath.row].totalReactions ?? 0 > 0 ? "iconOracion" : "iconOracion2"
            let stImgReation = newPosts[indexPath.row].reaction?.type == 1 ? "iconOracion2" : "iconOracion"
            cell.newreactionImage.image = UIImage(named: stImgReation, in: Bundle.local, compatibleWith: nil)
            
            if (newPosts[indexPath.row].multimedia?.count ?? 0 > 0){
                cell.collectionViewHeight.constant = 220
            }else{
                cell.collectionViewHeight.constant = 0
            }
                cell.tag = newPosts[indexPath.row].id ?? 0
                
            }else{
                print("ERROR index PAtH")
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FollowersTableViewCell", for: indexPath) as? FollowersTableViewCell
            cell?.setData(follower: arrInfoToShow[indexPath.row], and: indexPath.row)
            cell?.delegate = self
            cell?.selectionStyle = .none
                return cell ?? UITableViewCell()
        }
    }
    
}

extension FollowersViewController: CustomSegmentedControlDelegate{
    func changeToIndex(index: Int) {
    }
}

extension FollowersViewController: FollowersCellProtocol{
    func actionSelected(follower: Followers?, and index: Int) {
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        arrInfoToShow[index].isFollow = follower?.isFollow ?? false
        if isFollowers{
            arrFollowers[index].isFollow = follower?.isFollow ?? false
        }else{
            arrFollowed[index].isFollow = follower?.isFollow ?? false
        }
        guard let follower2 = follower else {
            return
        }
        print("::: VALOR de is follow:::")
        print(follower2.isFollow)
        presenter?.followAndUnFollowedService2(follower: follower2) //valores imvertidos de .isFollow
    }
}

extension FollowersViewController: FollowersViewProtocol {
    
    func followServiceSuccess(fuf:Bool) {
        if userImg == "self"{
            DispatchQueue.main.async {
                print("volvio de seguir en tabla de mi red")
                print(self.numFllws)
                if fuf{
                    self.numFllws+=1
                }else{
                    self.numFllws-=1
                }
                self.loadingView.isHidden = true
                self.activityIndicator.stopAnimating()
                self.numFollowed.text="\(self.numFllws)"
            }
        }else{
            DispatchQueue.main.async {
                print("volvio de seguir a usuario en su perfil")
                print(self.numFllwrs)
                if fuf{
                    self.numFllwrs+=1
                }else{
                    self.numFllwrs-=1
                }
                self.numFollowers.text="\(self.numFllwrs)"
            }
        }
        print("TODO OK")
    }
    
    func followServiceError(with error: SocialNetworkErrors) {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        print("FALLÓ ALGO")
    }
    
    func loadFollowers(followers: [Followers], hasMore:Bool) {
        print("FOLLOWERS")
        //print(followers)
        isFollowers=true
        numF2+=1
        arrFollowers.append(contentsOf: followers)
        if hasMore && numF2<20{
            presenter?.getFollowers(snId:profileSNid)
        }else{
            self.sm.signal()
        }
    }
    
    func loadFollowed(followeds: [Followers], hasMore:Bool) {
        print("FOLLOWEDS TOTALL:::")
        print(followeds.count)
        isFollowers=false
        numF+=1
        arrFollowed.append(contentsOf: followeds)
        arrInfoToShow = arrFollowed
        if hasMore && numF<20{
            presenter?.getFollowed(snId:profileSNid)
        }else{
            self.sm.signal()
        }
    }
    
    func didFinishGettingPostsF(isFromPage: Bool, posts: [Posts]) {
        timesCall+=1
        for post in posts {
            if profileSNid==0{
                if post.author?.id == SNId {
                    newPosts.append(post)
                }
            }else{
                print("SNId Profile:::")
                print(String(profileSNid))
                if post.author?.id == profileSNid {
                    newPosts.append(post)
                    print("SNId SI POST:::")
                    print(String(post.author?.id! ?? 0))
                }else{
                    print("SNId POST:::")
                    print(String(post.author?.id! ?? 0))
                }
            }
        }
        if newPosts.count<10 && timesCall<10{
            presenter?.getNewPostsF(isFromPage: false, isRefresh: false)
            print("OTro caLL a newposts")
        }else{
            timesCall=0
            self.sm.signal()
        }
    
    }
}
