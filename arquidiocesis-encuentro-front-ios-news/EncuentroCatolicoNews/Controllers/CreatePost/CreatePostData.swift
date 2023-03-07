//
//  CreatePostData.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

//MARK: - UITableViewDataSource
extension RedSocial_CrearPost: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return location != nil && media.isEmpty == true ? 1 : 0
        default:

            return media.isEmpty != true ? 1 : 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsSelectionTVC", for: indexPath) as? LocationsSelectionTVC else { return UITableViewCell() }
            //Image
            cell.locationImage.image = location?.image
            //Name
            cell.locationName.text = location?.name
            //DeleteButton
            cell.deleteButton.addTarget(self, action: #selector(deleteLocation), for: .touchUpInside)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTVC", for: indexPath) as? ImagesTVC else { return UITableViewCell() }
            //Images
            cell.media = media
            //DeleteButton
            cell.selectButton.addTarget(self, action: #selector(editImages), for: .touchUpInside)
            
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension RedSocial_CrearPost: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return tableView.frame.width
        }
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 255
        default:
            return tableView.frame.width
        }
    }
    
}
