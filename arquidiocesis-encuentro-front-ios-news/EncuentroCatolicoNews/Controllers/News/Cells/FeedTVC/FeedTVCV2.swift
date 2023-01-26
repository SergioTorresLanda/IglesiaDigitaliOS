//
//  FeedTVCV2.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/10/21.
//

import Foundation
import UIKit
import RealmSwift
import Lottie
import SDWebImage


public class FeedTVCV2: UITableViewCell{
    
    @IBOutlet weak var imgVwHeader: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnMoreOperation: UIButton!
    
    @IBOutlet weak var customLblInfo: UILabel!
    

    
    @IBOutlet public lazy var collectionViewInfoImgs: UICollectionView? = {
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    private let reactionsView = ReactionsPost()
    public var postV2: PublicationRealm? {
        didSet { collectionViewInfoImgs?.reloadData()}
    }
   
    override public func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    private func setUpView(){
        
        collectionViewInfoImgs?.setCorner(cornerRadius: 15)
        self.selectionStyle = .none
        imgVwHeader.makeRounded()
        
        collectionViewInfoImgs?.dataSource = self
        collectionViewInfoImgs?.delegate = self
        
        collectionViewInfoImgs?.register(UINib(nibName: "ImagesCVC", bundle: Bundle(for: ImagesCVC.self)), forCellWithReuseIdentifier: "ImagesCVC")
        collectionViewInfoImgs?.register(UINib(nibName: "VideoCVC", bundle: Bundle(for: VideoCVC.self)), forCellWithReuseIdentifier: "VideoCVC")
        collectionViewInfoImgs?.register(UINib(nibName: "LocationImageCVC", bundle: Bundle(for: LocationImageCVC.self)), forCellWithReuseIdentifier: "LocationImageCVC")
        
        
    }
    
}

extension FeedTVCV2: UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfMedia = postV2?.mediaList.count else{
            return 0
        }
        return numberOfMedia < 3 ? numberOfMedia : 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let media = postV2?.mediaList[indexPath.row]{
            switch media.mimeType{
            case "image/jpeg", "image/png":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath) as? ImagesCVC else {
                    return UICollectionViewCell()
                }
                let url = URL(string: media.url)
                cell.contentImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                
                cell.extraImagesView.isHidden = true
                cell.extraImagesLabel.isEnabled = true
                
                if indexPath.row == 2 {
                    if let numberOfMedia = postV2?.mediaList.count , numberOfMedia > 3 {
                        let extraImages = numberOfMedia - 3
                        
                        cell.extraImagesView.isHidden = false
                        cell.extraImagesLabel.isHidden = false
                        cell.extraImagesLabel.text = "+\(extraImages)"
                    }
                }
                return cell
                
            case "image/location":
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationImageCVC", for: indexPath) as? LocationImageCVC else {
                    return UICollectionViewCell()
                }
                let url = URL(string: media.url)
                cell.locationImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                return cell
                
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCVC", for: indexPath) as? VideoCVC else {
                    return UICollectionViewCell()
                }
                cell.videoURL = media.url
//                cell.delegate = self
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

//extension FeedTVC: UICollectionViewDelegate
extension FeedTVCV2: UICollectionViewDelegate{
    /*
     public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         delegate?.showDetailPost(id: self.tag)
     }
     */
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didselec image ::::::::::::::::::::::")
    }
}


//extension FeedTVCV2: UICollectionViewDelegateFlowLayout{
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//
//    }
//}

