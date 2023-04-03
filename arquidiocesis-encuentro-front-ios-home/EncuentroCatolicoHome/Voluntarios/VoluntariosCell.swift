//
//  VoluntariosCell.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 29/03/23.
//

import UIKit

class VoluntariosCell: UITableViewCell {

    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var correoLbl: UILabel!
    @IBOutlet weak var invsLbl: UILabel!
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
    
    func setVoluntario(data: Voluntario){
        nombreLbl.text=data.voluntario
        correoLbl.text=data.correo
        telLbl.text=data.telefono
        var invsTxt=""
        var j=0
        for i in data.multiuser!{
            j+=1
            print("UN invitado :: ")
            print(i)
            if j == data.multiuser?.count{
                invsTxt += i.nombre! + " " + i.telefono!
            }else{
                invsTxt += i.nombre! + " " + i.telefono! + "\n"
            }
            //invsTxt += "Nombre invitado x" + "+525588776699"
        }
        invsLbl.text=invsTxt
    }
}
