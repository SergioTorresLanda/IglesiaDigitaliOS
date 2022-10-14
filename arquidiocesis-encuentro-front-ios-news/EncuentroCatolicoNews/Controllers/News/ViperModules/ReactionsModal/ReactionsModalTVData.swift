//
//  ReactionsModalTVData.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 18/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: - UITableViewDataSource
extension ReactionsModalViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfReactions = postsReactions?.data.resp.count else { return 0 }
        return numberOfReactions
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReactionsMoreInfoTVC", for: indexPath) as! ReactionsMoreInfoTVC
        
        if let reaction = postsReactions?.data.resp[indexPath.row] {
            
            cell.nameLabel.text = reaction.autor.nombre
            
            cell.userImage.setImage(name: reaction.autor.nombre, image: reaction.autor.imagen)
            
            if let url = URL(string: reaction.reaction.img) {
                cell.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
            }
        }
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ReactionsModalViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

//MARK: - UITableViewDataSourcePrefetching
extension ReactionsModalViewController: UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let numberOfReactions = postsReactions?.data.resp.count, let pages = postsReactions?.data.pages else { return }
        if tableView.indexPathsForVisibleRows?.contains(IndexPath(row: numberOfReactions - 3, section: 1)) ?? false {
            let pagesDifference = pages - skip
            if pagesDifference > 1 {
                skip = skip + 1
                presenter?.getPostsReactions(postId: postId)
            }
        }
    }
}
