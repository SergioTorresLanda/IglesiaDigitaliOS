//  ECNFFileTypeCell.swift
//  FormacionApp
//
//  Created by Alejandro Orihuela.
//  Github: https://github.com/AlejandroSeed
//  
//
import UIKit

class ECNFFileTypeCell: UICollectionViewCell {
    //MARK: - Static Properties
    static var identifier: String {
        String(describing: self)
    }
    
    //MARK: - Properties
    override var isSelected: Bool {
        didSet {
            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: isSelected ? .bold : .regular)
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(red: 113.0/255.0, green: 113.0/255.0, blue: 113.0/255.0, alpha: 1)
        label.textAlignment = .center
        
        return label
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    //MARK: - Methods
    func setData(_ data: ECNFFormationType) {
        self.titleLabel.text = data.getLocatizedString()
    }
}

//MARK: - Private functions
extension ECNFFileTypeCell {
    private func commonInit() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4)
        ])
    }
}
