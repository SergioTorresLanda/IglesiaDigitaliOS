//
//  LiveComponents.swift
//  EncuentroCatolicoLive
//
//  Created by Diego Martinez on 26/02/21.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource
extension LiveViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "STREAMINGCELL", for: indexPath) as! streamingCollectionCell
        cell.backgorundCard.layer.cornerRadius = 10
        cell.backgorundCard.ShadowCard()
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.clipsToBounds = true
        
        cell.lblTitle.text = allData[indexPath.item].author
        cell.lblText.text = allData[indexPath.item].name
        
        if tempImages[indexPath.row].isNull{
            let youtubeURL = tblLinks[indexPath.row].getYouTubeThubnailFromURL()
            DispatchQueue.global(qos: .background).async {
                let url = URL(string: youtubeURL)
                let data = try? Data(contentsOf: (url ?? URL(string: "www.com"))!)

                let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                DispatchQueue.main.async {
                    self.tempImages.updateValue(image, forKey: indexPath.row)
                    cell.streamImg.image = image
                    cell.streamImg.contentMode = .scaleAspectFill
                }
            }
            
        }else{
            cell.streamImg.image = tempImages[indexPath.row]
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LiveViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let url = URL(string: allData[indexPath.row].streaming_url ?? "") else { return }
        let view = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle.local)
        view.screenURL = url.absoluteString.embedAndPlayYoutubeURL()
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension LiveViewController: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 218.0)
    }
}
