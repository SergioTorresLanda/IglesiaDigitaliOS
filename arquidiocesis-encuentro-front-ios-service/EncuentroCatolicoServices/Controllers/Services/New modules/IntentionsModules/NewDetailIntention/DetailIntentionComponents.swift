//
//  DetailIntentionComponents.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

extension DetailIntentionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayIntentions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLINTENTION", for: indexPath) as! IntentionCellDetail
        
        cell.lblTypeIntention.text = arrayIntentions[indexPath.row].intention
        cell.lblName.text = arrayIntentions[indexPath.row].dedicated_to?.joined(separator: "\n")
        cell.selectionStyle = .none
        
        return cell
        
    }

}
