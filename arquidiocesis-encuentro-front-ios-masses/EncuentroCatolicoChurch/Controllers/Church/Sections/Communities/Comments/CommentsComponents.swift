//
//  CommentsComponents.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import Foundation
import UIKit

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "COMMENTCELL") as! CommentsCell
        cell.selectionStyle = .none
        cell.cardCommentView.layer.cornerRadius = 10
        cell.cardCommentView.ShadowCard()
        cell.userImg.layer.cornerRadius = cell.userImg.bounds.width / 2
        
        cell.lblComment.text = commentsList[indexPath.row].review
        cell.lblUserName.text = "\(commentsList[indexPath.row].devotee?.name ?? "Unspecified") \(commentsList[indexPath.row].devotee?.first_surname ?? "") \(commentsList[indexPath.row].devotee?.second_surname ?? "")"
        cell.userImg.DownloadStaticImage(commentsList[indexPath.row].devotee?.image_url ?? "")
        cell.lblDate.text = timeInterval(timeAgo: commentsList[indexPath.row].creation_date ?? "")
        let imgFill = UIImage(named: "Trazado 6941", in: Bundle.local, compatibleWith: nil)
        let rating = commentsList[indexPath.row].rating ?? 0.0
        if #available(iOS 13.0, *) {
           // let imgFill = UIImage(named: "Trazado 6941")
            
            if rating == 0.0 {
                print("Is zero")
            }else if rating <= 1.0 {
                cell.star1.image = imgFill
            }else if rating  <= 2.0 {
                cell.star1.image = imgFill
                cell.star2.image = imgFill
            }else if rating <= 3.0 {
                cell.star1.image = imgFill
                cell.star2.image = imgFill
                cell.star3.image = imgFill
            }else if rating <= 4.0 {
                cell.star1.image = imgFill
                cell.star2.image = imgFill
                cell.star3.image = imgFill
                cell.star4.image = imgFill
            }else if rating <= 5.0 {
                cell.star1.image = imgFill
                cell.star2.image = imgFill
                cell.star3.image = imgFill
                cell.star4.image = imgFill
                cell.star5.image = imgFill
            }

        }
        //heightComments.constant = commentsTable.contentSize.height
        
        return cell
    }
    
}
