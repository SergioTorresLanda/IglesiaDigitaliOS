import Foundation
import EncuentroCatolicoPayment

class DonativoInteractor: DonativoInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: DonativoInteractorOutputProtocol?
    var localDatamanager: DonativoLocalDataManagerInputProtocol?
    var remoteDatamanager: DonativoRemoteDataManagerInputProtocol?
    
    func realizarDonativo(titular: String, numeroTarjeta: String, debito: Bool, fecha: String, cvv: String, cantidad: String) {
        if titular.trimmingCharacters(in: .whitespaces) == "" || numeroTarjeta.trimmingCharacters(in: .whitespaces) == "" || fecha.trimmingCharacters(in: .whitespaces) == "" || cvv.trimmingCharacters(in: .whitespaces) == "" || cantidad.trimmingCharacters(in: .whitespaces) == "" {
            presenter?.callbackPago(errores: ErroresDonativo.DatosVacios)
        } else {
            if numeroTarjeta.count != 16 {
                presenter?.callbackPago(errores: ErroresDonativo.tarjetaIncorrecta)
                return
            }
            if cvv.count != 3 {
                presenter?.callbackPago(errores: ErroresDonativo.cvvIncorrecto)
                return
            }
            
            let dCantidad: Double = Double(cantidad) ?? 0.0
            
            if dCantidad == 0.0 {
                presenter?.callbackPago(errores: ErroresDonativo.cantidadIncorrecta)
                return
            }
            
            var zeus_payment: ZeusPayment?
            
            zeus_payment = ZeusPayment(delegate: self)
            
            let fechaSinDigitos = fecha.replacingOccurrences(of: "/", with: "")
            
            zeus_payment?.makeTransferWith(
                isCreditCard: debito,
                monto: dCantidad,
                cta_retiro: numeroTarjeta,
                cta_deposito: "5512382328764230",
                validity_date: fechaSinDigitos,
                cvv: cvv
            )
            
        }
    }

}

extension DonativoInteractor: ZeusPaymentDelegate {
    
    func didFinishWith(error: String) {
        presenter?.callbackPago(errores: ErroresDonativo.ErrorServidor)
    }
    
    func didFinishSuccess() {
        presenter?.callbackPago(errores: ErroresDonativo.OK)
    }
    
}

extension DonativoInteractor: DonativoRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
