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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPostTVC", for: indexPath) as! DetailPostTVC
            
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
            
            
            //Reaction
            cell.reactionLabel.text = "Me enorgullece"
            cell.reactionLabel.textColor = UIColor(red: 0.48, green: 0.56, blue: 0.65, alpha: 1.00)
            if let myReaction = post.myReaction, let url = URL(string: myReaction.img) {
                cell.reactionLabel.text = myReaction.type
                cell.reactionLabel.textColor = UIColor(hex: myReaction.color)
                
                cell.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                
                cell.reactionImage.image  = UIImage(named: "reactionG")
            }
            
            
            //TopReactions
            cell.reactionsStackView.subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            
            topReactions?.topReactions.forEach({ (topReaction) in
                guard let url = URL(string: topReaction.img) else { return }
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
                imageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                cell.reactionsStackView.addArrangedSubview(imageView)
            })
            
            
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCommentTVC", for: indexPath) as! PostDetailCommentTVC
            
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
                let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailCommentTVC", for: indexPath) as! PostDetailCommentTVC
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
