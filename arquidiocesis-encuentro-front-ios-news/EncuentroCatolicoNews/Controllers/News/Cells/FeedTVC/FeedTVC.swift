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


public protocol FeedTVCProtocol: AnyObject {
    func presentFullScreenVideo(videoURL: String?)
    func showDetailPost(id: Int)
    func editPost(id: Int, snder: UIButton)
    func deletePost(id: Int, sender: UIButton)
    func actionSelected(idx: Int, typeAction: String)
    func didTapURL(url: URL)
}

public class FeedTVC: UITableViewCell, CustomPopOverDelegate {
    
    //MARK: - @IBoutlets
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var contentLabel: CustomLabel!
    
    
    @IBOutlet weak var newreactionImage: UIImageView!
    @IBOutlet weak var newreactionImageContainerView: UIView!
    
    @IBOutlet weak var newreactionButton: UIButton!
    @IBOutlet public weak var reactionsCountLabel: UILabel!
    @IBOutlet public weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet public weak var loading: UIActivityIndicatorView!
    
    @IBOutlet public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView()
        
        return collectionView
    }()
    
    @IBOutlet weak var btnMoreActions: UIButton!
    @IBOutlet weak var commentsImageContainerView: UIView!
    @IBOutlet weak var sharedImageContainerView: UIView!
    @IBOutlet weak var followImageContainerView: UIView!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var sharedImageView: UIImageView!
    @IBOutlet weak var followImageView: UIImageView!
    
    @IBOutlet weak var lblCommentsCount: UILabel!
    @IBOutlet weak var lblSharedCount: UILabel!
    
    @IBOutlet weak var btnComments: UIButton!
    @IBOutlet weak var btnShared: UIButton!
    @IBOutlet weak var btnFollow: UIButton!
    var pistId: Int = 0
    var newPost: Posts?
    var url=""
    var indexpath=0
    
    //MARK: - Properties
    var btnsender: UIButton!
    var customPopOver: CustomPopOverView!
    public weak var delegate: FeedTVCProtocol?
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
        contentLabel.delegate = self
//        reactionImage.image = nil
        reactionsCountLabel.text = nil
        post = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        loading.isHidden = true
        btnMoreActions.setTitle("", for: .normal)
        btnComments.setTitle("", for: .normal)
        btnShared.setTitle("", for: .normal)
        btnFollow.setTitle("", for: .normal)
        collectionView?.setCorner(cornerRadius: 15)
        self.selectionStyle = .none
//        let SNId = UserDefaults.standard.integer(forKey: "SNId")
//        btnMoreActions.isHidden = newPost?.author?.id == SNId ? false : true
        userImage.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        
        userImage.layer.borderWidth = 0.5
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.clipsToBounds = true
        
        userImage.makeRounded()
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "ImagesCVC", bundle: Bundle(for: ImagesCVC.self)), forCellWithReuseIdentifier: "ImagesCVC")
        collectionView?.register(UINib(nibName: "VideoCVC", bundle: Bundle(for: VideoCVC.self)), forCellWithReuseIdentifier: "VideoCVC")
        collectionView?.register(UINib(nibName: "LocationImageCVC", bundle: Bundle(for: LocationImageCVC.self)), forCellWithReuseIdentifier: "LocationImageCVC")
//        reactionButton.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
//        reactionImage.image  = UIImage(named: "reactionG")
        btnMoreActions.setTitleColor(UIColor(red: 54.0/255.0, green: 54.0/255.0, blue: 54.0/255.0, alpha: 1), for: .normal)
        btnMoreActions.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
    }
    
    @IBAction func btnMoreActions(_ sender: UIButton) {

        btnsender = sender
        customPopOver = CustomPopOverView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: 70.0, height: 60)))
        customPopOver.table.optionSelectDelegate = self
        customPopOver.showPopover(sourceView: sender)
        
    }
    
    func selectedOption(select: String) {
        switch select{
        case "Editar":
            customPopOver.dismissPopover(animated: true, completion: {
                // GGG1
                self.delegate?.editPost(id: self.btnMoreActions.tag, snder: self.btnsender)
            })
        case "Eliminar", "Denunciar":
            customPopOver.dismissPopover(animated: true, completion: {
                
                self.delegate?.deletePost(id: self.btnMoreActions.tag, sender: self.btnsender)
            })
        default:
            break
        }
    }
    
    @objc public func handleLongPress(gesture: UILongPressGestureRecognizer) {
    }
    
    private func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
    }
    
    private func handleGestureChanged(gesture: UILongPressGestureRecognizer) {
    }
    
    @objc private func openMap(_ sender: UIButton) {
        if let locationName = post?.location?.nameLocation, let lat = post?.location?.lat, let lng = post?.location?.lng {
            OpenMap.forPlace(name: locationName, latitude: lat, longitude: lng)
        }
    }
    
    //MARK: - Actions
    @IBAction private func setReaction(_ sender: UIButton) {
//        let identifier = storedData.defaultReactionId
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        loading.isHidden = false
        loading.startAnimating()
        if newPost?.reaction?.type == 1{
            //Elimina like
            print("Debe de eliminar el like")
            let stUrl = "\(APIType.shared.SN())/reactions/666"
            newMakeDeleteResaction(reactionId: 0, userID: SNId, strUrl: "")
        }else{
            let strUrl = "\(APIType.shared.SN())/posts/\(pistId)/react"
            newMakeReaction(reactionId: 1, userID: SNId, strUrl: strUrl)
        }
    }
    
    @IBAction func btnActionComments(_ sender: UIButton) {
        self.delegate?.actionSelected(idx: self.btnComments.tag, typeAction: "Comentarios")
    }
    
    @IBAction func btnActionCompartit(_ sender: UIButton) {
        self.delegate?.actionSelected(idx: self.btnShared.tag, typeAction: "Seguir")
    }
    
    @IBAction func btnActionFollow(_ sender: UIButton) {
        self.delegate?.actionSelected(idx: self.btnFollow.tag, typeAction: "Seguir")
    }
}

//MARK: - UICollectionViewDataSource
extension FeedTVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        guard let numberOfMedia = post?.mediaList.count else { return 0 }
        guard let numberOfMedia = newPost?.multimedia?.count else { return 0}
        return numberOfMedia < 3 ? numberOfMedia : 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let media = post?.mediaList[indexPath.row]
        if let media = newPost?.multimedia?[indexPath.row]{
            switch media.format {
            case "jpeg", "png":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as? ImagesCVC else { return UICollectionViewCell() }
                let url = URL(string: media.url ?? "")
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
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationImageCVC", for: indexPath) as? LocationImageCVC else { return UICollectionViewCell() }
                let url = URL(string: media.url ?? "")
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
        print("tag :::::::::::::")
        print(String(indexpath))
        delegate?.showDetailPost(id: indexpath)
      
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeedTVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewHeight = collectionView.frame.height
        let collectionViewWidth = collectionView.frame.width

        if let media = newPost?.multimedia, !media.isEmpty && collectionView.frame.height > 1 {
            switch newPost?.multimedia?.count {
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

extension FeedTVC: CustomLabelDelegate {
    public func didSelect(_ text: String, type: CustomLabelType) {
        
        print("aqui esta el link \(text)")
        if let url = URL(string: text) {
                  UIApplication.shared.open(url)
               }
    }
    
//    func didTapStringURL(_ stringURL: String) {
//        print(stringURL)
//        if let url = URL(string: stringURL) {
//            delegate?.didTapURL(url: url)
//        }
//    }

}
