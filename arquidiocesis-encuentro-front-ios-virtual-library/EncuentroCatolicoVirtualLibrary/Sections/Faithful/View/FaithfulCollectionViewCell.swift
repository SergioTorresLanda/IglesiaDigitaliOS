//
//  FaithfulCollectionViewCell.swift
//  FielSOS
//
//  Created by René Sandoval on 21/03/21.
//

import UIKit

protocol SelectionDelegate {
    func didSelect(id: Int, priest: Priest, nameIgl: String)
}

class FaithfulCollectionViewCell: SwipeCollectionViewCell {
    static let id = "FaithfulCollectionViewCell"

    var selectionDelegate: SelectionDelegate?
    let defaultImage = URL(string: "https://www.eluniversal.com.mx/sites/default/files/2017/12/12/sanrtuario_53514247.jpg")
    var location: LocationSOS? {
        didSet {
            guard let location = self.location else { return }
            self.nameChurchLabel.text = location.name
            self.locationId = location.id
            self.priests = location.priests
            
            if (location.distance / 1000.0) == 0.0 {
                self.distanceChurchLabel.isHidden = true
            } else {
                self.distanceChurchLabel.text = "\(location.distance / 1000.0) km"
                self.distanceChurchLabel.isHidden = false
            }
            
            self.imageFromUrl(url: location.image_url)
            self.priestCollectionView.reloadData()
        }
    }

    lazy var locationId = 0
    lazy var priests = [Priest]()

    var churchImage: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "church_image", in: Bundle.local, compatibleWith: nil)
        image.contentMode = .scaleAspectFill
        return image
    }()

    var nameChurchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = Colors.main
        return label
    }()
    
//    var timeChurchLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        label.text = "9:30 hrs, 10:30 hrs,\n12:00 hrs, 13:00 hrs"
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: 11)
//        label.textColor = Colors.titles
//        return label
//    }()
    
    var distanceChurchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "2.5 km"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.textColor = Colors.titles
        return label
    }()

    var priestCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0

        priestCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        priestCollectionView.backgroundColor = .clear
        priestCollectionView.register(PriestsCollectionViewCell.self, forCellWithReuseIdentifier: PriestsCollectionViewCell.id)
        priestCollectionView.dataSource = self
        priestCollectionView.delegate = self
        
        churchImage.layer.masksToBounds = false
        churchImage.layer.cornerRadius = 10.0
        churchImage.clipsToBounds = true
    }
    
    func imageFromUrl(url: String){
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: (URL(string: url) ?? self.defaultImage)!)
            let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
            DispatchQueue.main.async {
                self.churchImage.image = image
            }
        }
    }

    fileprivate func configureConstraints() {
        [churchImage, nameChurchLabel, distanceChurchLabel, priestCollectionView].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0!)
        }

        churchImage.leadingAnchor(equalTo: contentView.leadingAnchor, constant: 10.0)
        churchImage.topAnchor(equalTo: contentView.topAnchor, constant: 10.0)
        churchImage.widthAnchor(equalTo: 105)
        churchImage.heightAnchor(equalTo: 80)

        nameChurchLabel.topAnchor(equalTo: contentView.topAnchor, constant: 6.0)
        nameChurchLabel.leadingAnchor(equalTo: churchImage.trailingAnchor, constant: 10)
        nameChurchLabel.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -15)
        nameChurchLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
//        timeChurchLabel.topAnchor(equalTo: nameChurchLabel.bottomAnchor, constant: 5)
//        timeChurchLabel.leadingAnchor(equalTo: churchImage.trailingAnchor, constant: 10)
//        timeChurchLabel.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -15)
        
        distanceChurchLabel.topAnchor(equalTo: nameChurchLabel.bottomAnchor, constant: 5)
        distanceChurchLabel.leadingAnchor(equalTo: churchImage.trailingAnchor, constant: 10)
        distanceChurchLabel.trailingAnchor(equalTo: contentView.trailingAnchor, constant: -25)
        distanceChurchLabel.bottomAnchor(equalTo: churchImage.bottomAnchor)
        distanceChurchLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        priestCollectionView.topAnchor(equalTo: churchImage.bottomAnchor)
        priestCollectionView.leadingAnchor(equalTo: contentView.leadingAnchor)
        priestCollectionView.trailingAnchor(equalTo: contentView.trailingAnchor)
        priestCollectionView.bottomAnchor(equalTo: contentView.bottomAnchor)
    }
}

// MARK: - FaithfulCollectionView

extension FaithfulCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priests.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriestsCollectionViewCell.id, for: indexPath) as? PriestsCollectionViewCell else {
            fatalError("Could not cast PriestsCollectionViewCell")
        }
        cell.setup(with: priests[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let priest = priests[indexPath.row]
//        priest.locationId = self.locationId
        guard let name = location?.name else { return}
        selectionDelegate?.didSelect(id: locationId, priest: priest, nameIgl: name)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 60)
    }
}
