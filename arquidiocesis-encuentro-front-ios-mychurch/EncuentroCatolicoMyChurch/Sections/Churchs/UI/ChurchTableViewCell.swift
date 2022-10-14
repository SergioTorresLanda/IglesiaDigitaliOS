//
//  ChurchTableViewCell.swift
//  EncuentroCatolicoMyChurch
//
//  Created by René Sandoval on 18/03/21.
//

import Foundation
import UIKit

class ChurchTableViewCell: UITableViewCell {
    static let id = "ChurchTableViewCell"

    var churchImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "church_icon", in: Bundle.local, compatibleWith: nil)
        image.contentMode = .scaleAspectFit
        return image
    }()

    var nameChurchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = PrimaryColor().blue
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        [churchImage, nameChurchLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        churchImage.leadingAnchor(equalTo: contentView.leadingAnchor, constant: 7.5)
        churchImage.centerYAnchor(equalTo: contentView.centerYAnchor)
        churchImage.widthAnchor(equalTo: 50)
        churchImage.heightAnchor(equalTo: 50)
        churchImage.layer.cornerRadius = 5

        nameChurchLabel.topAnchor(equalTo: contentView.topAnchor, constant: 10)
        nameChurchLabel.leadingAnchor(equalTo: churchImage.trailingAnchor, constant: 10)
        nameChurchLabel.trailingAnchor(equalTo: contentView.trailingAnchor, constant: 10)
    }

    func setup(with church: RepoViewModel) {
        nameChurchLabel.text = church.name
        
    }
}
