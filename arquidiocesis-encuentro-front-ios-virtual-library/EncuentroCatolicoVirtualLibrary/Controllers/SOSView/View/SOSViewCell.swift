//
//  SOSViewCell.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Jorge Cruz on 25/03/21.
//

import UIKit

class SOSViewCell: UITableViewCell {

    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = #colorLiteral(red: 0.05098039216, green: 0.2745098039, blue: 0.8392156863, alpha: 0.1483312075)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var checkImage: UIImageView = {
        let imgview = UIImageView(frame: .zero)
        imgview.translatesAutoresizingMaskIntoConstraints = false
        imgview.tintColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return imgview
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadCellStyle()
        self.setupComponentsLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupComponentsLayout(){
        let noneSpace = UIView(frame: .zero)
        noneSpace.translatesAutoresizingMaskIntoConstraints = false
        noneSpace.backgroundColor = .white
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(noneSpace)
        containerView.addSubview(checkImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            
            noneSpace.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            noneSpace.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            noneSpace.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            noneSpace.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            
            checkImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkImage.heightAnchor.constraint(equalToConstant: 35),
            checkImage.widthAnchor.constraint(equalToConstant: 35),
            checkImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: checkImage.leadingAnchor, constant: -10),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
        ])
    }
    
    private func loadCellStyle(){
        self.clipsToBounds      = true
        self.backgroundColor    = .clear
        self.selectionStyle = .none
    }
    

}
