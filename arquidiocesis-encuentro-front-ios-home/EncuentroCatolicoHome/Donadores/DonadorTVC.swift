//
//  DonadorTVC.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 28/03/23.
//

import UIKit

class DonadorTVC: UITableViewCell {

    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var correoLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var telLbl: UILabel!
    @IBOutlet weak var switchActive: UISwitch!
    
    @IBAction func switchClick(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDonador(data: Donador){
        nombreLbl.text=data.nombre
        correoLbl.text=data.correo
        commentsLbl.text=data.comentarios
        telLbl.text=data.telefono
    }

}
