//
//  PriestsCollectionViewCell.swift
//  FielSOS
//
//  Created by René Sandoval on 21/03/21.
//

import UIKit

class PriestsCollectionViewCell: UICollectionViewCell {
    static let id = "PriestsTableViewCell"

    var buttonPriestImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "button_priest", in: Bundle.local, compatibleWith: nil)
        image.contentMode = .scaleAspectFill
        return image
    }()

    var namePriestLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = Colors.titles
        return label
    }()

    var arrowPriestImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow_right", in: Bundle.local, compatibleWith: nil)
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        [buttonPriestImage, namePriestLabel, arrowPriestImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }

        buttonPriestImage.topAnchor(equalTo: contentView.topAnchor)
        buttonPriestImage.centerXAnchor(equalTo: contentView.centerXAnchor)

        namePriestLabel.leadingAnchor(equalTo: buttonPriestImage.leadingAnchor, constant: 30)
        namePriestLabel.centerYAnchor(equalTo: buttonPriestImage.centerYAnchor)
        namePriestLabel.heightAnchor(equalTo: 18)

        arrowPriestImage.centerYAnchor(equalTo: buttonPriestImage.centerYAnchor)
        arrowPriestImage.leadingAnchor(equalTo: buttonPriestImage.trailingAnchor, constant: -50)
        arrowPriestImage.widthAnchor(equalTo: 15)
        arrowPriestImage.heightAnchor(equalTo: 20)
    }

    func setup(with priest: Priest) {
        namePriestLabel.text = priest.name
    }
}
