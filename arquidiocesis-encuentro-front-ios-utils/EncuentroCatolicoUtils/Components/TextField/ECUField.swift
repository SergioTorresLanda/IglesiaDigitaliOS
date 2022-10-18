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
    public var rightIcon: UIImage? {
        didSet {
            self.textField.rightIcon = rightIcon
        }
    }
    
    @IBInspectable
    public var rightIconTint: UIColor? {
        didSet {
            self.textField.rightIconTint = rightIconTint
        }
    }
    
    
    //MARK: - Properties
    public var withReturn: Bool = false
    public var shouldChangeCharacters: ((_ value: String) -> Bool)?
    public var validations: [ECUValidation] = []
    public var onClickLeftAction: (ECGenericAction)? {
        didSet { textField.leftAction = onClickLeftAction }
    }
    public var onClickRightAction: ECGenericAction? {
        didSet { textField.rightAction = onClickRightAction }
    }
    
    public var isValid: Bool {
        validate()
    }
    public let textField: ECUGenericTextField = ECUGenericTextField()
    
    public var text: String {
        textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
    }
    
    var errorDesc: String? {
        didSet {
            errorInfoLabel.isHidden = (errorDesc?.trimmingCharacters(in: [" "]) ?? "") == ""
            errorInfoLabel.text = errorDesc
            textField.leftIconTint = errorDesc != nil ? .danger : nil
            textField.leftIcon = UIImage(named: errorDesc != nil ? "close" : "success", in: .local, compatibleWith: nil)
        }
    }
    var color: UIColor = .primary {
        didSet {
            textField.tintColor = color
        }
    }
    
    private var errorMessage: String? {
        var lastMessage: String?
        
        for validation in validations {
            lastMessage = validation(textField.text?.trimmingCharacters(in: .whitespaces))
            
            if lastMessage != nil {
                break
            }
        }
        
        return lastMessage
    }
    
    
    private let titleLabel: UILabel = {
        let label = ECULabel()
        
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .primary
        label.numberOfLines = 1
        
        return label
    }()
    
    private let errorInfoLabel: UILabel = {
        let label = ECULabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .danger
        label.numberOfLines = 0
        
        return label
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = ECULabel()
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .disabled
        label.numberOfLines = 0
        
        return label
    }()
    
    private let vTitleStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 0
        
        return stack
    }()
    
    private let vFieldStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        
        return stack
    }()
    
    //MARK: - Methods
    @discardableResult
    public func validate() -> Bool {
        errorDesc = self.errorMessage
        
        return errorDesc == nil
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
        if string == "\n" && !withReturn {
            return true
        }
        
        return self.shouldChangeCharacters?(string) ?? true
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
        
        textField.borderStyle = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(onChangeTextField(_:)), for: .editingChanged)
        textField.border = ECUBorder(side: .bottom, color: UIColor.disabled.cgColor, thickness: 1.0)
    }
    
    private func setupConstraints() {
        self.addSubview(vTitleStack)
        self.addSubview(vFieldStack)
        
        vTitleStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vTitleStack.topAnchor.constraint(equalTo: self.topAnchor),
            vTitleStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vTitleStack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        vTitleStack.addArrangedSubview(titleLabel)
        vTitleStack.addArrangedSubview(descriptionLabel)
        
        vFieldStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vFieldStack.topAnchor.constraint(equalTo: vTitleStack.bottomAnchor, constant: 8),
            vFieldStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vFieldStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vFieldStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        vFieldStack.addArrangedSubview(textField)
        vFieldStack.addArrangedSubview(errorInfoLabel)
    }
    
    private func setupPlaceholder() {
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
}
