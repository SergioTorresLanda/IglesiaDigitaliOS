//
//  NoResults_ViewV2.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Billy on 20/10/21.
//

import UIKit

class NoResults_ViewV2: UIView{
    
    @IBOutlet weak var lblDetail: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func commonInit(){
        if let nib = Bundle(for: NoResults_ViewV2.self).loadNibNamed("NoResults_ViewV2", owner: self, options: nil)?.first as? NoResults_ViewV2{
            
            addSubview(nib)
        }
    }
    
    public func NoResultsV2(searchText: String, bSearch: Bool){
        let searchTextPrincipal = UILabel()
        searchTextPrincipal.textColor =  UIColor(red: 117.0/255, green: 120.0/255, blue: 123.0/255, alpha: 1)
        searchTextPrincipal.numberOfLines = 2
        searchTextPrincipal.lineBreakMode = .byTruncatingTail
        searchTextPrincipal.font = UIFont.boldSystemFont(ofSize: 20)
        searchTextPrincipal.textAlignment = .center
        searchTextPrincipal.translatesAutoresizingMaskIntoConstraints = false
        searchTextPrincipal.text = bSearch ? "No encontramos resultados \n para \"\(searchText)\"" : ""
        
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.image = UIImage(named: "sinresultadosV2", in: Bundle(for: FirstMan_Route.self), compatibleWith: nil)
            
        addSubview(searchTextPrincipal)
        addSubview(imv)
        
        NSLayoutConstraint.activate([
            searchTextPrincipal.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            searchTextPrincipal.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchTextPrincipal.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 43),
            
            imv.widthAnchor.constraint(equalToConstant: 76),
            imv.heightAnchor.constraint(equalToConstant: 76),
            imv.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            imv.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imv.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40)
        ])
    }
    
}
