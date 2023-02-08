////
////  ImagesTVC.swift
////  zeus-ios-sdk-new-social-network
////
////  Created by Miguel Angel Vicario Flores on 12/10/20.
////  Copyright © 2020 Gabriel Briseño. All rights reserved.
////
//
import UIKit


public class ImagesTVC: UITableViewCell, VideosDelegate {
    public func presentFullScreenVideo(videoURL: String?) {
        print("QUE no haga nada")
        //delegate?.presentFullScreenVideo(videoURL: videoURL)
    }
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var selectButton: UIButton!
    @IBOutlet public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    //MARK: - Properties
    public var media: [MediaData]? {
        didSet { collectionView?.reloadData() }
    }
    //public weak var delegate: FeedTVCProtocol?
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    public override func prepareForReuse() {
        media = nil
    }
    
    //MARK: - Methods
    private func setUpView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: "ImagesCVC", bundle: Bundle(for: ImagesCVC.self)), forCellWithReuseIdentifier: "ImagesCVC")
        collectionView?.register(UINib(nibName: "VideoCVC", bundle: Bundle(for: VideoCVC.self)), forCellWithReuseIdentifier: "VideoCVC")
    }
}

//MARK: - UICollectionViewDataSource
extension ImagesTVC: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfMedia = media?.count else { return 0 }
        return numberOfMedia < 3 ? numberOfMedia : 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let element = media?[indexPath.row] {
            print("ELEMENT OK")
            if let x = element.videoURL{
                print("ES VIDEO")
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCVC", for: indexPath) as! VideoCVC
                cell.videoURL = x.absoluteString
                cell.delegate = self
                return cell
            }else{
                print("ES IMAGEN")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as! ImagesCVC
            //Images
            cell.contentImage.image = element.image
            cell.extraImagesView.isHidden = true
            cell.extraImagesLabel.isHidden = true
            if indexPath.row == 2 {
                if let media = media, media.count > 3 {
                    let extraImages = media.count - 3
                    
                    cell.extraImagesView.isHidden = false
                    cell.extraImagesLabel.isHidden = false
                    cell.extraImagesLabel.text = "+\(extraImages)"
                }
            }
            return cell
                
            }
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as! ImagesCVC
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ImagesTVC: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ImagesTVC: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewHeight = collectionView.frame.height
        let collectionViewWidth = collectionView.frame.width

        switch media?.count {
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
    
}

