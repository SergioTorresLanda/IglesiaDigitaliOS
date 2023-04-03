//
//  VoluntariosTVC.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 28/03/23.
//

import UIKit
protocol InvitadosCellDelegate: AnyObject{
    func delete(sender:Int)
}
class VoluntariosTVC: UITableViewCell {
    weak var delegate:InvitadosCellDelegate?
    
    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var eliminarBtn: UIButton!
    @IBOutlet weak var telefonobl: UILabel!
    
    var invitado:Invitado?
    var index:Int?
    
    @IBAction func eliminarClick(_ sender: Any) {
        delegate?.delete(sender: index!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInvitado(data:Invitado, i:Int){
        index=i
        let tel2 = data.telefono!.substring(from: 3)
        telefonobl.text=tel2
        nombreLbl.text=data.nombre
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
