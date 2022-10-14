//
//  DetailPostData.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: - UITableViewDataSource
extension DetailPostViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            guard let comments = comments?.comments, !comments.isEmpty else { return 0 }
            return 1
        default:
            guard let comments = comments?.comments, comments.isEmpty else { return 0 }
            return 1
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTVC", for: indexPath) as? DetailPostTVC else { return UITableViewCell() }
            
            cell.delegate = self
            
            let userName = post.area?.name
            
            //Name
            cell.nameLabel.text = userName
            if post.asParam == "User" {
                cell.nameLabel.addUser(name: post.autor?.nombre)
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
            

            //Reaction Count
            cell.reactionsCountLabel.text = nil
            if post.countReact != 0 {
                cell.allReactionsButton.isUserInteractionEnabled = true
                cell.reactionsCountLabel.text = String(post.countReact)
            }
            
            cell.reactionsCountLabel.text = nil
            if post.countReact != 0 {
                if post.countReact - 1 == 0 {
                    cell.reactionsCountLabel.text = "Tu oración"
                } else {
                    cell.reactionsCountLabel.text = "Tu oración y " + String(post.countReact - 1) + " más"
                }
            } else {
                cell.reactionsCountLabel.text = String(post.countReact)
            }
            
            if post.myReaction == nil {
                cell.reactionImage.image = UIImage(named: "reactionG", in: Bundle.local, compatibleWith: nil)
                cell.reactionImage2.image = UIImage(named: "reactionG", in: Bundle.local, compatibleWith: nil)
                cell.reactionsCountLabel.textColor = UIColor.lightGray
                cell.reactionLabel.textColor = UIColor.lightGray
            } else {
                cell.reactionImage.image = UIImage(named: "orar", in: Bundle.local, compatibleWith: nil)
                cell.reactionImage2.image = UIImage(named: "orar", in: Bundle.local, compatibleWith: nil)
                cell.reactionsCountLabel.textColor = UIColor(red: 0.10, green: 0.16, blue: 0.45, alpha: 1.00)
                cell.reactionLabel.textColor = UIColor(red: 0.10, green: 0.16, blue: 0.45, alpha: 1.00)
            }
            
            
            //Reaction
            cell.reactionLabel.text = "Oración"

            
            
            //Media
            if !post.mediaList.isEmpty && post.mediaList.first?.mimeType != "image/location" {
                cell.pageControl.numberOfPages = post.mediaList.count
                cell.collectionViewHeight.constant = 440
            } else {
                cell.collectionViewHeight.constant = 0
            }
            
            
            //AllReactions
            cell.allReactionsButton.addTarget(self, action: #selector(showAllReactions), for: .touchUpInside)
            
            
            //Post
            cell.post = post
            
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCommentTVC", for: indexPath) as? PostDetailCommentTVC else { return UITableViewCell() }
            
            if let comment = comments?.comments[indexPath.row] {
                
                //Name
                let userName = comment.autor.nombre
                cell.nameLabel.text = userName
                
                
                //Image
                cell.userImage.setImage(name: userName, image: comment.autor.imagen)
                
                
                //Date
                cell.dateLabel.text = Date(timeIntervalSince1970: TimeInterval(comment.created)).formatRelativeString()
                
                
                //Content
                cell.contentLabel.text = comment.content
                cell.contentLabel.handleURLTap { (url) in
                    UIApplication.shared.open(url.formattedURL(), options: [:]) { (isOpen) in
                        print(isOpen)
                    }
                }
                

                //LookMoreButton
//                cell.lookMoreCommentsButton.addTarget(self, action: #selector(showMoreComments), for: .touchUpInside)
            }
            
            return cell
            
            default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCommentTVC", for: indexPath) as? PostDetailCommentTVC else { return UITableViewCell() }
                return cell
        }
    }
    
}

//MARK: - UITableViewDelegate
extension DetailPostViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        default:
            return 200
        }
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 440
        case 1:
            return 120
        default:
            return 200
        }
    }
}

//MARK: - DetailPostTVCProtocol
extension DetailPostViewController: DetailPostTVCProtocol {
    public func presentFullScreenVideo(videoURL: String?) {
        guard let videoURL = videoURL, let url = URL(string: videoURL) else { return }
        let vc = VideoPresenterRouter.createModule() as! VideoPresenterViewController
        vc.videoURL = url
        self.present(vc, animated: true)
    }
    
    public func showMoreImages() {
        presenter?.showImages(navController: self.navigationController, media: post.mediaList)
    }
}
