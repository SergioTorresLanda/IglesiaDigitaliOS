//
//  GenericCell.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 05/06/23.
//

import UIKit

protocol ActividadCellDelegate: AnyObject{
    func cellAction(sender:ActividadGenerica)
}

class GenericCell: UITableViewCell {

    @IBOutlet weak var tipoLbl: UILabel!
    
    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var direcLbl: UILabel!
    @IBOutlet weak var lblPrecio: UILabel!
    @IBOutlet weak var lblHorario: UILabel!
    
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var lblRequisitos: UILabel!
    @IBOutlet weak var lblResponsable: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblDias: UILabel!
    @IBOutlet weak var infoDonsLbl: UILabel!
    @IBOutlet weak var infoVolsLbl: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    let arrType=[
        1:"Educación",
        2:"Misiones",
        3:"Retiros",
        4:"Cursos",
        5:"Encuentros",
        6:"Pláticas",
        7:"Adoración Nocturna"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    let SNId = UserDefaults.standard.integer(forKey: "SNId")
    weak var delegate:ActividadCellDelegate?
    var actividad:ActividadGenerica?
    
    @IBAction func actionClick(_ sender: Any) {
        print("clickAction")
        delegate?.cellAction(sender: actividad!)
    }
    
    func setData(data:ActividadGenerica, tipoSelect:String){
        actividad=data
        print("SET DATA:::")
        tipoLbl.text=arrType[data.tipoEvento]
        nombreLbl.text=data.nombre
        direcLbl.text=data.direccion
        lblPrecio.text=String(data.cobro)
        lblHorario.text="De "+data.horarios[0].hour_start+" a "+data.horarios[0].hour_end+" hrs."
        lblCorreo.text=data.correo
        lblRequisitos.text=data.descripcion+" - "+data.publico
        lblResponsable.text=data.responsable
        lblTelefono.text=data.telefono
        infoDonsLbl.text=data.donantesTxt
        infoVolsLbl.text=data.voluntariosTxt
        
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
        if SNId==data.userId{
            btnAction.isHidden=true
        }else{
            switch tipoSelect {
                
            case "Donador":
                btnAction.isHidden=false
                btnAction.setTitle("   Donar   ", for: .normal)
            case "Voluntario":
                btnAction.isHidden=false
                btnAction.setTitle("   Ayudar   ", for: .normal)
            case "Participante":
                btnAction.isHidden=false
                btnAction.setTitle("   Participar   ", for: .normal)
            default://solicitante o select
                btnAction.isHidden=true
            }
            
        }
        infoDonsLbl.sizeToFit()
        infoDonsLbl.layoutIfNeeded()
        infoVolsLbl.sizeToFit()
        infoVolsLbl.layoutIfNeeded()
        lblRequisitos.sizeToFit()
        lblRequisitos.layoutIfNeeded()
        lblDias.sizeToFit()
        lblDias.layoutIfNeeded()
        direcLbl.sizeToFit()
        direcLbl.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
