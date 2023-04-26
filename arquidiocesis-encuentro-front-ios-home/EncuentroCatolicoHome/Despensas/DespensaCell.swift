//
//  DespensaCell.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 20/04/23.
//

import UIKit
/*
protocol ComedorCellDelegate: AnyObject{
    func cellAction(sender:Comedor)
}*/

class DespensaCell: UITableViewCell {

    weak var delegate:ComedorCellDelegate?
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblDirec: UILabel!
    @IBOutlet weak var lblResponsable: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    @IBOutlet weak var lblRequisitos: UILabel!
    //@IBOutlet weak var btnAction: UIButton!
    //@IBOutlet weak var subContentCard: UIView!
    @IBOutlet weak var diasRecLbl: UILabel!
    @IBOutlet weak var horarioRecLbl: UILabel!
    @IBOutlet weak var diasArmLbl: UILabel!
    @IBOutlet weak var horarioArmLbl: UILabel!
    @IBOutlet weak var diasEntLbl: UILabel!
    @IBOutlet weak var horarioEntLbl: UILabel!
    @IBOutlet weak var direcEntLbl: UILabel!
    
    @IBOutlet weak var infoReqSV: UIStackView!
    @IBOutlet weak var reqSV: UIStackView!
    @IBOutlet weak var lblDiasReqSV: UIStackView!
    @IBOutlet weak var diasReqSV: UIStackView!
    @IBOutlet weak var horarioReqSV: UIStackView!
    
    @IBOutlet weak var infoArmSV: UIStackView!
    @IBOutlet weak var diasArmSV: UIStackView!
    @IBOutlet weak var horarioArmSV: UIStackView!
    
    @IBOutlet weak var infoEntSV: UIStackView!
    @IBOutlet weak var diasEntSV: UIStackView!
    @IBOutlet weak var horarioEntSV: UIStackView!
    @IBOutlet weak var direcEntSV: UIStackView!
    
    @IBOutlet weak var donSV: UIStackView!
    @IBOutlet weak var donSVheight: NSLayoutConstraint!//195
    
    @IBOutlet weak var armSV: UIStackView!
    @IBOutlet weak var armSVHeight: NSLayoutConstraint!//155
    
    @IBOutlet weak var entSV: UIStackView!
    @IBOutlet weak var entSVHeight: NSLayoutConstraint!//220
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //var desp:Comedor?
    
    @IBAction func actionClick(_ sender: Any) {
        print("clickAction desp")
        //delegate?.cellAction(sender: comedor!)
    }
    
    func setDespensa(data:Despensa, type:String){
        
        lblResponsable.text="Responsable: "+data.responsable
        lblCorreo.text=data.correo
        lblTelefono.text=data.telefono
        lblDirec.text=data.direccion
        lblInfo.text=data.descripcion_despensa
        if data.req_donador==1{
            lblRequisitos.text=data.requisitos_donacion
            var sRec="Del "+data.fecha_recibido.fecha_inicio+" al "+data.fecha_recibido.fecha_final+". Los días: "
            if let c = data.horarios[0]?.days.count {
                var i=0
                for dia in data.horarios[0]!.days{
                    i+=1
                    if c==1 {
                        sRec = sRec + dia.name
                    }else{
                        if i == c {
                            sRec = sRec + " y " + dia.name
                        }else if i == c-1 {
                            sRec = sRec + dia.name
                        }else{
                            sRec = sRec + dia.name + ", "
                        }
                    }
                }
            }
            diasRecLbl.text=sRec
            horarioRecLbl.text = "En un horario de "+data.fecha_recibido.hora_inicio+" a "+data.fecha_recibido.hora_final
            donSVheight.constant=225//195
            donSV.isHidden=false
        }else{
            donSVheight.constant=0
            donSV.isHidden=true
        }
        
        if data.req_armado==1{
            var sArm="Del "+data.fecha_armado.fecha_inicio+" al "+data.fecha_armado.fecha_final+". Los días: "
            if let c = data.horarios[1]?.days.count {
                var i=0
                for dia in data.horarios[1]!.days{
                    i+=1
                    if c==1 {
                        sArm = sArm + dia.name
                    }else{
                        if i == c {
                            sArm = sArm + " y " + dia.name
                        }else if i == c-1 {
                            sArm = sArm + dia.name
                        }else{
                            sArm = sArm + dia.name + ", "
                        }
                    }
                }
            }
            diasArmLbl.text = sArm
            horarioArmLbl.text = "En un horario de "+data.fecha_armado.hora_inicio+" a "+data.fecha_recibido.hora_final
            armSV.isHidden=false
            armSVHeight.constant=155

        }else{
            armSVHeight.constant=0
            armSV.isHidden=true
        }
        
        if data.req_entrega==1{
            var sEnt = "Del " + data.fecha_repartido.fecha_inicio+" al "+data.fecha_repartido.fecha_final+". Los días: "
            if let c = data.horarios[2]?.days.count {
                var i=0
                for dia in data.horarios[2]!.days{
                    i+=1
                    if c==1 {
                        sEnt = sEnt + dia.name
                    }else{
                        if i == c {
                            sEnt = sEnt + " y " + dia.name
                        }else if i == c-1 {
                            sEnt = sEnt + dia.name
                        }else{
                            sEnt = sEnt + dia.name + ", "
                        }
                    }
                }
            }
            diasEntLbl.text = sEnt
            horarioEntLbl.text = "En un horario de "+data.fecha_repartido.hora_inicio+" a "+data.fecha_repartido.hora_final
            direcEntLbl.text="A la dirección: "+data.direccion_entrega
            entSV.isHidden=false
            entSVHeight.constant=220
        }else{
            entSV.isHidden=true
            entSVHeight.constant=0
        }
        
        lblRequisitos.sizeToFit()
        lblRequisitos.layoutIfNeeded()
        lblDirec.sizeToFit()
        lblDirec.layoutIfNeeded()
        lblInfo.sizeToFit()
        lblInfo.layoutIfNeeded()
        diasRecLbl.sizeToFit()
        diasRecLbl.layoutIfNeeded()
        diasArmLbl.sizeToFit()
        diasArmLbl.layoutIfNeeded()
        diasEntLbl.sizeToFit()
        diasEntLbl.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
