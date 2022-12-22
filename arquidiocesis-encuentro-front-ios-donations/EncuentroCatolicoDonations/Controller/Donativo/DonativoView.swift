import Foundation
import UIKit
import PayCardsRecognizer

class DonativoView: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var txtTitular   : UITextField!
    @IBOutlet weak var txtTarjeta   : UITextField!
    @IBOutlet weak var fechaTarjeta : UITextField!
    @IBOutlet weak var txtCVV       : UITextField!
    @IBOutlet weak var txtMonto     : UITextField!
    @IBOutlet weak var btnconfirmar : UIButton!
    @IBOutlet weak var loader       : UIActivityIndicatorView!
    @IBOutlet weak var scrollView   : UIScrollView!
    @IBOutlet weak var btnBack      : UIImageView!
    @IBOutlet weak var navBarView   : UIView! 
    
    // MARK: Properties
    var presenter: DonativoPresenterProtocol?
    var cantidadVista: CGFloat = 0
    var pickerView = UIPickerView()
    private var mesSel = ""
    private var anioSel = ""
    let fechas = FechaLimite(mes: ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
        anio: ["16", "17", "18", "19", "20","21", "22", "23", "24", "25", "26", "27", "28", "29", "30"])
    var recognizer: PayCardsRecognizer!
    
    var bTitular: Bool = false
    var bTarjeta: Bool = false
    var bFecha: Bool = false
    var bcvv: Bool = false
    var bMonto: Bool = false

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.isHidden = true
        pickerView.delegate = self
        pickerView.dataSource = self
        crearPicker()
        self.hideKeyboardWhenTappedAround()
        cambiaColor(validacion: bTitular && bTarjeta && bFecha && bcvv && bMonto)
        cambioTextos()
        btnBack.image = UIImage(named:"backBlue", in: Bundle.local, compatibleWith: nil)
        navBarView.layer.shadowColor = UIColor.gray.cgColor
        navBarView.layer.shadowOffset = CGSize(width: 1, height: 1)
        navBarView.layer.shadowOpacity = 0.5
        txtTitular.setBottomBorder()
        txtCVV.setBottomBorder()
        txtMonto.setBottomBorder()
        txtTarjeta.setBottomBorder()
        fechaTarjeta.setBottomBorder()
        txtCVV.delegate = self
        txtMonto.delegate = self
        txtTitular.delegate = self
        txtTarjeta.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECDonations - Donativo")
    }
    
    private func cambioTextos() {
        txtTitular.addTarget(self, action: #selector(textFieldDidChangeTitular(textField:)), for: .editingChanged)
        txtTarjeta.addTarget(self, action: #selector(textFieldDidChangeTarjeta(textField:)), for: .editingChanged)
        fechaTarjeta.addTarget(self, action: #selector(textFieldDidChangeFecha(textField:)), for: .editingDidEnd)
        txtCVV.addTarget(self, action: #selector(textFieldDidChangeCvv(textField:)), for: .editingChanged)
        txtMonto.addTarget(self, action: #selector(textFieldDidChangeMonto(textField:)), for: .editingChanged)
    }
    
    @objc private func textFieldDidChangeTitular(textField: UITextField) {
        if textField.text?.count ?? 0 > 1 {
            bTitular = true
        }
        cambiaColor(validacion: bTitular && bTarjeta && bFecha && bcvv && bMonto)
    }
    
    @objc private func textFieldDidChangeTarjeta(textField: UITextField) {
        if textField.text?.count ?? 0 > 1 {
            bTarjeta = true
        }
        cambiaColor(validacion: bTitular && bTarjeta && bFecha && bcvv && bMonto)
    }
    
    @objc private func textFieldDidChangeFecha(textField: UITextField) {
        if textField.text?.count ?? 0 > 1 {
            bFecha = true
        }
        cambiaColor(validacion: bTitular && bTarjeta && bFecha && bcvv && bMonto)
    }
    
    @objc private func textFieldDidChangeCvv(textField: UITextField) {
        if textField.text?.count ?? 0 > 1 {
            bcvv = true
        }
        cambiaColor(validacion: bTitular && bTarjeta && bFecha && bcvv && bMonto)
    }
    
    @objc private func textFieldDidChangeMonto(textField: UITextField) {
        if textField.text?.count ?? 0 > 1 {
            bMonto = true
        }
        cambiaColor(validacion: bTitular && bTarjeta && bFecha && bcvv && bMonto)
    }
    
    private func cambiaColor(validacion: Bool) {
        btnconfirmar.backgroundColor = validacion ? UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1) : UIColor.gray
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
     //   cantidadVista = scrollView.contentOffset.y - 50
      //  scrollView.contentOffset.y = scrollView.contentOffset.y + 100
    }
    
    @objc private func keyboardDidHide(notification: NSNotification) {
      //  scrollView.contentOffset.y = cantidadVista
    }
    
    func crearPicker() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
        
        let botonAceptar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(aceptarBoton))
        toolbar.setItems([botonAceptar], animated: true)
        
        fechaTarjeta.inputAccessoryView = toolbar
        
        fechaTarjeta.inputView = pickerView
        fechaTarjeta.textAlignment = .center
    }
    
    @objc func aceptarBoton() -> Void {
        self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Actions
    @IBAction func camaraAction(_ sender: Any) {
        recognizer = PayCardsRecognizer(delegate: self, resultMode: .sync, container: self.view, frameColor: .blue)
        recognizer.startCamera()
    }
    
    @IBAction private func popView(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func calendarioAction(_ sender: Any) {
        
    }
    
    @IBAction func guardarAction(_ sender: Any) {
        
    }
    
    @IBAction func confirmarAction(_ sender: Any) {
        btnconfirmar.isEnabled = false
        loader.isHidden = false
        loader.startAnimating()
        presenter?.realizarDonativo(titular: txtTitular.text ?? "", numeroTarjeta: txtTarjeta.text ?? "", debito: true, fecha: fechaTarjeta.text ?? "", cvv: txtCVV.text ?? "", cantidad: txtMonto.text ?? "")
    }
    
//    @IBAction private func popView(_ sender: Any){
//        _ = navigationController?.popViewController(animated: true)
//    }
    
}

extension DonativoView: PayCardsRecognizerPlatformDelegate {
    
    func payCardsRecognizer(_ payCardsRecognizer: PayCardsRecognizer, didRecognize result: PayCardsRecognizerResult) {
        self.txtTitular.text = result.recognizedHolderName ?? ""
        self.txtTarjeta.text = result.recognizedNumber ?? ""
        guard let mes = result.recognizedExpireDateMonth, let anio = result.recognizedExpireDateYear else {
            self.recognizer.stopCamera()
            return
        }
        self.fechaTarjeta.text = mes + "/" + anio
        self.recognizer.stopCamera()
    }
    
}

extension DonativoView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return self.fechas.mes.count
        } else {
            return self.fechas.anio.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.fechas.mes[row]
        } else {
            return self.fechas.anio[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.mesSel = self.fechas.mes[row]
        } else {
            self.anioSel = self.fechas.anio[row]
        }
        self.fechaTarjeta.text = "\(mesSel)/\(anioSel)"
    }
    
}

extension DonativoView: DonativoViewProtocol {
    // TODO: implement view output methods
    func mostrarMSG(dtcAlerta: [String : String]) {
        self.btnconfirmar.isEnabled = true
        self.loader.stopAnimating()
        self.loader.isHidden = true
        let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alerta, animated: true, completion: nil)
    }
}

extension DonativoView: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        cantidadVista = scrollView.contentOffset.y - 50
        scrollView.contentOffset.y = scrollView.contentOffset.y - 100
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cantidadVista = scrollView.contentOffset.y - 50
        scrollView.contentOffset.y = scrollView.contentOffset.y + 100
    }
}

extension UITextField {
  func setBottomBorder() {
    self.borderStyle = .none
    self.layer.backgroundColor = UIColor.white.cgColor

    self.layer.masksToBounds = false
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = 0.0
  }
}
