//
//  FavouriteChurchCollectionViewCell.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 03/10/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import UIKit
import AlamofireImage
import SkeletonView
import RealmSwift

class FavouriteChurchCollectionViewCell: UICollectionViewCell {

    //MARK: - Static values for init
    static let reuseIdentifier = "FavouriteChurchCollectionViewCell"
    static let nib = UINib(nibName: FavouriteChurchCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: FavouriteChurchCollectionViewCell.self))
    static let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    static let gradient = SkeletonGradient(baseColor: UIColor.clouds)
    //MARK: - IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var churchImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    let placeHolderimage = UIImage(named: "church-placeholder", in: Bundle(for: FavouriteChurchCollectionViewCell.self), compatibleWith: nil)
    override func awakeFromNib() {
        super.awakeFromNib()
        churchImage.isSkeletonable = true
        nameLabel.isSkeletonable = true
        let placeHolderimage = UIImage(named: "church-placeholder", in: Bundle(for: FavouriteChurchCollectionViewCell.self), compatibleWith: nil)
        churchImage.image = placeHolderimage
        //containerChurch.layer.cornerRadius = 15
        cardView.layer.cornerRadius = 15
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1548789321)
        cardView.layer.shadowRadius = 7
        cardView.layer.shadowOpacity = 1
      
    }
    //MARK: Init
    func fill(with church: Assigned) {
        churchImage.isSkeletonable = true
        nameLabel.isSkeletonable = true
        nameLabel.showAnimatedGradientSkeleton(usingGradient: FavouriteChurchCollectionViewCell.gradient, animation: FavouriteChurchCollectionViewCell.animation)
        churchImage.showAnimatedGradientSkeleton(usingGradient: FavouriteChurchCollectionViewCell.gradient, animation: FavouriteChurchCollectionViewCell.animation)
        nameLabel.showSkeleton(usingColor: .clouds, transition: .crossDissolve(0.25))
        churchImage.showSkeleton(usingColor: .clouds, transition: .crossDissolve(0.25))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
            self.nameLabel.hideSkeleton()
            self.churchImage.hideSkeleton()
        })
        churchImage.image = placeHolderimage
        let url = church.image_url ?? "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg"
        churchImage.downloaded(from: url)
        nameLabel.text = church.name
        churchImage.contentMode = .scaleAspectFill
    }
}

