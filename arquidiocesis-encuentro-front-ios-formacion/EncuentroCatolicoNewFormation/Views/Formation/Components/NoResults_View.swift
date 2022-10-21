//
//  NoResults_View.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 02/05/21.
//

import UIKit

struct NoResults {
    var searchText: String
    var imageDefault: UIImage?
}

class NoResults_View: UIView {
    
    var details : NoResults? {
        didSet {
            searchText.text = "\"\(details?.searchText ?? "")\""
            imageViewTitle.image = details?.imageDefault ?? UIImage(named: "sinresultadosV2", in: Bundle(for: YoungView_Route.self), compatibleWith: nil)
        }
    }
    
    private lazy var searchTextPrincipal : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "No encontramos resultados para"
        return lbl
    }()
    
    private lazy var searchText : UILabel = {
        let lbl = UILabel()
        lbl.tintColor = UIColor(white: 175.0 / 255.0, alpha: 1.0)
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var imageViewTitle : UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleToFill
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "sinresultadosV2", in: Bundle(for: YoungView_Route.self), compatibleWith: nil)
        return imv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackVertical = UIStackView(arrangedSubviews: [ imageViewTitle,searchTextPrincipal,searchText])
        stackVertical.translatesAutoresizingMaskIntoConstraints = false
        stackVertical.axis = .vertical
        stackVertical.distribution = .fillProportionally
        stackVertical.spacing = 7
        stackVertical.setCustomSpacing(30, after: imageViewTitle)
        self.addSubview(stackVertical)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            stackVertical.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 80),
            stackVertical.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
