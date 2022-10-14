//
//  YoungView_ControllerCV.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Gibran Galicia on 30/11/21.
//

import Foundation
import UIKit

extension YoungView_Controller: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63.0, height: 63.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCatalogo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.arrCatalogo[indexPath.row]
        guard let cell = collectionViewCatalg.dequeueReusableCell(withReuseIdentifier: "CatalogCell", for: indexPath) as? CatalogCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.white
        cell.setData(data: item, strCode: strCodeCatalog)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        strCodeCatalog = arrCatalogo[indexPath.row].code
        arGeneralSection.removeAll()
        arTitles?.removeAll()
        self.setUpView(reload: true)
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.reloadSections(IndexSet(integer: 0))
        
    }
}


