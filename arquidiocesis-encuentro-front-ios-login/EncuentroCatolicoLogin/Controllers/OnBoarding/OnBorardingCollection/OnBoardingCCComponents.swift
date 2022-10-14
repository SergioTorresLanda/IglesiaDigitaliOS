//
//  OnBoardingCCComponents.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 03/06/21.
//

import Foundation
import UIKit

//MARK: - UICollectionViewDataSource

extension OnBoardingCC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = onBoardingCV.dequeueReusableCell(withReuseIdentifier: "OBCELL", for: indexPath) as! Cell1OnBoarding
            cell.backgroundColor = .white
            return cell
            
        default:
            let cell = onBoardingCV.dequeueReusableCell(withReuseIdentifier: "OBCELL2", for: indexPath) as! Cell2OnBoarding
            cell.backgroundColor = .white
//            cell.blueTitle.text = "La iglesia en tus manos"
//            cell.obText.text = "Descubre en este punto de Encuentro digital la riqueza que la Iglesia tiene para tí."
            return cell
            
        }
        
    }
    
}

//MARK: - UICollectionViewDelegate
extension OnBoardingCC: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnBoardingCC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.onBoardingCV.frame.width, height: self.onBoardingCV.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
