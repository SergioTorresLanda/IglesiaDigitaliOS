//
//  FeedTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 04/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import RealmSwift
import Lottie
import SDWebImage

public protocol FeedTVCProtocol: class {
    func presentFullScreenVideo(videoURL: String?)
    func showDetailPost(id: Int)
}

public class FeedTVC: UITableViewCell {
    
    //MARK: - @IBoutlets
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var contentLabel: CustomLabel!
    @IBOutlet public weak var reactionImage: UIImageView!
    @IBOutlet public weak var reactionImageContainerView: UIView!
    @IBOutlet public weak var reactionButton: UIButton!
    @IBOutlet public weak var reactionsCountLabel: UILabel!
    @IBOutlet public weak var collectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    //MARK: - Properties
    public weak var delegate: FeedTVCProtocol?
    private let reactionsView = ReactionsPost()
    public var post: PublicationRealm? {
        didSet { collectionView?.reloadData() }
    }
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        setUpView()
    }
    
    public override func prepareForReuse() {
        nameLabel.text = nil
        userImage.image = nil
        dateLabel.text = nil
        contentLabel.text = nil
//        reactionImage.image = nil
        reactionsCountLabel.text = nil
        post = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        collectionView?.roundCorners(corners: [.layerMaxXMinYCorner, .layerMinXMaxYCorner], radius: 40)
        self.selectionStyle = .none
        userImage.makeRounded()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "ImagesCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "ImagesCVC")
        collectionView?.register(UINib(nibName: "VideoCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "VideoCVC")
        collectionView?.register(UINib(nibName: "LocationImageCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "LocationImageCVC")
        
        reactionButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        
        reactionImage.image  = UIImage(named: "reactionG")
    }
    
    @objc public func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.reactionsView.subviews.first
                stackView?.subviews.forEach({ (subview) in
                    let animation = subview as? AnimationView
                    animation?.stop()
                    animation?.transform = .identity
                    
                    if let animation = animation, let identifier = animation.accessibilityIdentifier,
                        let identifierInt = Int(identifier), animation.tag == 1 {
                        self.makeReaction(postId: self.tag, reactionId: identifierInt)
                    }
                })
                
                self.reactionsView.transform = self.reactionsView.transform.translatedBy(x: 0, y: 50)
                self.reactionsView.alpha = 0
                
            }, completion: { (_) in
                self.reactionsView.removeFromSuperview()
            })
            
        } else if gesture.state == .changed {
            handleGestureChanged(gesture: gesture)
        }
    }
    
    private func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        self.addSubview(reactionsView)
        
        let reactionButtonFrame = reactionButton.frame
        let centeredX = reactionButtonFrame.width
        
        reactionsView.alpha = 0
        reactionsView.transform = CGAffineTransform(translationX: centeredX,
                                                    y: self.contentView.frame.height - (reactionButtonFrame.height * 2))
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.reactionsView.alpha = 1
            self.reactionsView.transform = CGAffineTransform(translationX: centeredX,
                                                             y: self.contentView.frame.height - (reactionButtonFrame.height * 2))
        })
        
        let stackView = reactionsView.subviews.first
        stackView?.subviews.forEach({ (subview) in
            let animation = subview as? AnimationView
            animation?.play()
        })
    }
    
    private func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
        let pressedLocation = gesture.location(in: reactionsView)
        let reactionsViewFrame = reactionsView.frame
        
        let fixedLocation = CGPoint(x: pressedLocation.x, y: reactionsViewFrame.height / 2)
        let hitTestView = reactionsView.hitTest(fixedLocation, with: nil)
        
        if fixedLocation.x > 0 && fixedLocation.x < reactionsViewFrame.width {
            if hitTestView is AnimationView {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    let stackView = self.reactionsView.subviews.first
                    stackView?.subviews.forEach({ (animation) in
                        animation.transform = .identity
                        animation.tag = 0
                    })
                    
                    hitTestView?.transform = CGAffineTransform(translationX: 0, y: -50)
                    hitTestView?.tag = 1
                })
            }

        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                let stackView = self.reactionsView.subviews.first
                stackView?.subviews.forEach({ (animation) in
                    animation.transform = .identity
                    animation.tag = 0
                    
                    if animation.transform == CGAffineTransform(translationX: 0, y: -50) {
                        animation.transform = CGAffineTransform(translationX: 0, y: 50)
                    }
                })
            })
        }
    }
    
    @objc private func openMap(_ sender: UIButton) {
        if let locationName = post?.location?.nameLocation, let lat = post?.location?.lat, let lng = post?.location?.lng {
            OpenMap.forPlace(name: locationName, latitude: lat, longitude: lng)
        }
    }
    
    //MARK: - Actions
    @IBAction private func setReaction(_ sender: UIButton) {
        let identifier = storedData.defaultReactionId
        makeReaction(postId: self.tag, reactionId: identifier)
    }
}

//MARK: - UICollectionViewDataSource
extension FeedTVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfMedia = post?.mediaList.count else { return 0 }
        return numberOfMedia < 3 ? numberOfMedia : 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let media = post?.mediaList[indexPath.row] {
            switch media.mimeType {
            case "image/jpeg", "image/png":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as! ImagesCVC
                
                let url = URL(string: media.url)
                cell.contentImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                
                cell.extraImagesView.isHidden = true
                cell.extraImagesLabel.isHidden = true
                
                if indexPath.row == 2 {
                    if let numberOfMedia = post?.mediaList.count , numberOfMedia > 3 {
                        let extraImages = numberOfMedia - 3
                        
                        cell.extraImagesView.isHidden = false
                        cell.extraImagesLabel.isHidden = false
                        cell.extraImagesLabel.text = "+\(extraImages)"
                    }
                }
                
                return cell
            case "image/location":
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationImageCVC", for: indexPath) as! LocationImageCVC
                
                let url = URL(string: media.url)
                cell.locationImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                
                cell.actionButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
                cell.actionButton.tag = indexPath.row
                
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCVC", for: indexPath) as! VideoCVC
                
                cell.videoURL = media.url
                
                cell.delegate = self

                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
}

//MARK: - UICollectionViewDelegate
extension FeedTVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showDetailPost(id: self.tag)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeedTVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewHeight = collectionView.frame.height
        let collectionViewWidth = collectionView.frame.width

        if let media = post?.mediaList, !media.isEmpty && collectionView.frame.height > 1 {
            switch post?.mediaList.count {
            case 1:
                return CGSize(width: collectionViewWidth, height: collectionViewHeight)
            case 2:
                return CGSize(width: (collectionViewWidth / 2), height: collectionViewHeight)
            default:
                if indexPath.row == 0 {
                     return CGSize(width: (collectionViewWidth / 2), height: collectionViewHeight)
                } else if indexPath.row == 1 {
                     return CGSize(width: (collectionViewWidth / 2), height: (collectionViewHeight / 2))
                } else {
                     return CGSize(width: (collectionViewWidth / 2), height: (collectionViewHeight / 2))
                }
            }
        }
        
        return CGSize(width: 0, height: 0)
    }
    
}

//MARK: - VideosDelegate
extension FeedTVC: VideosDelegate {
    public func presentFullScreenVideo(videoURL: String?) {
        delegate?.presentFullScreenVideo(videoURL: videoURL)
    }
}
