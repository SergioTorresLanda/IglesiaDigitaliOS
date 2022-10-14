//
//  createPostTVC.swift
//  EncuentroCatolicoNews
//
//  Created by Branchbit on 18/03/21.
//

import UIKit

public class CreatePostTVC: UITableViewCell {

    //MARK: - @IBOutlets
    @IBOutlet public weak var createPostView: UIView!
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet public weak var createPostButton: UIButton!
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var subCollectionView: UICollectionView!
    private var arDataCollection = ["Collection1", "Collection2", "Collection3", "Collection4", "Collection5", "Collection6", "Collection7", "Collection8"]
    let defaults = UserDefaults.standard
    
    @IBOutlet public weak var smileFaceImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "smileFaceIcon".getImage()
           
        return imageView
    }()
    
    @IBOutlet public weak var locationImage: UIImageView! = {
       let imageView = UIImageView()
       imageView.image = "locationIcon".getImage()
           
       return imageView
    }()
    
    @IBOutlet public weak var multimediaImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = "imagesIcon".getImage()
              
        return imageView
    }()
    
    //MARK: - Life cycle
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.subCollectionView.delegate = self
        self.subCollectionView.dataSource = self
        self.subCollectionView.register(CreatePostCollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.subCollectionView.showsHorizontalScrollIndicator = false
        setUpView()
    }
    
    private func setUpView() {
        nameLabel.text = defaults.string(forKey: "COMPLETENAME")
        userImage.image = SocialNetworkConstant.shared.userImage
        
        userImage.makeRounded()
        vwContainer.backgroundColor = UIColor.white
    }

}

extension CreatePostTVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 64, height: 64)
        }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arDataCollection.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CreatePostCollectionCell else {return UICollectionViewCell() }
        cell.setDataCell(strTitle: arDataCollection[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Seleccionó::: \(indexPath.row)")
    }
}

public class CreatePostCollectionCell: UICollectionViewCell{
//    fileprivate let lblTitle: UILabel = {
//        let lbl = UILabel()
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
    
    
    fileprivate let imgView: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 11
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect){
        super.init(frame: .zero)
//        contentView.addSubview(lblTitle)
        contentView.addSubview(imgView)
        
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imgView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        imgView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func setDataCell(strTitle: String){
//        lblTitle.text = strTitle
        if #available(iOS 13.0, *) {
            imgView.image = UIImage(named: "grupoS", in: Bundle.local, with: nil)
        } else {
            // Fallback on earlier versions
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
