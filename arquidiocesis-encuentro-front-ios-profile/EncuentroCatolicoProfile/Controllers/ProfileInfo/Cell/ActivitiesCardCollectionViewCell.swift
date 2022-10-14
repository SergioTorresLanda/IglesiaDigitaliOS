//
//  ActivitiesCardCollectionViewCell.swift
//  register_Framework
//
//  Created by Miguel Eduardo  Valdez Tellez  on 10/02/21.
//

import UIKit

class ActivitiesCardCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var activitiesNameLabel: UILabel!
    
    //MARK: - IBAction
    @IBAction func closeButton(_ sender: Any) {
        print("CLOSEEEE")
        if let indexPath = self.indexPath{
            delegate?.deleteActivity(index: indexPath)
        }
    }
    //MARK: - Local variables
    weak var delegate: ActivitiesCardDelegate?
    static var reuseIdentifier = "ActivitiesCardCollectionViewCell"
    static let nib = UINib(nibName: ActivitiesCardCollectionViewCell.reuseIdentifier, bundle: Bundle(for: ActivitiesCardCollectionViewCell.self))
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // Initialization code
    }
}


protocol ActivitiesCardDelegate: AnyObject {
    func deleteActivity(index: IndexPath)
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next as? UITableView
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
