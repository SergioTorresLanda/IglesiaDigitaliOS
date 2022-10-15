//
//  CustomCell.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 20/03/21.
//

import Foundation
import UIKit


class CustomeCellNotification: SwipeCollectionViewCell {
    
    var serviceSelected: String?
    var idSelected: Int?
    var statusSelected: String?
    
    lazy var btnStatus: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .clear
        return btn
        
    }()
    
    lazy var lblTitle1: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica-Bold", size: 20)
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.textColor = UIColor(red: 25.0/255, green: 42.0/255, blue: 114.0/255, alpha: 1.0)
        lbl.text = "Sin Servicios"
        return lbl
    }()
    
    lazy var lblTitle2: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 16)
        lbl.textColor = .black
        lbl.text = "Aún no tiene servicios agendados"
        
        return lbl
    }()
    
    lazy var lblStatus: UILabel = {
       let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 14)
        lbl.textColor = .gray
        lbl.text = ""
        return lbl
    }()
    
    lazy var actionRight: ActionRightCell = {
        let actionRight = ActionRightCell()
        actionRight.translatesAutoresizingMaskIntoConstraints = false
        return actionRight
    }()
    
    let colorBtnBlue: UIColor = UIColor(red: 25.0/255, green: 42.0/255, blue: 114.0/255, alpha: 1.0)

   override init(frame: CGRect) {
       super.init(frame: frame)
        self.setupViews()
   }

    private func setupViews() {
        contentView.addSubview(btnStatus)
        self.addSubview(lblTitle1)
        self.addSubview(lblTitle2)
        contentView.addSubview(lblStatus)
        self.addSubview(actionRight)
        
        self.btnStatus.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.btnStatus.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.btnStatus.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15).isActive = true
        self.btnStatus.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 25).isActive = true
        
        self.lblTitle1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.lblTitle1.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.lblTitle1.leftAnchor.constraint(equalTo: self.btnStatus.rightAnchor, constant: 10).isActive = true
        self.lblTitle1.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        
        self.lblTitle2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.lblTitle2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.lblTitle2.leftAnchor.constraint(equalTo: self.btnStatus.rightAnchor, constant: 10).isActive = true
        self.lblTitle2.topAnchor.constraint(equalTo: self.lblTitle1.bottomAnchor, constant: 0).isActive = true

        self.lblStatus.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.lblStatus.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.lblStatus.leftAnchor.constraint(equalTo: self.btnStatus.rightAnchor, constant: 10).isActive = true
        self.lblStatus.topAnchor.constraint(equalTo: self.lblTitle2.bottomAnchor, constant: 0).isActive = true
        
        actionRight.widthAnchor(equalTo: 80)
        actionRight.heightAnchor(equalTo: bounds.height)
        actionRight.topAnchor(equalTo: topAnchor)
        actionRight.trailingAnchor(equalTo: trailingAnchor)
        actionRight.bottomAnchor(equalTo: bottomAnchor)
        
        self.actionRight.phoneButton.isHidden = true
        self.actionRight.acceptLabel.isHidden = true
        self.actionRight.backgroundColor = .clear
    
    }
    
    func configureCell(data: StatusModelNotification?, noData: Bool, flagX: Bool) {
        guard let allData = data else { return }
        noData ? self.configureNoData() : self.configureData(data: allData, flagX: flagX)
    }
    
    private func configureNoData(){
        self.lblTitle1.textColor = .gray
        self.lblTitle2.textColor = .gray
        self.actionRight.isHidden = true
        self.lblStatus.isHidden = true
        self.btnStatus.isHidden = true
    }
    
    private func configureData(data: StatusModelNotification, flagX: Bool) {
        

        self.idSelected = data.id
        self.serviceSelected = data.service?.name
        self.lblTitle1.text = data.service?.name
        self.lblTitle2.text = data.priest?.name
        self.statusSelected = data.status
        //self.lblTitle2.text = data.priest?.name
       
        var btnImage = UIImage(named: "imgOK", in: Bundle.local, compatibleWith: nil)
        
        switch data.status {
        case "ACCEPTED":

            self.lblStatus.text = "Aceptado"
            //self.btnStatus.backgroundColor = .green
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            btnImage = UIImage(named: "sos_icon_accepted", in: Bundle.local, compatibleWith: nil)
            break

        case "CANCELED":
            self.lblStatus.text = "Cancelado"
            //self.btnStatus.backgroundColor = .red
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            self.actionRight.lineVerticalView.isHidden = true
            btnImage = UIImage(named: "sos_icon_canceled", in: Bundle.local, compatibleWith: nil)

            break

        case "COMPLETED":
            self.lblStatus.text = "Completado"
            //self.btnStatus.backgroundColor = .green
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            self.actionRight.lineVerticalView.isHidden = true
            btnImage = UIImage(named: "sos_icon_completed", in: Bundle.local, compatibleWith: nil)

            break

        case "REJECTED":

            self.lblStatus.text = "Rejected"
            //self.btnStatus.backgroundColor = .red
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            btnImage = UIImage(named: "sos_icon_rejected", in: Bundle.local, compatibleWith: nil)

            break

        case "IN_PROGRESS":
            self.lblStatus.text = "En Progreso"
            //self.btnStatus.backgroundColor = .yellow
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            self.actionRight.lineVerticalView.isHidden = false
            btnImage = UIImage(named: "sos_icon_in_progress", in: Bundle.local, compatibleWith: nil)

            break


        
        case .none:
            
            //self.btnStatus.backgroundColor = .yellow
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            self.actionRight.lineVerticalView.isHidden = false
            
            break
       
        case .some(_):
            
            //self.btnStatus.backgroundColor = .yellow
            self.btnStatus.isHidden = false
            self.lblStatus.isHidden = false
            self.actionRight.lineVerticalView.isHidden = false
            
            break
        }
            
        self.btnStatus.setImage(btnImage, for: UIControl.State.normal)
        self.actionRight.lineVerticalView.isHidden = true

    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
}

