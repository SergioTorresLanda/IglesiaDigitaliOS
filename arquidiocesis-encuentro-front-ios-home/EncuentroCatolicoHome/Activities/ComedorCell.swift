//
//  ComedorCell.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 14/03/23.
//

import UIKit

class ComedorCell: UITableViewCell {

    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblDirec: UILabel!
    @IBOutlet weak var lblResponsable: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblRequisitos: UILabel!

    @IBOutlet weak var subContentCard: UIView!
    @IBOutlet weak var lblDias: UILabel!
    @IBOutlet weak var lblHorario: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setComedor(data:Comedor){
        
        lblInfo.text=data.nombre
        lblDirec.text=data.direccion
        lblResponsable.text=data.responsable
        lblCorreo.text=data.correo
        lblTelefono.text=data.telefono
        lblPrecio.text=String(data.cobro)
        lblRequisitos.text=data.requisitos
        lblDias.text=""
        lblHorario.text="\(data.horarios[0].hour_start) - \(data.horarios[0].hour_end)"
        let c=data.horarios[0].days.count
        var i=0
        for dia in data.horarios[0].days{
            i+=1
            if c==1 {
                lblDias.text = lblDias.text! + dia.name
            }else{
                if i == c {
                    lblDias.text = lblDias.text! + " y " + dia.name
                }else if i == c-1 {
                    lblDias.text = lblDias.text! + dia.name
                }else{
                    lblDias.text = lblDias.text! + dia.name + ", "
                }
            }
          
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
