//
//  FeedData.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 04/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

//MARK: - UITableViewDataSource
extension Home_RedSocial: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return newPosts.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let userID = UserDefaults.standard.integer(forKey: "id")
        if indexPath.section == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreatePostTVC", for: indexPath) as? CreatePostTVC else {
                return UITableViewCell()
            }
            cell.nameLabel.text = "Sugerencia"
            
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTVC", for: indexPath) as? FeedTVC else {
                return UITableViewCell()
            }
            
            cell.newPost = newPosts[indexPath.row]
            cell.newreactionButton.tag = indexPath.row
            if userID == 1 || newPosts[indexPath.row].author?.id == SNId{
                cell.btnMoreActions.isHidden = false
            }
            else {
                cell.btnMoreActions.isHidden = true
            }
            
            cell.btnMoreActions.tag = indexPath.row
            cell.btnMoreActions.tag = indexPath.row
            cell.btnComments.tag = indexPath.row
            cell.btnShared.tag = indexPath.row
            cell.btnFollow.tag = indexPath.row
            cell.indexpath = indexPath.row
            cell.delegate = self
            
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
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension Home_RedSocial: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            // heigth CollectionView
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewFooter = UIView()
        viewFooter.layer.backgroundColor = UIColor.clear.cgColor
        return viewFooter
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 55
        }
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 130
        default:
            return 380
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            //let pages = storedData.pages
            //let pagesDifference = pages - storedData.skip
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            
            if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
                if #available(iOS 13.0, *) {
                    let spinner = UIActivityIndicatorView(style: .large)
                    spinner.startAnimating()
                    spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(60))
                    
                    tableView.tableFooterView = spinner
                    tableView.tableFooterView?.isHidden = false
                }
                print("FINAL DE TABLA")
                print("GET NEW POST PAGIN")
                print(String(indexPath.row))
                self.presenter?.getNewPostPagin(isFromPage: true, posts: newPosts, nxtPag: UserDefaults.standard.string(forKey: "nextPageTL") ?? "")
            }else {
                print("NO FINAL DE TABLA")
                //spinner.stopAnimating()
                //tableView.tableFooterView?.isHidden = true
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if indexPath.section == 1 {
        let post = newPosts[indexPath.row] //else { return }
            //presenter?.showPostDetail(navController: self.navigationController, post: post)
        //}
        let storyBoard: UIStoryboard = UIStoryboard(name: "RedSocialSB", bundle: Bundle.local)
        let newVC = storyBoard.instantiateViewController(withIdentifier: "RedSocialNewsViewController") as! RedSocialNewsViewController
        newVC.post = post
        self.navigationController!.pushViewController(newVC, animated: true)
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension Home_RedSocial: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let pagesDifference = storedData.pages - storedData.skip
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPaths.contains(IndexPath(row: lastRowIndex, section: 0)) && isPrefetching == false && pagesDifference > 1 {
            print("PREFETCH:: ")
            storedData.skip = storedData.skip + 1
            isPrefetching = true
            presenter?.getNewPosts(isFromPage: true, isRefresh: false)
        }
    }
    
}

//MARK: - DetailPostTVCProtocol
extension Home_RedSocial: FeedTVCProtocol {
    public func deletePost(id: Int, sender: UIButton) {
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let idPost = newPosts[id].id
        presenter?.getDeletePost(str: "\(APIType.shared.SN())/posts/\(idPost ?? 0)?userId=\(SNId)")
//        self.reloadTblData()
    }
    
    public func didTapURL(url: URL) {
        print("DID TAP URLLL")
        UIApplication.shared.open(url)
    }
    
    public func editPost(id: Int, snder: UIButton) {
//        guard let post = posts?[id] else { return }
//        guard let post = newPosts[id] else { return }
//        showEditPost(snder, editPost: true, post: post)
        print("·$%&")
        guard let vc = CreatePostRouter.createModule() as? RedSocial_CrearPost else { return }
        vc.hasManyGroups = false
        vc.editPost = true
        vc.typeData = "Normal"
        vc.newPostsInfo = newPosts[id]
        vc.delegateTbl = self
        vc.modalPresentationStyle = .pageSheet
        self.present(vc, animated: true)
    }
    
    public func actionSelected(idx: Int, typeAction: String) {
        switch typeAction{
        case "Comentarios":
            guard let vc = SNCommenctsRoute.createNewModule() as? CommentsViewController else { return }
            vc.newPost = newPosts[idx]
            self.navigationController?.pushViewController(vc, animated: true)
        case "Seguir":
            self.navigationController?.pushViewController(FollowersWireFrame.createFollowersModule(user: UserBasic(id:SNId, name: name, image: "self")), animated: true)
        case "Alert":
            self.showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para interactuar con el contenido de la red social.")
        default:
            break
        }
    }
    
    public func showDetailPost(id: Int) {
        print("Holaaaaa--------2")
        let post = newPosts[id]
        let storyBoard: UIStoryboard = UIStoryboard(name: "RedSocialSB", bundle: Bundle.local)
        let newVC = storyBoard.instantiateViewController(withIdentifier: "RedSocialNewsViewController") as! RedSocialNewsViewController
        newVC.post = post
        self.navigationController!.pushViewController(newVC, animated: true)
    }
    
    public func presentFullScreenVideo(videoURL: String?) {
        guard let videoURL = videoURL, let url = URL(string: videoURL) else { return }
        guard let vc = VideoPresenterRouter.createModule() as? VideoPresenterViewController else { return }
        vc.videoURL = url
        self.present(vc, animated: true)
    }
}


extension Home_RedSocial: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
