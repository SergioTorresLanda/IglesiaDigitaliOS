//
//  AlertTableCell.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 03/09/21.
//

import UIKit

protocol YourCellDelegate : AnyObject {
    func didPressButton(_ tag: Int, type: String, library: String, url: String, id: Int)
    func didPressButtonPost(url: String)

}

class AlertTableCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnIr: UIButton!
    var cellDelegate: YourCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func goAction(_ sender: Any) {
        cellDelegate?.didPressButton(500, type: "", library: "", url: "", id: 0)
    }
    
    
}
