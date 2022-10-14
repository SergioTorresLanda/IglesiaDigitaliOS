import Foundation

struct FechaLimite {
    let mes: [String]
    let anio: [String]
}

enum ErroresDonativo: Error {
    case OK
    case DatosVacios
    case tarjetaIncorrecta
    case cvvIncorrecto
    case cantidadIncorrecta
    case ErrorServidor
}

enum ErroresServerDonativo: Error {
    case ErrorInterno
    case ErrorServidor
}
