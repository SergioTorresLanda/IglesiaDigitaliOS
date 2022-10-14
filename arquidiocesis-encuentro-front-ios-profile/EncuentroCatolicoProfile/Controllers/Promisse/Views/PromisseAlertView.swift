//
//  PromisseAlertViewController.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

protocol PromisseAlertViewProtocol:class {
    func dissmisAlert()
}

class PromisseAlertView: UIView {

    weak var delegate: PromisseAlertViewProtocol?
    var context: UIViewController?
    private var topAnchorCustom : NSLayoutConstraint?
    private var leadingAnchorCustom : NSLayoutConstraint?
    private var trailingAnchorCustom : NSLayoutConstraint?
    private var bottomAnchorCustom : NSLayoutConstraint?
    private var centerxAnchorCustom : NSLayoutConstraint?
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageToPromisse : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titlePromisse: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        button.tintColor = .white
        button.setTitle("Amén", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6959592301)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCustom(context: UIViewController,
                    pharraphers: NSAttributedString,
                    image: String){
        self.context = context
        if #available(iOS 13.0, *) {
            self.imageToPromisse.image = UIImage(named: image, in: Bundle.local, with: nil)
        } else {
            // Fallback on earlier versions
        }
        self.titlePromisse.attributedText = pharraphers
        self.setupComponents()
        self.setupComponentsConstraint()
    }
    
    func displayAnimation(){
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear, .curveEaseInOut]) {
                self.centerxAnchorCustom?.constant = 0
                self.layoutIfNeeded()
            } completion: { (isFinish) in

            }
        }
    }
  
    private func setupComponents(){
        doneButton.addTarget(self, action: #selector(self.dissmisAlert), for: .touchUpInside)
        self.addSubview(containerView)
        containerView.addSubview(cardView)
        cardView.addSubview(imageToPromisse)
        cardView.addSubview(titlePromisse)
        cardView.addSubview(doneButton)
    }
    private func setupComponentsConstraint(){
        topAnchorCustom = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: context?.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        trailingAnchorCustom = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: context?.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
        leadingAnchorCustom = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: context?.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        bottomAnchorCustom = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: context?.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        topAnchorCustom?.isActive = true
        trailingAnchorCustom?.isActive = true
        leadingAnchorCustom?.isActive = true
        bottomAnchorCustom?.isActive = true
        
        
        centerxAnchorCustom = NSLayoutConstraint(item: containerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 1000)
        centerxAnchorCustom?.isActive = true
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cardView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            cardView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.6, constant: 0),
            
            imageToPromisse.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            imageToPromisse.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageToPromisse.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.5, constant: 0),
            imageToPromisse.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.7, constant: 0),
            
            titlePromisse.topAnchor.constraint(equalTo: imageToPromisse.bottomAnchor, constant: 25),
            titlePromisse.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            titlePromisse.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            
            doneButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 48),
            doneButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func dissmisAlert(){
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [.curveLinear, .curveEaseInOut]) {
            self.centerxAnchorCustom?.constant = 1000
            self.layoutIfNeeded()
        } completion: { (isFinish) in
            self.isHidden = true
            self.topAnchorCustom?.isActive = false
            self.trailingAnchorCustom?.isActive = false
            self.leadingAnchorCustom?.isActive = false
            self.bottomAnchorCustom?.isActive = false
            self.centerxAnchorCustom?.isActive = false
            self.delegate?.dissmisAlert()
            self.removeFromSuperview()
        }
    }
}
