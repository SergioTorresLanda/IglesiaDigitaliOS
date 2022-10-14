//
//  DetailPostTVC.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage
import Lottie

public protocol DetailPostTVCProtocol: class {
    func presentFullScreenVideo(videoURL: String?)
    func showMoreImages()
}

public class DetailPostTVC: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var contentLabel: CustomLabel!
    @IBOutlet public weak var reactionsCountLabel: UILabel!
    @IBOutlet public weak var reactionImage: UIImageView!
    @IBOutlet public weak var allReactionsButton: UIButton!
    @IBOutlet public weak var reactionButton: UIButton!
    @IBOutlet public weak var reactionLabel: UILabel!
    @IBOutlet public weak var pageControl: UIPageControl!
    @IBOutlet public weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet public weak var containerMedia: UIView!
    @IBOutlet public weak var reactionImage2: UIImageView!
    @IBOutlet public weak var loading: UIActivityIndicatorView!
    
    @IBOutlet public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    //MARK: - Properties
    public weak var delegate: DetailPostTVCProtocol?
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
        userImage.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
        
        contentLabel.text = nil
        reactionsCountLabel.text = nil
        reactionLabel.text = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        loading.isHidden = true
        
        userImage.makeRounded()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "ImagesCVC", bundle: Bundle(for: ImagesCVC.self)), forCellWithReuseIdentifier: "ImagesCVC")
        collectionView?.register(UINib(nibName: "VideoCVC", bundle: Bundle(for: VideoCVC.self)), forCellWithReuseIdentifier: "VideoCVC")
        collectionView?.register(UINib(nibName: "LocationImageCVC", bundle: Bundle(for: LocationImageCVC.self)), forCellWithReuseIdentifier: "LocationImageCVC")
        
        reactionButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
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
                    
                    if animation?.tag == 1, let identifier = animation?.accessibilityIdentifier,
                        let identifierInt = Int(identifier), let post = self.post {
                        self.makeComment(postId: post.id, reactionId: identifierInt)
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
        
        reactionsView.alpha = 0
        reactionsView.transform = CGAffineTransform(translationX: self.contentView.frame.midX,
                                                    y: self.contentView.frame.height - (reactionsView.frame.height * 2))
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.reactionsView.alpha = 1
            self.reactionsView.transform = CGAffineTransform(translationX: self.contentView.frame.midX,
                                                             y: self.contentView.frame.height - (self.reactionsView.frame.height) * 2)
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
        guard let id = post?.id else { return }
        let identifier = storedData.defaultReactionId
        loading.isHidden = false
        loading.startAnimating()
        sender.isUserInteractionEnabled = false
        makeComment(postId: id, reactionId: identifier)
    }
}

//MARK: - UICollectionViewDataSource
extension DetailPostTVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfMedia = post?.mediaList.count else { return 0 }
        return numberOfMedia
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
extension DetailPostTVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showMoreImages()
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard let numberOfMedia = post?.mediaList.count else { return }
        targetContentOffset.pointee = scrollView.contentOffset
//        let cellWidth: Double = Double(self.frame.width)
        let cellWidth: Double = Double(UIScreen.main.bounds.width)
        
        
        var page: Double = Double(scrollView.contentOffset.x) / cellWidth + Double(0.5)
 
        if (velocity.x > 0) { page += 0.5 }
        if (velocity.x < 0) { page -= 0.5 }
        page = max(page, 0)
        
        if page >= Double(numberOfMedia) {
            page = Double(numberOfMedia - 1)
        }
        
        let indexPath: IndexPath = IndexPath(row: Int(page), section:0)
        pageControl.currentPage = Int(page)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.left, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailPostTVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: - VideosDelegate
extension DetailPostTVC: VideosDelegate {
    public func presentFullScreenVideo(videoURL: String?) {
        delegate?.presentFullScreenVideo(videoURL: videoURL)
    }
}
