//
//  ReactionsModalCVModal.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 18/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: - UICollectionViewDataSource
extension ReactionsModalViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfReactions = postReactionsHeaders?.count else { return 0 }
        return numberOfReactions + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReactionsInfoCVC", for: indexPath) as! ReactionsInfoCVC
            
            //Reactions Count
            cell.reactionCountLabel.text = nil
            if let reactionCount = postsReactions?.data.total {
                cell.reactionCountLabel.text = "\(reactionCount) en total"
            }
            
            //Reaction Image
//            cell.reactionImage.image = nil
            
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            cell.isSelected = true
            
            cell.labelCenter.constant = 0
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReactionsInfoCVC", for: indexPath) as! ReactionsInfoCVC
            
            if let header = postReactionsHeaders?[indexPath.row - 1] {
                
                //Reactions Count
                cell.reactionCountLabel.text = nil
                cell.reactionCountLabel.text = String(header.total)
                
                
                //Reaction Image
//                cell.reactionImage.image = nil
                if let url = URL(string: header.img) {
                    cell.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                }
                
                cell.reactionImage.image  = UIImage(named: "reactionG")
                
                cell.labelCenter.constant = 10
            }
            
            return cell
        }
    }
}

//MARK: - UICollectionViewDelegate
extension ReactionsModalViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row > 0 {
            guard let reactions = postsReactionsCopy?.data.resp else { return }
            let reactionsImage = postsReactionsCopy?.data.header[indexPath.row - 1].img
            postsReactions?.data.resp = reactions.filter{ $0.reaction.img == reactionsImage }
        } else {
            postsReactions = postsReactionsCopy
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ReactionsModalViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.row {
        case 0:
            return CGSize(width: 100, height: collectionView.frame.height)
        default:
            return CGSize(width: 55, height: collectionView.frame.height)
        }
    }
}
