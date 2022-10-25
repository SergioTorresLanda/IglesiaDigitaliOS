//
//  CatalogCell.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Alejandro on 21/10/22.
//

import UIKit
import EncuentroCatolicoUtils

class CatalogCell: UICollectionViewCell{
    //MARK: - Propeties
    var showCaseImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let underLineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .secondary
        view.isHidden = true
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setData(data: FF_Catalog_Entity, strCode: String){
        let isPressed = strCode == data.code
        
        guard let imageURL = URL(string: isPressed ? data.iconPressedUrl : data.iconUrl) else {
            return
        }
        
        showCaseImageView.setCacheImage(with: imageURL)
        underLineView.isHidden = !isPressed
    }
}

//MARK: - Private functions
extension CatalogCell {
    private func addViews(){
        self.contentView.addSubview(showCaseImageView)
        self.contentView.addSubview(underLineView)
        
        showCaseImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showCaseImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            showCaseImageView.topAnchor.constraint(equalTo:  self.contentView.topAnchor),
            showCaseImageView.heightAnchor.constraint(equalToConstant: 57),
            showCaseImageView.widthAnchor.constraint(equalTo: showCaseImageView.heightAnchor)
        ])
        
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(greaterThanOrEqualTo: showCaseImageView.bottomAnchor, constant: 4),
            underLineView.heightAnchor.constraint(equalToConstant: 4),
            underLineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            underLineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0),
            underLineView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0)
        ])
    }
}
