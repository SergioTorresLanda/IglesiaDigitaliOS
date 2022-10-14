//
//  NewOnboardingComponents.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 13/09/21.
//

import Foundation
import UIKit

extension NewOnboardingsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return normalText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLON", for: indexPath) as! OnboardingCollectionCell
        cell.halfContentView.layer.cornerRadius = 45
        cell.lblTitle.text = titulosText[indexPath.item]
        cell.lblText.text = normalText[indexPath.item]
        cell.backgroundImg.image = UIImage(named:  imgNames[indexPath.row], in: Bundle.local, compatibleWith: nil)
        
        if showViñetas[indexPath.item] == true {
            cell.stackViñetas.isHidden = false
            cell.lblViñeta1.text = viñetasText[0]
            cell.lblViñeta2.text = viñetasText[1]
            cell.lblViñeta3.text = viñetasText[2]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.mainCollectionVewi.bounds.width, height: self.mainCollectionVewi.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
