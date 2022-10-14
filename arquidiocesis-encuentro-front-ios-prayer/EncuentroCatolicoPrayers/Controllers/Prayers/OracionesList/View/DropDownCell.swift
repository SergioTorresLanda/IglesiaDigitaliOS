////
////  TableViewCell.swift
////  FormacionModulo
////
////  Created by Ulises Atonatiuh González Hernández on 28/02/21.
////
//
//import UIKit
//import DropDown
//class TableViewCell: DropDownCell {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .clear // very important
//        layer.masksToBounds = false
//        layer.shadowOpacity = 0.23
//        layer.shadowRadius = 1
//

//layer.shadowOffset = CGSize(width: 2, height: 2)
//        layer.shadowColor = UIColor.black.cgColor
//        layer.cornerRadius = 10
//
//        // add corner radius on `contentView`
//        contentView.backgroundColor = .white
//        contentView.layer.cornerRadius = 0
//        super.awakeFromNib()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//}
