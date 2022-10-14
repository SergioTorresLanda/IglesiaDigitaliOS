import Foundation

class DonativoPresenter  {
    
    // MARK: Properties
    weak var view: DonativoViewProtocol?
    var interactor: DonativoInteractorInputProtocol?
    var wireFrame: DonativoWireFrameProtocol?
    
}

extension DonativoPresenter: DonativoPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func realizarDonativo(titular: String, numeroTarjeta: String, debito: Bool, fecha: String, cvv: String, cantidad: String) {
        interactor?.realizarDonativo(titular: titular, numeroTarjeta: numeroTarjeta, debito: debito, fecha: fecha, cvv: cvv, cantidad: cantidad)
    }
}

extension DonativoPresenter: DonativoInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func callbackPago(errores: ErroresDonativo) {
        DispatchQueue.main.async {
            switch errores {
            case .OK:
                let msg = ["titulo": "Correcto", "cuerpo": "Donativo realizado correctamente"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .DatosVacios:
                let msg = ["titulo": "Atención", "cuerpo": "Faltan campos por llenar"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .tarjetaIncorrecta:
                let msg = ["titulo": "Atención", "cuerpo": "Favor de escribir todos los dígitos de la tarjeta"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ErrorServidor:
                let msg = ["titulo":"Error", "cuerpo": "Error en el servidor"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .cvvIncorrecto:
                let msg = ["titulo": "Atención", "cuerpo": "Favor de escribir los 3 dígitos de la tarjeta"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .cantidadIncorrecta:
                let msg = ["titulo": "Atención", "cuerpo": "Favor de escribir un monto mayor a 0.0"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            }
        }
    }
    
}
