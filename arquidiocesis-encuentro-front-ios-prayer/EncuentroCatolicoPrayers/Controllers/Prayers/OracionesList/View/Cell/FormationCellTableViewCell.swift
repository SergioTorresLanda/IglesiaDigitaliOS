//
//  FormationCellTableViewCell.swift
//  tableViewExample
//
//  Created by Miguel Eduardo  Valdez Tellez  on 05/03/21.
//

import UIKit

class FormationCellTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableSubFormation: UITableView!
    @IBOutlet weak var despegableButton: UIButton!
    @IBOutlet weak var IconoImage: UIImageView!
    @IBOutlet weak var namaFormationLabel: UILabel!
    
    @IBOutlet weak var altoTablaDetalle: NSLayoutConstraint!
    static let reuseIdentifier = "FormationCellTableViewCell"
    @available(iOS 13.0, *)
    static let nib = UINib(nibName: FormationCellTableViewCell.reuseIdentifier, bundle: Bundle.local)
    var tableParent: UIViewController?
    @IBAction func despegableButtonAction(_ sender: Any) {
        
    }
    

    var urlDetail: String?
    var topicsString: [String] = []
    var ids : [Int] = []
    var dataSource: DataResponse?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if #available(iOS 13.0, *) {
            tableSubFormation.register(SubFormationTableViewCell.nib, forCellReuseIdentifier: SubFormationTableViewCell.reuseIdentifier)
        } else {
            // Fallback on earlier versions
        }
        tableSubFormation.delegate = self
        tableSubFormation.dataSource = self
        tableSubFormation.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setDataCell(data: [String], tableview: UIViewController, ids: [Int]) {
        
        self.tableParent = tableview
        
        self.topicsString = data
        self.ids = ids
    }
    
    
    func expand(_ expand: Bool) {
        if expand {
            let estimatedHeight = tableSubFormation.contentSize.height
            if estimatedHeight == 0 {
                altoTablaDetalle.constant =  130
            }else {
                altoTablaDetalle.constant = tableSubFormation.contentSize.height
            }
        }
        else {
            altoTablaDetalle.constant = 0
        }
        
    }

    
}

extension FormationCellTableViewCell {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsString.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        OracionesDetailRouter.getDetailView(id: self.ids[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSubFormation.dequeueReusableCell(withIdentifier: "SubFormationTableViewCell", for: indexPath) as! SubFormationTableViewCell
        cell.subFormationLabel.text = self.topicsString[indexPath.row]
        cell.subFormationLabel.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}




