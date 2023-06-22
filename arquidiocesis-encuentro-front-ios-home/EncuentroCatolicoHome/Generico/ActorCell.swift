//
//  ActorCell.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 14/06/23.
//

import UIKit

class ActorCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var tipoLbl: UILabel!
    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var switchActive: UISwitch!
    @IBAction func switchClick(_ sender: Any) {
    }
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    //weak var delegate:ActividadCellDelegate?
    var actor:Actor?
    
    //@IBAction func actionClick(_ sender: Any) {
      //  print("clickAction")
        //delegate?.cellAction(sender: actividad!)
    //}
    
    func setData(data:Actor){
        //actor=data
        print("SET DATA:::")
        nombreLbl.text=data.nombre
        lblCorreo.text=data.correo
        lblComments.text=data.comentarios
        lblTelefono.text=data.telefono
        
        lblComments.sizeToFit()
        lblComments.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
