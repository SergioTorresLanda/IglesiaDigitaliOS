//
//  ServiceTableViewCell.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 16/08/21.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    
    static let reuseIdentifier = "ServiceTableViewCell"
    static let nib = UINib(nibName: ServiceTableViewCell.reuseIdentifier,
                           bundle: Bundle(for: ServiceTableViewCell.self))
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var audienceLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
// MARK: NEW UI -
    @IBOutlet weak var backCard: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.adjustsFontSizeToFitWidth = true
        dayLabel.adjustsFontSizeToFitWidth = true
        timeLabel.adjustsFontSizeToFitWidth = true
        audienceLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.sizeToFit()
    }
}
