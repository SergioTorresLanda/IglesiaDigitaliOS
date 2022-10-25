//
//  InfoView_Cell.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 02/05/21.
//

import UIKit

struct FormationCell {
    var title: String
    var subtitle : String
    var whereIs : String
    var zone : String
    var views : String
    var image : String
    var tags: String
}

class InfoView_Cell: UITableViewCell {
    //MARK: - Properties
    var details : FormationCell? {
        didSet {
            title.text = details?.title
            subtitle.text = details?.subtitle
            whereIs.text = details?.whereIs
            zone.text = details?.zone
            views.text = details?.views
            tags.text = details?.tags
        }
    }
    
    lazy var imageViewTitle : UIImageView = {
        let imv = UIImageView()

        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.backgroundColor = UIColor(white: 230.0 / 255.0, alpha: 1.0)
        
        return imv
    }()
    
    private lazy var title : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 57.0 / 255.0, alpha: 1.0)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var subtitle : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 0.0, alpha: 0.6)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var tags : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 0.0, alpha: 0.6)
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.systemFont(ofSize: 8)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var whereIs : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.systemFont(ofSize: 7)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var zone : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.systemFont(ofSize: 7)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var views : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.systemFont(ofSize: 7)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: NSLayoutConstraint.Axis.horizontal)
        return lbl
    }()
    
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private functions
extension InfoView_Cell {
    private func setupConstraints() {
        let stackHorizontalDetails = UIStackView(arrangedSubviews: [whereIs,zone,views])
        let stackVertical = UIStackView(arrangedSubviews: [title,subtitle, tags,stackHorizontalDetails])
        let stackHorizontal = UIStackView(arrangedSubviews: [imageViewTitle,stackVertical])
        stackHorizontal.layer.borderColor = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0).cgColor
        stackHorizontal.layer.borderWidth = 1
        stackHorizontal.layer.masksToBounds = true
        stackHorizontal.layer.cornerRadius = 10
        stackHorizontal.layer.shadowColor = UIColor.black.cgColor
        stackHorizontal.layer.shadowRadius = 10
        stackHorizontal.layer.shadowOpacity = 0.5
        stackHorizontal.layer.shadowOffset = .zero
        stackHorizontal.layer.shadowPath = UIBezierPath(rect: stackHorizontal.bounds).cgPath
        
        
        stackHorizontalDetails.axis = .horizontal
        stackHorizontalDetails.distribution = .fill
        stackHorizontalDetails.spacing = 10
        
        stackHorizontal.axis = .horizontal
        stackHorizontal.distribution = .fill
        stackHorizontal.spacing = 7
        
        stackVertical.axis = .vertical
        stackVertical.distribution = .fill
        
        imageViewTitle.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal.translatesAutoresizingMaskIntoConstraints = false
        zone.translatesAutoresizingMaskIntoConstraints = false
        stackHorizontal.backgroundColor = UIColor.white
        contentView.addSubview(stackHorizontal)
        
        NSLayoutConstraint.activate([
            zone.widthAnchor.constraint(equalToConstant: 30),
            imageViewTitle.widthAnchor.constraint(equalToConstant: 106),
            views.widthAnchor.constraint(equalToConstant: 70),
            title.heightAnchor.constraint(equalToConstant: 30),
            
            stackHorizontal.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            stackHorizontal.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            stackHorizontal.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            stackHorizontal.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
    }
}
