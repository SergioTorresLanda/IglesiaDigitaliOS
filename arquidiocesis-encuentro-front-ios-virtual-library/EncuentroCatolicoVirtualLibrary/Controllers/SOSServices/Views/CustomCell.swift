//
//  CustomCell.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 20/03/21.
//

import Foundation
import UIKit

protocol ProtocolCellView: NSObjectProtocol {
    func tapButtonLeft(status: String, id: Int)
    func tapButtonRight(status: String, id: Int, service: String)
    func tapImage(status: String, id: Int)
}

class CustomeCell: SwipeCollectionViewCell {
    weak var cellDelegate: ProtocolCellView?
    var serviceSelected: String?
    var idSelected: Int?
    var statusSelected: String?

    lazy var btnLeft: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
        btn.setTitle("Cancelar", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(tapLeft), for: .touchUpInside)
        btn.tag = 1
        return btn

    }()

    lazy var btnRight: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
        btn.setTitle("Aceptar", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(tapRight), for: .touchUpInside)
        btn.tag = 2
        return btn

    }()

    lazy var btnStatus: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = .green
        return btn

    }()

    lazy var img: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "imgIglesia", in: Bundle.local, compatibleWith: nil)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        return img
    }()

    lazy var lblTitle1: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 18)
        lbl.textColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
        lbl.text = "Unición de los enfermos"

        return lbl
    }()

    lazy var lblTitle2: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 14)
        lbl.textColor = .black
        lbl.text = "Hector Adomatis"

        return lbl
    }()

    lazy var lblStatus: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Helvetica", size: 13)
        lbl.textColor = .gray
        lbl.text = "En Progreso"

        return lbl
    }()

    lazy var actionRight: ActionRightCell = {
        let actionRight = ActionRightCell()
        actionRight.translatesAutoresizingMaskIntoConstraints = false
        return actionRight
    }()

    let colorBtnBlue: UIColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(btnLeft)
        contentView.addSubview(btnRight)
        contentView.addSubview(lblTitle1)
        contentView.addSubview(lblTitle2)
        contentView.addSubview(img)
        contentView.addSubview(btnStatus)
        contentView.addSubview(lblStatus)
        contentView.addSubview(actionRight)
        actionRight.actionRightCellDelegate = self

        lblTitle1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        lblTitle1.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lblTitle1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        lblTitle1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true

        lblTitle2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblTitle2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lblTitle2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        lblTitle2.topAnchor.constraint(equalTo: lblTitle1.bottomAnchor, constant: 5).isActive = true

        btnLeft.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnLeft.widthAnchor.constraint(equalToConstant: 190).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2).isActive = true
        btnLeft.topAnchor.constraint(equalTo: lblTitle2.bottomAnchor, constant: 35).isActive = true
