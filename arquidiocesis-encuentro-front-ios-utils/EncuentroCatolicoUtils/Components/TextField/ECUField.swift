//
//  FHCTextField.swift
//  FHCommons
//
//  Created by Alejandro Orihuela on 12/03/22.
//

import UIKit

open class ECUField: ECUView {
    //MARK: - @IBInspectable
    @IBInspectable
    public var fieldName: String = " " {
        didSet { titleLabel.text = fieldName }
    }
    
    @IBInspectable
    public var fieldDescription: String = "" {
        didSet {
            descriptionLabel.isHidden = fieldDescription.trimmingCharacters(in: [" "]) == ""
            descriptionLabel.text = fieldDescription
        }
    }

    @IBInspectable
    public var placeholderText: String = " " {
        didSet { setupPlaceholder() }
    }
    
    @IBInspectable
    public var placeholderColor: UIColor = UIColor() {
        didSet { setupPlaceholder() }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 1 {
        didSet { self.textField.layer.borderWidth = borderWidth }
    }
    
    @IBInspectable
    public var textFieldCornerRadius: CGFloat = 0.2 {
        didSet { layoutIfNeeded() }
    }
    
    @IBInspectable
    public var leftIcon: UIImage? {
        didSet {
            guard superview != nil else {
                debugPrint("Before use this property first add tu superview")
                return
            }
            
            self.textField.leftIcon = leftIcon
        }
    }
    
    @IBInspectable
    public var rightIcon: UIImage? {
        didSet {
            guard superview != nil else {
                debugPrint("Before use this property first add tu superview")
                return
            }
            
            self.textField.rightIcon = rightIcon
        }
    }
    
    
    //MARK: - Properties
    public var shouldChangeCharacters: ((_ value: String) -> Bool)?
    public var validations: [ECUValidation] = []
    public var onClickLeftAction: (ECGenericAction)? {
        didSet { textField.leftAction = onClickLeftAction }
    }
    public var onClickRightAction: ECGenericAction? {
        didSet { textField.rightAction = onClickRightAction }
    }
    
    var color: UIColor = .primary {
        didSet {
            textField.layer.borderColor = color.cgColor
            textField.tintColor = color
        }
    }
    public let textField: ECUGenericTextField = ECUGenericTextField()
    
    private var isValid: Bool = false
    
    private let titleLabel: UILabel = {
        let label = ECULabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .primary
        label.numberOfLines = 1
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = ECULabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .disabled
        label.numberOfLines = 0
        
        return label
    }()
    
    private let vTitleStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 2
        
        return stack
    }()
    
    //MARK: - Methods
    @discardableResult
    func validate() -> String? {
        var lastMessage: String?
        
        for validation in validations {
            lastMessage = validation(textField.text)
            
            if lastMessage != nil {
                break
            }
        }
        
        textField.layer.borderColor = lastMessage != nil ? UIColor.dangerDark.cgColor : color.cgColor
        isValid = lastMessage == nil
        
        return lastMessage
    }
    
    //MARK: - Life Cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.textField.layer.cornerRadius = self.textField.layer.frame.height * textFieldCornerRadius
    }
    
    //MARK: - Events
    @objc func onChangeTextField(_ sender: UITextField) {
        validate()
    }
}

//MARK: - UITextFieldDelegate
extension ECUField: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        validate()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.shouldChangeCharacters?(textField.text ?? "") ?? true
    }
}


//MARK: - Private functions
extension ECUField {
    private func commonInit() {
        setupConstraints()
        setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(onChangeTextField(_:)), for: .editingChanged)
        textField.addBorder(toSide: .bottom, withColor: UIColor.disabled.cgColor, andThickness: 5.0)
    }
    
    private func setupConstraints() {
        self.addSubview(vTitleStack)
        self.addSubview(textField)
        
        vTitleStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vTitleStack.topAnchor.constraint(equalTo: self.topAnchor),
            vTitleStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vTitleStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        vTitleStack.addArrangedSubview(titleLabel)
        vTitleStack.addArrangedSubview(descriptionLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupPlaceholder() {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
}
