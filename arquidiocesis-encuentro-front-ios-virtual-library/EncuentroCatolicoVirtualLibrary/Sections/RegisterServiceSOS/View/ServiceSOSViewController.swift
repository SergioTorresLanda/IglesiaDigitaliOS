//
//  ServiceSOSViewController.swift
//  FielSOS
//
//  Created by René Sandoval on 23/03/21.
//

import UIKit

class ServiceSOSViewController: UIViewController {
    var presenter: ServiceSOSPresenterType?

    private lazy var backButton: UIButton = setupBackButton()
    private lazy var phoneImage: UIImageView = setupPhoneImage()

    private lazy var titleLabel: UILabel = setupTitleLabel()
    private lazy var subtitleLabel: UILabel = setupSubtitleLabel()

    private lazy var nameLabel: UILabel = setupNameLabel()
    private lazy var nameTextfield: UITextField = setupNameTexfield()

    private lazy var phoneLabel: UILabel = setupPhoneLabel()
    private lazy var phoneTextfield: UITextField = setupPhoneTexfield()

    private lazy var saveButton: UIButton = setupSaveButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter?.onViewDidLoad()
    }

    private func configureView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white

        [backButton, phoneImage, titleLabel, subtitleLabel, nameLabel, nameTextfield, phoneLabel, phoneTextfield, saveButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        backButton.topAnchor(equalTo: view.safeTopAnchor, constant: 10)
        backButton.leadingAnchor(equalTo: view.leadingAnchor, constant: 25)
        backButton.widthAnchor(equalTo: 15)
        backButton.heightAnchor(equalTo: 20)

        phoneImage.topAnchor(equalTo: view.safeTopAnchor, constant: 50)
        phoneImage.centerXAnchor(equalTo: view.centerXAnchor)
        phoneImage.widthAnchor(equalTo: 50)
        phoneImage.heightAnchor(equalTo: 50)

        titleLabel.topAnchor(equalTo: phoneImage.bottomAnchor, constant: 50)
        titleLabel.widthAnchor(equalTo: view.frame.width - 20)
        titleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        subtitleLabel.topAnchor(equalTo: titleLabel.bottomAnchor, constant: 40)
        subtitleLabel.widthAnchor(equalTo: view.frame.width - 20)
        subtitleLabel.heightAnchor(equalTo: 20)
        subtitleLabel.centerXAnchor(equalTo: view.centerXAnchor)

        nameLabel.topAnchor(equalTo: subtitleLabel.bottomAnchor, constant: 20)
        nameLabel.widthAnchor(equalTo: view.frame.width - 30)
        nameLabel.centerXAnchor(equalTo: view.centerXAnchor)

        nameTextfield.topAnchor(equalTo: nameLabel.bottomAnchor)
        nameTextfield.widthAnchor(equalTo: view.frame.width - 30)
        nameTextfield.heightAnchor(equalTo: 40)
        nameTextfield.centerXAnchor(equalTo: view.centerXAnchor)

        phoneLabel.topAnchor(equalTo: nameTextfield.bottomAnchor, constant: 25)
        phoneLabel.widthAnchor(equalTo: view.frame.width - 30)
        phoneLabel.centerXAnchor(equalTo: view.centerXAnchor)

        phoneTextfield.topAnchor(equalTo: phoneLabel.bottomAnchor)
        phoneTextfield.widthAnchor(equalTo: view.frame.width - 30)
        phoneTextfield.heightAnchor(equalTo: 40)
        phoneTextfield.centerXAnchor(equalTo: view.centerXAnchor)

        saveButton.topAnchor(equalTo: phoneTextfield.bottomAnchor, constant: 50)
        saveButton.widthAnchor(equalTo: view.frame.width - 40)
        saveButton.heightAnchor(equalTo: 48)
        saveButton.centerXAnchor(equalTo: view.centerXAnchor)
    }
}

// MARK: - Actions

extension ServiceSOSViewController {
    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }

    @objc func registerService() {
        let parameters = [
            "devotee": [
                "devoteeId": 1,
                "phone": presenter?.serviceSOS.phone ?? "",
            ],
            "service": [
                "id": presenter?.serviceSOS.serviceId,
            ],
            "priest": [
//                "priestId": presenter?.priest.priestId,
                  "priestId" : 5,
            ],
            "location": [
                "id": 5,
            ],
            "latitude": 19.392642,
            "longitude": -99.08929,
        ] as [String: Any]

        presenter?.onRegisterService(withParameters: parameters)
    }
}

// MARK: - Views

extension ServiceSOSViewController {
    private func setupBackButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_left", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return button
    }

    private func setupPhoneImage() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "llamadaTelefonica", in: Bundle.local, compatibleWith: nil)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }

    private func setupTitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22.0, weight: .bold)
        label.textColor = Colors.main
        return label
    }

    private func setupSubtitleLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Llamar a otro número"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = Colors.titles
        return label
    }

    private func setupNameLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Nombre (s)"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = Colors.main
        return label
    }

    private func setupNameTexfield() -> UITextField {
        let textField = UITextField()
        textField.addBottomBorderWithColor(color: Colors.titles, width: 1.0)
        return textField
    }

    private func setupPhoneLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Número de celular"
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = Colors.main
        return label
    }

    private func setupPhoneTexfield() -> UITextField {
        let textField = UITextField()
        textField.addBottomBorderWithColor(color: Colors.titles, width: 1.0)
        return textField
    }

    private func setupSaveButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Aceptar", for: .normal)
        button.addTarget(self, action: #selector(registerService), for: .touchUpInside)
        button.backgroundColor = Colors.main
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }
}

// MARK: - ChurchsViewType

extension ServiceSOSViewController: ServiceSOSViewType {
    func didRegisterService(_ status: Bool) {
//        let alertController = UIAlertController(title: "SERVICE CREADO: \(status)", message: nil, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        let alert = AlertSingleViewController.showAlert(titulo: "RECIBIMOS TU SOLICITUD", mensaje: "En breve el Párroco \(presenter?.priest.name ?? "") se comunicara contigo.")
//        present(alert, animated: true) {
        
        let alert = AlertOneButtonViewController.showAlert(titulo: "SERVICE CREADO: \(status)", mensaje: "")
        present(alert, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                
               let notificationView =  NotificationRouter.presentModule()
                self.navigationController?.pushViewController(notificationView, animated: true)
               // self.navigationController?.popViewController(animated: true)
            }
       // }
    }

    func setPriestLabel(priest: Priest) {
        let phone = UserDefaults.standard.string(forKey: "telefono")

        let attributedString = NSMutableAttributedString(string: "Solicito que el \nPárroco \(priest.name)\nme llame al número:\n\n\(phone ?? "")", attributes: [
            .font: UIFont.systemFont(ofSize: 20.0, weight: .medium),
            .foregroundColor: UIColor(red: 19.0 / 255.0, green: 39.0 / 255.0, blue: 124.0 / 255.0, alpha: 1.0),
        ])
//        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20.0, weight: .bold), range: NSRange(location: 17, length: priest.name.count))
//        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 28.0, weight: .bold), range: NSRange(location: 17 + priest.name.count, length: 12))

        titleLabel.attributedText = attributedString
    }

    func showLoading() {
        LoadingIndicatorView.show()
    }

    func hideLoading() {
        LoadingIndicatorView.hide()
    }
}

extension ServiceSOSViewController: SubDelegateAlert {
    func refuseButton(action: AlertTwoButtonsViewController) {
    }

    func scheduleButton(action: AlertTwoButtonsViewController) {
    }

    func acceptServiceButton(action: AlertOneButtonViewController) {
    }
}
