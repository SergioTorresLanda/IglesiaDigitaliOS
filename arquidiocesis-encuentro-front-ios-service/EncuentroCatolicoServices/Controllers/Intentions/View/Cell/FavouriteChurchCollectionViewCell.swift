//
//  FavouriteChurchCollectionViewCell.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 03/10/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import UIKit
import AlamofireImage

class FavouriteChurchCollectionViewCell: UICollectionViewCell {

    //MARK: - Static values for init
    static let reuseIdentifier = "FavouriteChurchCollectionViewCell"
    static let nib = UINib(nibName: FavouriteChurchCollectionViewCell.reuseIdentifier,
                           bundle: Bundle(for: FavouriteChurchCollectionViewCell.self))
    
    //MARK: - IBOutlets
    @IBOutlet weak var churchImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Local variables
    let placeHolderimage = UIImage(named: "church-placeholder", in: Bundle(for: FavouriteChurchCollectionViewCell.self), compatibleWith: nil)
    
    //MARK: Init
    func fill(with church: Assigned) {
        churchImage.image = placeHolderimage
        let url = church.imageUrl ?? "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg"
        churchImage.downloaded(from: url)
        nameLabel.text = church.name
        churchImage.contentMode = .scaleAspectFill
    }

}
