//
//  NoResults_View.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 02/05/21.
//

import UIKit

struct NoResults {
    var imageDefault: UIImage?
}

class NoResults_View: UIView {
    //MARK: - Properties
    var details : NoResults? {
        didSet {
            imageViewTitle.image = details?.imageDefault ?? UIImage(named: "sinresultadosV2", in: Bundle(for: YoungView_Route.self), compatibleWith: nil)
        }
    }
    
    private lazy var searchTextPrincipal : UILabel = {
        let lbl = UILabel()
        
        lbl.textColor = UIColor(red: 113.0/255.0, green: 113.0/255.0, blue: 113.0/255.0, alpha: 1)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "formation_empty_view".localized
        
        return lbl
    }()
    
    private lazy var imageViewTitle : UIImageView = {
        let imv = UIImageView()
        
        imv.contentMode = .scaleAspectFit
        imv.image = UIImage(named: "sinresultadosV2", in: Bundle(for: YoungView_Route.self), compatibleWith: nil)
        
        return imv
    }()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private functions
extension NoResults_View {
    private func commonInit() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        let stackVertical = UIStackView(arrangedSubviews: [ imageViewTitle,searchTextPrincipal])
        
        stackVertical.axis = .vertical
        stackVertical.distribution = .fill
        stackVertical.alignment = .center
        stackVertical.spacing = 20
        
        self.addSubview(stackVertical)
        
        imageViewTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewTitle.widthAnchor.constraint(equalToConstant: 60),
            imageViewTitle.heightAnchor.constraint(equalTo: imageViewTitle.widthAnchor),
        ])
        
        stackVertical.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 0),
            stackVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackVertical.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stackVertical.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 0),
            stackVertical.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