//

        btnRight.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnRight.widthAnchor.constraint(equalToConstant: 190).isActive = true
        btnRight.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        btnRight.topAnchor.constraint(equalTo: lblTitle2.bottomAnchor, constant: 35).isActive = true

        img.heightAnchor.constraint(equalToConstant: 20).isActive = true
        img.widthAnchor.constraint(equalToConstant: 20).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
        img.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true

        lblStatus.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblStatus.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lblStatus.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 250).isActive = true
        lblStatus.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 65).isActive = true

        btnStatus.heightAnchor.constraint(equalToConstant: 20).isActive = true
        btnStatus.widthAnchor.constraint(equalToConstant: 20).isActive = true
        btnStatus.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 65).isActive = true
        btnStatus.rightAnchor.constraint(equalTo: lblStatus.rightAnchor, constant: 5).isActive = true

        actionRight.widthAnchor(equalTo: 80)
        actionRight.heightAnchor(equalTo: bounds.height)
        actionRight.topAnchor(equalTo: topAnchor)
        actionRight.trailingAnchor(equalTo: trailingAnchor)
        actionRight.bottomAnchor(equalTo: bottomAnchor)
        
    
        #warning("hide pare pruebas de swipe ")
        btnLeft.isHidden = true
        btnRight.isHidden = true
    }
    
    

    func configureCell(data: StatusModel) {
        idSelected = data.id
        serviceSelected = data.service?.name
        lblTitle1.text = data.service?.name
        statusSelected = data.status
        // self.lblTitle2.text = data.priest?.name

        switch data.status {
        case "ACCEPTED":
            btnRight.isHidden = true
            btnLeft.isHidden = true
            lblStatus.text = "Aceptado"
            btnStatus.backgroundColor = .green
            let img: UIImage = UIImage(named: "toolkit", in: Bundle.local, compatibleWith: nil) ?? UIImage()
            btnLeft.setTitle("Cancelar", for: .normal)
            btnRight.setTitle("Concluir", for: .normal)
            btnLeft.setTitleColor(.white, for: .normal)
            btnRight.setTitleColor(.white, for: .normal)
            btnLeft.backgroundColor = colorBtnBlue
            btnRight.backgroundColor = colorBtnBlue
            self.img.isHidden = true
            btnStatus.isHidden = false
            lblStatus.isHidden = false
            btnRight.moveImageLeftTextCenter(image: img.scaleImage(toSize: CGSize(width: 12, height: 12))!, imagePadding: 0.0, renderingMode: .alwaysOriginal)
            self.actionRight.isHidden = true
            break

        case "CANCELED":
            btnRight.isHidden = true
            btnLeft.isHidden = true
            lblStatus.text = "Cancelado"
            btnStatus.backgroundColor = .red
            let img: UIImage = UIImage(named: "toolkit", in: Bundle.local, compatibleWith: nil) ?? UIImage()
            btnLeft.setTitle("Cancelar", for: .normal)
            btnRight.setTitle("Reactivar", for: .normal)
            btnLeft.setTitleColor(.white, for: .normal)
            btnRight.setTitleColor(.white, for: .normal)
            btnLeft.backgroundColor = .gray
            btnRight.backgroundColor = colorBtnBlue
            self.img.isHidden = true
            btnStatus.isHidden = false
            lblStatus.isHidden = false
            btnRight.moveImageLeftTextCenter(image: img.scaleImage(toSize: CGSize(width: 12, height: 12))!, imagePadding: 0.0, renderingMode: .alwaysOriginal)
            self.actionRight.isHidden = true
            break

        case "COMPLETED":
            btnRight.isHidden = true
            btnLeft.isHidden = true
            lblStatus.text = "Completado"
            btnStatus.backgroundColor = .green
            let img: UIImage = UIImage(named: "toolkit", in: Bundle.local, compatibleWith: nil) ?? UIImage()
            btnLeft.setTitle("Cancelar", for: .normal)
            btnRight.setTitle("Concluir", for: .normal)
            btnLeft.setTitleColor(.white, for: .normal)
            btnRight.setTitleColor(.white, for: .normal)
            btnLeft.backgroundColor = colorBtnBlue
            btnRight.backgroundColor = colorBtnBlue
            self.img.isHidden = true
            btnStatus.isHidden = false
            lblStatus.isHidden = false
            btnRight.moveImageLeftTextCenter(image: img.scaleImage(toSize: CGSize(width: 12, height: 12))!, imagePadding: 0.0, renderingMode: .alwaysOriginal)
            self.actionRight.isHidden = true
            break

        case "REJECTED":
            btnRight.isHidden = true
            btnLeft.isHidden = true
            lblStatus.text = "Rejected"
            btnStatus.backgroundColor = .red
            let img: UIImage = UIImage(named: "toolkit", in: Bundle.local, compatibleWith: nil) ?? UIImage()
            btnLeft.setTitle("Cancelar", for: .normal)
            btnRight.setTitle("Reactivar", for: .normal)
            btnLeft.setTitleColor(.white, for: .normal)
            btnRight.setTitleColor(.white, for: .normal)
            btnLeft.backgroundColor = .gray
            btnRight.backgroundColor = colorBtnBlue
            self.img.isHidden = true
            btnStatus.isHidden = false
            lblStatus.isHidden = false
            btnRight.moveImageLeftTextCenter(image: img.scaleImage(toSize: CGSize(width: 12, height: 12))!, imagePadding: 0.0, renderingMode: .alwaysOriginal)
            self.actionRight.isHidden = true
            break

        case "IN_PROGRESS":
           
            let img: UIImage = UIImage(named: "imgPhone", in: Bundle.local, compatibleWith: nil) ?? UIImage()
            btnLeft.setTitle("Rechazar", for: .normal)

            btnRight.setTitle("Aceptar", for: .normal)
            btnRight.moveImageLeftTextCenter(image: img.scaleImage(toSize: CGSize(width: 12, height: 12))!, imagePadding: 0.0, renderingMode: .alwaysOriginal)

            btnLeft.setTitleColor(.white, for: .normal)
            btnRight.setTitleColor(.white, for: .normal)
            btnLeft.backgroundColor = colorBtnBlue
            btnRight.backgroundColor = colorBtnBlue
            self.img.isHidden = false
            btnStatus.isHidden = true
            lblStatus.isHidden = true
            self.actionRight.isHidden = false
            btnLeft.isHidden = true
            btnRight.isHidden = true
            break

        case .none:
            break
        case .some:
            break
        }
    }

    @objc func tapLeft(sender: UIButton) {
        cellDelegate?.tapButtonLeft(status: statusSelected ?? "Canceled", id: idSelected ?? 0)
    }

    @objc func tapRight(sender: UIButton) {
        cellDelegate?.tapButtonRight(status: statusSelected ?? "Canceled", id: idSelected ?? 0, service: serviceSelected ?? "")
    }
}

