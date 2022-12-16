//
//  ECUDonationToMyChurch.swift
//  EncuentroCatolicoUtils
//
//  Created by llavin on 28/11/22.
//


import UIKit
import WebKit

@MainActor
public class ECUDonationToMyChurch: UIView {

    //ContentViewTimer
    
    public var contentProfile : UIView = {
        let view               = UIView()
        view.backgroundColor   = .clear
        return view
    }()
    
    public var lblTitle: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textColor       = #colorLiteral(red: 0.005660862196, green: 0.1261225939, blue: 0.4083669782, alpha: 1)
        lbl.textAlignment   = .center
        lbl.text = "Tiempo restante para completar el pago"
        lbl.numberOfLines   = 0
        
        return lbl
        
    }()
    
    public var stkContainerTimer : UIStackView = {
        let stk             =   UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis            =   .horizontal
        stk.alignment       =   .fill
        stk.distribution    =   .fill
        stk.spacing         =   2
        
        return stk
    }()
    
    public var contentView1 : UIView = {
        let view               = UIView()
        view.backgroundColor   = .clear
        return view
    }()
    
    public var lblMin: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 29)
        lbl.textColor       = #colorLiteral(red: 0.7680516839, green: 0.7483631968, blue: 0.7487085462, alpha: 1)
        lbl.textAlignment   = .center
        lbl.text = "00"
        lbl.numberOfLines   = 0
        
        return lbl
    }()
    
    public var btnTM1: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.textColor       = #colorLiteral(red: 0.005660862196, green: 0.1261225939, blue: 0.4083669782, alpha: 1)
        lbl.textAlignment   = .center
        lbl.text = ":"
        lbl.numberOfLines   = 0
        
        return lbl
        
    }()
    
    /*public var btnTM1: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.setTitle(":", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //btn.setImage(UIImage(named: "TwoPoints", in: Bundle.local, compatibleWith: nil), for: .normal)
        btn.tag = 4
        return btn

    }()*/
    
    public var contentView2 : UIView = {
        let view               = UIView()
        view.backgroundColor   = .clear
        return view
    }()
    
    public var lblSeg: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 29)
        lbl.textColor       = #colorLiteral(red: 0.7680516839, green: 0.7483631968, blue: 0.7487085462, alpha: 1)
        lbl.textAlignment   = .center
        lbl.text = "00"
        lbl.numberOfLines   = 0
        
        return lbl
    }()
    
    public var btnTM2: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.textColor       = #colorLiteral(red: 0.005660862196, green: 0.1261225939, blue: 0.4083669782, alpha: 1)
        lbl.textAlignment   = .center
        lbl.text = ":"
        lbl.numberOfLines   = 0
        //lbl.isHidden = true
        
        return lbl
        
    }()
    
    /*public var btnTM2: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.setTitle(":", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        //btn.setImage(UIImage(named: "TwoPoints", in: Bundle.local, compatibleWith: nil), for: .normal)
        btn.tag = 4
        return btn

    }()*/
    
    
    public var contentView3 : UIView = {
        let view               = UIView()
        view.backgroundColor   = .clear
        //view.isHidden = true
        return view
    }()
    
    public var lblMil: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 29)
        lbl.textColor       = #colorLiteral(red: 0.7680516839, green: 0.7483631968, blue: 0.7487085462, alpha: 1)
        lbl.textAlignment   = .center
        lbl.text = "00"
        lbl.numberOfLines   = 0
        
        return lbl
    }()
    
    public var stkContainer1 : UIStackView = {
        let stk             =   UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis            =   .vertical
        stk.alignment       =   .fill
        stk.distribution    =   .fill
        stk.spacing         =   0
        
        return stk
    }()
    
    
    public var stkConcept : UIStackView = {
        let stk             =   UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis            =   .horizontal
        stk.alignment       =   .fill
        stk.distribution    =   .fill
        stk.spacing         =   5
        
        return stk
    }()
    
    public var lblConcept1: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor       = #colorLiteral(red: 0.005660862196, green: 0.1261225939, blue: 0.4083669782, alpha: 1)
        lbl.textAlignment   = .right
        lbl.text = "Concepto:"
        lbl.numberOfLines   = 0
        
        return lbl
        
    }()
    
    public var lblConcept2: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor       = #colorLiteral(red: 0.7680516839, green: 0.7483631968, blue: 0.7487085462, alpha: 1)
        lbl.textAlignment   = .left
        lbl.text = "Limosna"
        lbl.numberOfLines   = 0
        
        return lbl
        
    }()
    
    public var stkAmount : UIStackView = {
        let stk             =   UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis            =   .horizontal
        stk.alignment       =   .fill
        stk.distribution    =   .fill
        stk.spacing         =   5
        
        return stk
    }()
    
    public var lblAmount1: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor       = #colorLiteral(red: 0.005660862196, green: 0.1261225939, blue: 0.4083669782, alpha: 1)
        lbl.textAlignment   = .right
        lbl.text = "Monto:"
        lbl.numberOfLines   = 0
        
        return lbl
        
    }()
    
    public var lblAmount2: UILabel = {
        let lbl             = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font            = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor       = #colorLiteral(red: 0.7680516839, green: 0.7483631968, blue: 0.7487085462, alpha: 1)
        lbl.textAlignment   = .left
        lbl.text = "$100.00"
        lbl.numberOfLines   = 0
        
        return lbl
        
    }()
    
    //ContentWebView
    public var contentWebView : UIView = {
        let view               = UIView()
        view.backgroundColor   = .clear
        return view
    }()
    
    public var webView    :   WKWebView   = {
        let webView =   WKWebView()
        webView.backgroundColor =   UIColor.white
        webView.translatesAutoresizingMaskIntoConstraints   =   false
        
        return webView
    }()
    
    //ContentViewBtnCancel
    
    public var contentViewBtnCancel : UIView = {
        let view               = UIView()
        view.backgroundColor   = .clear
        return view
    }()
    
    let btnCancel: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setTitle("Cancelar", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.titleLabel?.textAlignment = .center
        //btn.addTarget(self,action: #selector(btnGoToPromos),for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    //MARK: - @IBInspectable
    
    @IBInspectable var titleText1: String? {
        didSet {
            lblTitle.text = titleText1 ?? ""
        }
    }
    
    @IBInspectable var titleText2: String? {
        didSet {
            lblConcept1.text = titleText2 ?? ""
        }
    }
    
    @IBInspectable var titleText3: String? {
        didSet {
            lblConcept2.text = titleText3 ?? ""
        }
    }
    
    
    @IBInspectable var titleText4: String? {
        didSet {
            lblAmount1.text = titleText4 ?? ""
        }
    }
    
    @IBInspectable var titleText5: String? {
        didSet {
            lblAmount2.text = titleText5 ?? ""
        }
    }
    
    //MARK: - Life Cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupConstraints()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}

//MARK:- Private funtions

extension ECUDonationToMyChurch {
    
    private func setupConstraints(){
        self.addSubview(contentProfile)
        self.contentProfile.addSubview(lblTitle)
        self.contentProfile.addSubview(stkContainerTimer)
        self.contentProfile.addSubview(stkContainer1)
        
        self.stkContainerTimer.addArrangedSubview(contentView1)
        self.stkContainerTimer.addArrangedSubview(btnTM1)
        self.stkContainerTimer.addArrangedSubview(contentView2)
        self.stkContainerTimer.addArrangedSubview(btnTM2)
        self.stkContainerTimer.addArrangedSubview(contentView3)
        self.contentView1.addSubview(lblMin)
        self.contentView2.addSubview(lblSeg)
        self.contentView3.addSubview(lblMil)
        self.stkContainer1.addArrangedSubview(stkConcept)
        self.stkConcept.addArrangedSubview(lblConcept1)
        self.stkConcept.addArrangedSubview(lblConcept2)
        self.stkContainer1.addArrangedSubview(stkAmount)
        self.stkAmount.addArrangedSubview(lblAmount1)
        self.stkAmount.addArrangedSubview(lblAmount2)
        //--
        self.addSubview(contentWebView)
        self.contentWebView.addSubview(webView)
        //-----
        self.addSubview(contentViewBtnCancel)
        self.contentViewBtnCancel.addSubview(btnCancel)
        
        
        let heightConstraint: NSLayoutConstraint = self.heightAnchor.constraint(equalToConstant: 786)

        heightConstraint.isActive = true
        heightConstraint.priority = .defaultLow
        
        
        //-----ProfileTime
        contentProfile.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentProfile.topAnchor.constraint(equalTo: self.topAnchor),
            contentProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentProfile.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentProfile.heightAnchor.constraint(equalToConstant: 166),
            
        ])
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblTitle.topAnchor.constraint(equalTo: contentProfile.topAnchor,constant: 12),
            lblTitle.leadingAnchor.constraint(equalTo: contentProfile.leadingAnchor),
            lblTitle.trailingAnchor.constraint(equalTo: contentProfile.trailingAnchor),
            lblTitle.heightAnchor.constraint(equalToConstant: 30)
           
        ])
        
        //-----Timer
        
        stkContainerTimer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stkContainerTimer.topAnchor.constraint(equalTo: lblTitle.bottomAnchor,constant: 12),
            stkContainerTimer.centerXAnchor.constraint(equalTo: contentProfile.centerXAnchor),
            stkContainerTimer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        contentView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            contentView1.heightAnchor.constraint(equalToConstant: 50),
            contentView1.widthAnchor.constraint(equalToConstant: 55),
            
        ])
        
        lblMin.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            lblMin.centerXAnchor.constraint(equalTo: contentView1.centerXAnchor),
            lblMin.centerYAnchor.constraint(equalTo: contentView1.centerYAnchor)
            
        ])
        
        btnTM1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            btnTM1.widthAnchor.constraint(equalToConstant: 9)
        ])
        
        
        contentView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            contentView2.heightAnchor.constraint(equalToConstant: 50),
            contentView2.widthAnchor.constraint(equalToConstant: 55),
            
        ])
        
        lblSeg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            lblSeg.centerXAnchor.constraint(equalTo: contentView2.centerXAnchor),
            lblSeg.centerYAnchor.constraint(equalTo: contentView2.centerYAnchor)
            
        ])
        
        btnTM2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            btnTM2.widthAnchor.constraint(equalToConstant: 9)
        
        ])
        
        contentView3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            contentView3.heightAnchor.constraint(equalToConstant: 50),
            contentView3.widthAnchor.constraint(equalToConstant: 55),
            
        ])
        
        lblMil.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            lblMil.centerXAnchor.constraint(equalTo: contentView3.centerXAnchor),
            lblMil.centerYAnchor.constraint(equalTo: contentView3.centerYAnchor)
            
        ])
        
        //----CONMON
        
        stkContainer1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stkContainer1.topAnchor.constraint(equalTo: stkContainerTimer.bottomAnchor,constant: 12),
            stkContainer1.leadingAnchor.constraint(equalTo: contentProfile.leadingAnchor),
            stkContainer1.trailingAnchor.constraint(equalTo: contentProfile.trailingAnchor),
            stkContainer1.bottomAnchor.constraint(equalTo: contentProfile.bottomAnchor)
            
        ])
        
        stkConcept.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         
            stkConcept.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        lblConcept1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblConcept1.widthAnchor.constraint(equalToConstant: 207)
        
        ])
        
        stkAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         
            stkAmount.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        lblAmount1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lblAmount1.widthAnchor.constraint(equalToConstant: 207)
        
        ])
        
        //-----WEBVIEW
        
        contentWebView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentWebView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            contentWebView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            contentWebView.topAnchor.constraint(equalTo: contentProfile.bottomAnchor,constant: 10),
            contentWebView.bottomAnchor.constraint(equalTo: contentViewBtnCancel.topAnchor,constant: -10)
            
        ])
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            webView.topAnchor.constraint(equalTo: contentWebView.topAnchor),
            webView.leadingAnchor.constraint(equalTo: contentWebView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentWebView.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: contentWebView.bottomAnchor)
        
        ])
        
        //-----BtnCANCEL
        
        contentViewBtnCancel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentViewBtnCancel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentViewBtnCancel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentViewBtnCancel.heightAnchor.constraint(equalToConstant: 50),
            contentViewBtnCancel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        btnCancel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            btnCancel.topAnchor.constraint(equalTo: contentViewBtnCancel.topAnchor,constant: 10),
            btnCancel.leadingAnchor.constraint(equalTo: contentViewBtnCancel.leadingAnchor, constant: 20),
            btnCancel.heightAnchor.constraint(equalToConstant: 38),
            btnCancel.widthAnchor.constraint(equalToConstant: 100)
            
        
        
        ])
        
    
        
    }
    
}
