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
extension FeedViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let numberOfPosts = posts?.count else { return 0 }
            return numberOfPosts
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTVC", for: indexPath) as! FeedTVC
            
            if let post = posts?[indexPath.row] {
                
                cell.delegate = self
                
                let userName = post.area?.name
                
                //Name
                cell.nameLabel.text = userName
                if post.asParam == "User" {
                    cell.nameLabel.addUser(name: post.autor?.nombre)
//                    cell.editPostView.isHidden = SocialNetworkConstant.shared.userId == post.autor?.FIIDEMPLEADO ? false : true
                } else {
//                    cell.editPostView.showEditView(groupId: post.area?.id)
                }
                
                
                //Imagen
                cell.userImage.setImage(name: userName, image: post.area?.img)
                
                
                //Location
                if let location = post.location, let locationName = location.nameLocation {
                    cell.nameLabel.addMoreInfo(locationName)
                }
                
                
                //Feeling
                if let feeling = post.feeling, let url = URL(string: feeling.img) {
                    UIImageView().sd_setHighlightedImage(with: url, options: .refreshCached) { (image, error, _, _) in
                        cell.nameLabel.addMoreInfo(feeling.type, index: cell.nameLabel.text?.count, image: image, text: "se siente")
                    }
                }
                
                
                //Date
                cell.dateLabel.text = Date(timeIntervalSince1970: TimeInterval(post.created)).formatRelativeString()
                
                
                //Content
                cell.contentLabel.text = post.content
                cell.contentLabel.handleURLTap { (url) in
                    UIApplication.shared.open(url.formattedURL(), options: [:]) { (isOpen) in
                        print(isOpen)
                    }
                }
                
                //ReactionCount
                cell.reactionsCountLabel.text = nil
                if post.countReact != 0 {
                    cell.reactionsCountLabel.text = String(post.countReact)
                }else{
                    cell.reactionsCountLabel.text = String(post.countReact)
                }
                
                
                //Reaction
                cell.reactionImageContainerView.isHidden = false
                cell.reactionImage.image = UIImage(named: "reactionG", in: Bundle(for: FeedViewController.self), compatibleWith: nil)
//                if let myReaction = post.myReaction, let url = URL(string: myReaction.img) {
//                    cell.reactionImageContainerView.isHidden = false
//
//                    cell.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
//                }
                
                cell.post = post
                if !post.mediaList.isEmpty {
                    cell.collectionViewHeight.constant = 220
                } else {
                    cell.collectionViewHeight.constant = 0
                }
                
                cell.tag = post.id
            }
            
            return cell
        
    }
}

//MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewFooter = UIView()
        viewFooter.layer.backgroundColor = UIColor.clear.cgColor
        return viewFooter
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 55
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return 380
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pages = storedData.pages
        let pagesDifference = pages - storedData.skip
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        let spinner = UIActivityIndicatorView(style: .gray)
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && pagesDifference > 1 {
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(45))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        } else {
            spinner.stopAnimating()
            tableView.tableFooterView?.isHidden = true
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            guard let post = posts?[indexPath.row] else { return }
            presenter?.showPostDetail(navController: self.navigationController, post: post)
//            presenter?.watchPost(postId: post.id)
        }
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension FeedViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let pagesDifference = storedData.pages - storedData.skip
        let lastRowIndex = tableView.numberOfRows(inSection: 0)
        if indexPaths.contains(IndexPath(row: lastRowIndex, section: 0)) && isPrefetching == false && pagesDifference > 1 {
            storedData.skip = storedData.skip + 1
            isPrefetching = true
            presenter?.getPosts(isFromPage: true)
        }
    }
    
}

//MARK: - DetailPostTVCProtocol
extension FeedViewController: FeedTVCProtocol {
    public func showDetailPost(id: Int) {
        guard let post = RealmManager.fetchDataForPK(object: PublicationRealm.self, id: id) else { return }
        presenter?.showPostDetail(navController: self.navigationController, post: post)
    }
    
    public func presentFullScreenVideo(videoURL: String?) {
        guard let videoURL = videoURL, let url = URL(string: videoURL) else { return }
        let vc = VideoPresenterRouter.createModule() as! VideoPresenterViewController
        vc.videoURL = url
        self.present(vc, animated: true)
    }
}
