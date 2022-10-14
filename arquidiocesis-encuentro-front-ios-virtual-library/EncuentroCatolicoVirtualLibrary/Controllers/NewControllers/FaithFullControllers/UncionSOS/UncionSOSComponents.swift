//
//  UncionSOSComponents.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

extension UncionSOSView: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return churchListed.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLSOSMAIN", for: indexPath) as! MainTableCell
        cell.cardView.layer.cornerRadius = 8
        cell.cardView.ShadowCard()
        cell.updateCell(listC: churchListed[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate2 = self
       
        print(churchListed[indexPath.row], "****")
    
        
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "UC", for: indexPath) as! UncionTableCell
//
//        church = churchListed[indexPath.row]
//        print("Este es el index: \(indexPath.row)")
//        print(churchListed[indexPath.row])
//        cell.cardView.layer.cornerRadius = 8
//        cell.delegate = self
//        cell.cardView.ShadowCard()
//
//        return cell
//
//
//    }
//
//     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        guard let tableCell = cell as? UncionTableCell else { return }
//        tableCell.setCollectionViewDataSourceDelegate(forRow: indexPath.row, dataModel: churchListed, isFirstLoad: isFisrtLoad)
//      //  tableCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//
//    }
//
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableCell = cell as? UncionTableCell else { return }
//        tableCell.reloadHeight()
//    }

}