extension CustomeCell: ActionRightCellProtocol {
    func didButtonPhone(status: String, id: Int, service: String) {
        self.cellDelegate?.tapImage(status: self.statusSelected ?? "CANCELED", id: self.idSelected ?? 0)
    }
    
    
}

internal protocol ActionRightCellProtocol {
    func didButtonPhone(status: String, id: Int, service: String)
}

class ActionRightCell: UIView {
    var actionRightCellDelegate: ActionRightCellProtocol?

    lazy var phoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "imgPhone", in: Bundle.local, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(red: 82 / 255, green: 179 / 255, blue: 247 / 255, alpha: 1.0)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didButtonPhone), for: .touchUpInside)
        return button
    }()

    lazy var acceptLabel: UILabel = {
        let label = UILabel()
        label.text = "Aceptar"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 11)
        label.textColor = UIColor(red: 82 / 255, green: 179 / 255, blue: 247 / 255, alpha: 1.0)

        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: label.text ?? "", attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        return label
    }()

    lazy var lineVerticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 255 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1.0)

        [phoneButton, acceptLabel, lineVerticalView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

//        addSubview(lineVerticalView)
        phoneButton.widthAnchor(equalTo: 80)
        phoneButton.centerXAnchor(equalTo: centerXAnchor, constant: -7.5)
        phoneButton.centerYAnchor(equalTo: centerYAnchor, constant: -10)

        acceptLabel.centerXAnchor(equalTo: centerXAnchor, constant: -7.5)
        acceptLabel.centerYAnchor(equalTo: centerYAnchor, constant: 20)

        lineVerticalView.widthAnchor(equalTo: 14)
        lineVerticalView.topAnchor(equalTo: topAnchor)
        lineVerticalView.trailingAnchor(equalTo: trailingAnchor)
        lineVerticalView.bottomAnchor(equalTo: bottomAnchor)
    }

    @objc private func didButtonPhone() {
        actionRightCellDelegate?.didButtonPhone(status: "", id: 1, service: "")
    }
}
