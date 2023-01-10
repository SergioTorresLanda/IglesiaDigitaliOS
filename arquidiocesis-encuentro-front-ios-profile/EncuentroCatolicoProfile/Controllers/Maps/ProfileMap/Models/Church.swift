//
//  Church.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 03/10/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public struct Church: Codable {
    var id: UInt
    var image_url: String?
    var name: String
    var distanceInKm: Double?
    var fullAddress: String?
    var description: String?
    var services: Array<ChurchService>?
    var lattitude: Double
    var longitud: Double
    
    func isFavourite() -> Bool {
        let favourites: Array<UInt> = (UserDefaults.standard.array(forKey: UserDefaultConstants.FavouritesChurches) as? Array<UInt>) ?? Array()
        
        return favourites.contains(id)
    }
    
    func isMain() -> Bool {
        if let savedId = UserDefaults.standard.string(forKey: UserDefaultConstants.MainChurch),
            let integerId = Int(savedId) {
            return id == integerId
        } else {
            return false
        }
    }
    
    static func getChurch(id: UInt, completion: @escaping (LocationResponse?) -> Void) {
        DummyData.shared.getChurchesData {
            churches in
            completion(churches.first(where: {$0.id == id}))
        }
    }
    
    static func getMapItemChurches(completion: @escaping (Array<ChuckMark>) -> Void) {
        DummyData.shared.getChurchesData {
            churches in
            let markItems = churches.map({ChuckMark(title: $0.name,
                                                    coordinate: CLLocationCoordinate2D(latitude: $0.latitude ?? 0.0,
                                                                                       longitude: $0.longitude ?? 0.0),
                                                    id: $0.id ?? 0, url: $0.image_url ?? "", subtitle: String($0.id ?? 0))})
            completion(markItems)
        }
    }
    
    static func getMapItemComs(completion: @escaping (Array<ChuckMark>) -> Void) {
        DummyData.shared.getComsData {
            churches in
            let markItems = churches.map({ChuckMark(title: $0.name,
                                                    coordinate: CLLocationCoordinate2D(latitude: $0.latitude ?? 0.0,
                                                                                       longitude: $0.longitude ?? 0.0),
                                                    id: $0.id ?? 0, url: $0.image_url ?? "", subtitle: String($0.id ?? 0))})
            completion(markItems)
        }
    }
    
    static func getFavouriteChurches(completion: @escaping (Array<LocationResponse>) -> Void) {
//        DummyData.shared.getChurchesData {
//            churches in
//            let favourite = churches.filter({$0.isFavourite()})
//            completion(favourite)
//        }
    }
    
    static func getNearByChurches(completion: @escaping (Array<LocationResponse>) -> Void) {
        DummyData.shared.getChurchesData {
            churches in
            let nearbyChurches = churches//.filter({($0.distanceInKm ?? 0) < 10000})
            completion(nearbyChurches)
        }
    }
    
    static func getMyChurch(completion: @escaping (LocationResponse?) -> Void) {
        if let mainChurchId = UserDefaults.standard.string(forKey: UserDefaultConstants.MainChurch),
           let id = Int(mainChurchId) {
            DummyData.shared.getChurchesData {
                churches in
                let myChurch = churches.first(where: {$0.id ?? 0 == id})
                completion(myChurch)
            }
        } else {
            completion(nil)
        }
    }
    
    func makeMain() {
        UserDefaults.standard.set(id.description, forKey: UserDefaultConstants.MainChurch)
    }
    
    func favourite(_ favourite: Bool) {
        var favourites: [UInt] = (UserDefaults.standard.array(forKey: UserDefaultConstants.FavouritesChurches) as? [UInt]) ?? [UInt]()
        if favourite {
            favourites.append(id)
        } else {
            favourites.removeAll(where: {$0 == id})
        }
        UserDefaults.standard.set(favourites, forKey: UserDefaultConstants.FavouritesChurches)
    }
}


extension Church {
    static let chuch_dummy_1 = Church(id: 0,
                                      image_url: "https://lh3.googleusercontent.com/p/AF1QipMXdP6iIWq6Ge5ZjfRma72MiOPROG3jhsEW7q_u=w600-k",
                                      name: "Parroquia del Señor de la Resurrección",
                                      distanceInKm: 2.5,
                                      fullAddress: "Bosques de la Reforma 486,\nBosques de las Lomas, Miguel Hidalgo, 11700,\nCiudad de México, CDMX",
                                      description: "Somos una comunidad parroquial católica en el sur de la CDMX, buscamos llevar el Evangelio y sus valores en nuestros ambientes.",
                                      services: [ChurchService.service_1,
                                                 ChurchService.service_3,
                                                 ChurchService.service_5,
                                                 ChurchService.service_7],
                                      lattitude: 19.4076975,
                                      longitud: -99.2423666)

    static let chuch_dummy_2 = Church(id: 1,
                                      image_url: "https://desdelafe.mx/wp-content/uploads/2019/06/Iglesia-Esperanza-de-Mar%C3%ADa-en-la-Resurrecci%C3%B3n-del-Se%C3%B1or.jpg",
                                      name: "Parroquia de La Esperanza de María en la Resurrección del Señor",
                                      distanceInKm: 2.5,
                                      fullAddress: "Calle Alborada 430, Parques del Pedregal, Tlalpan, 14010 Ciudad de México, CDMX",
                                      description: "Somos una comunidad parroquial católica en el sur de la CDMX, buscamos llevar el Evangelio y sus valores en nuestros ambientes.",
                                      services: [ChurchService.service_1,
                                               ChurchService.service_6,
                                               ChurchService.service_9,
                                               ChurchService.service_10,
                                               ChurchService.service_11,
                                               ChurchService.service_13,
                                               ChurchService.service_14],
                                      lattitude: 19.300944,
                                      longitud: -99.193722)

    static let chuch_dummy_3 = Church(id: 2,
                                      image_url: "https://live.staticflickr.com/2641/4207883302_a5e7ed3d5c_b.jpg",
                                      name: "Parroquia Cristo Rey de La Paz",
                                      distanceInKm: 2.5,
                                      fullAddress: "Parque del Pedregal, Miguel Hidalgo Villa Olímpica, Tlalpan, 14010 Tlalpan, CDMX",
                                      description: "La Parroquia se construyó como parte de los servicios que se ofrecieron a los atletas que participaron en las Olimpiadas de 1968. La parroquia es considerada como el elemento más distintivo de la Villa Olímpica.",
                                      services: [ChurchService.service_7],
                                      lattitude: 19.297694,
                                      longitud: -99.189833)

    static let chuch_dummy_4 = Church(id: 3,
                                      image_url: "https://4.bp.blogspot.com/-uapR0jN3e_c/Thvo5cS4F7I/AAAAAAAAAW4/kDzpPHyU3QI/s1600/Parroquia+.JPG",
                                      name: "Parroquia de San Pedro Apóstol",
                                      distanceInKm: 2.5,
                                      fullAddress: "San Pedro Apóstol 32, San Fernando, Tlalpan, 14070 Ciudad de México, CDMX",
                                      description: "En el No. 32 de la calle de San Pedro del Barrio de San Fernando se encuentra el Templo de San Pedro Apóstol. Fue construido en el siglo XVIII y ampliado durante el XIX. Cuenta con una imagen del Oratorio de Zacamilpa, la cual fue trasladada a este Templo en 1928 y un amplio atrio con una cruz decorada con los símbolos de la Pasión de Cristo",
                                      services: [ChurchService.service_2,
                                                 ChurchService.service_12,
                                                 ChurchService.service_1,
                                                 ChurchService.service_15,
                                                 ChurchService.service_16,
                                                 ChurchService.service_17,
                                                 ChurchService.service_18],
                                      lattitude: 19.295722,
                                      longitud: -99.176944)

    static let chuch_dummy_5 = Church(id: 4,
                                      image_url: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fsevilla.abc.es%2Fmedia%2Fsevilla%2F2016%2F06%2F14%2Fs%2Fsanta-cruz-robo-kARG--620x349%40abc.jpg&f=1&nofb=1",
                                      name: "Parroquia de la Santa Cruz",
                                      distanceInKm: 2.5,
                                      fullAddress: "Av. de Las Fuentes 580, Jardines del Pedregal, Álvaro Obregón, 01900 Ciudad de México, CDMX",
                                      description: "En el centro de la colonia Jardines del Pedregal se encuentra la Parroquia de la Santa Cruz, fundada por los Misioneros del Espíritu Santo en 1956. Se trata de un templo de estilo contemporáneo, de gran valor arquitectónico. La parroquia cuenta en su territorio con dos capillas -María Auxiliadora y Ntra. Sra. de Guadalupe (en Aculco)- y una librería.\n\nLa parroquia se caracteriza por la gran afluencia a las eucaristías, tanto diarias como dominicales. Cuenta con pastoral infantil y juvenil, Grupo Scout, grupos de adultos (Apostolado de la Cruz y Alianza de Amor), cursos de evangelización y una pastoral para separados y divorciados.",
                                      services: [ChurchService.service_7],
                                      lattitude: 19.316111,
                                      longitud: -99.212222)

    static let chuch_dummy_6 = Church(id: 5,
                                      image_url: "https://scontent.fmex10-2.fna.fbcdn.net/v/t1.0-9/57457076_2393991440650682_885008917925462016_o.jpg?_nc_cat=100&_nc_sid=6e5ad9&_nc_ohc=SUYj5HcB1LsAX8zH7NJ&_nc_ht=scontent.fmex10-2.fna&oh=31a1c31fb18e1be066ebb7c418b5deae&oe=5F9F1C6A",
                                      name: "Parroquia de Santa María de los Apóstoles",
                                      distanceInKm: 2.5,
                                      fullAddress: "Av. de Las Fuentes 580, Jardines del Pedregal, Álvaro Obregón, 01900 Ciudad de México, CDMX",
                                      description: "La construcción del Templo se inicio en 1967 y se inauguro en 1968. En noviembre de 1968 se bendice el Templo y se consagra como Capilla de Santa María de los Apóstoles, dependiente de la Parroquia de San Agustín de las Cuevas.\n\nEl 12 de Septiembre de 1982, se erigió como Parroquia y desde entonces ha tenido 3 párrocos: El Presbítero Joaquín Escalante Cortina de 1982 a 1998, el Presbítero Rodolfo Cerezo Barreto de 1998 a 2008 y a partir de Agosto de 2008 funge como párroco el Presbítero Guillermo Nava Arriaga.",
                                      services: [ChurchService.service_7,
                                                 ChurchService.service_19,
                                                 ChurchService.service_20],
                                      lattitude: 19.298528,
                                      longitud: -99.157472)

    static let chuch_dummy_7 = Church(id: 6,
                                      image_url: "https://live.staticflickr.com/3233/2934121177_4840bd5965_b.jpg",
                                      name: "Iglesia de Nuestra Señora de Covadonga",
                                      distanceInKm: 2.5,
                                      fullAddress: "Av. Paseo de las Palmas 406, Lomas - Virreyes, Lomas de Chapultepec, Miguel Hidalgo, 11000 Ciudad de México, CDMX",
                                      description: "La adoración a la Virgen de Covadonga se remonta a España donde se encuentra una escultura con la patrona de Asturias en una cueva ubicada en Covadonga. Se cuenta que la virgen ayudó a los cristianos que dirigía Don Pelayo en una batalla contra el ejército árabe. Dicho triunfo ayudó a reinstaurar a los reyes cristianos.\n\nLa iglesia ubicada en la alcaldía Miguel Hidalgo está en conmemoración de esa virgen",
                                      services: [ChurchService.service_7],
                                      lattitude: 19.429167,
                                      longitud: -99.211667)

    static let chuch_dummy_8 = Church(id: 7,
                                      image_url: "https://sites.google.com/a/defe.mx/www/_/rsrc/1397881211083/mexico-df/religion/parroquia-iglesia-santa-teresita/Parroquia%20Iglesia%20Santa%20Teresita%20Lomas.JPG?height=400&width=344",
                                      name: "Parroquia de Santa Teresita del Niño Jesús",
                                      distanceInKm: 2.5,
                                      fullAddress: "Sierra Nevada 750, Lomas de Chapultepec, Miguel Hidalgo, 11000 Ciudad de México, CDMX",
                                      description: "Nuestra Misión principal es anunciar la \"ale-gría de Evangelio\", como nos exhorta nuestro Papa Francisco, y compartir la rica experiencia y la profunda doctrina y espiritualidad de nuestro Padre San Agustín.",
                                      services: [ChurchService.service_7],
                                      lattitude: 19.422889,
                                      longitud: -99.218111)

    static let chuch_dummy_9 = Church(id: 8,
                                      image_url: "https://lh3.googleusercontent.com/p/AF1QipNDtoTr680xj7iDWY_cwpNRlznf_g8giwsG2aAW=w600-k",
                                      name: "Iglesia de Nuestra Señora del Socorro",
                                      distanceInKm: 2.5,
                                      fullAddress: "Prado Sur 340, Lomas - Virreyes, Lomas de Chapultepec IV Secc, Miguel Hidalgo, 11000 Ciudad de México, CDMX",
                                      description: "Iglesia Católica de la Orden Sacerdotal Agustina\n\nSomos una comunidad dispuesta al servicio y atención al pueblo de Dios",
                                      services: [ChurchService.service_1,
                                                 ChurchService.service_5,
                                                 ChurchService.service_12,
                                                 ChurchService.service_6,
                                                 ChurchService.service_2],
                                      lattitude: 19.422528,
                                      longitud: -99.206972)

    static let chuch_dummy_10 = Church(id: 9,
                                       image_url: "https://live.staticflickr.com/3168/2752606900_c3d3da2042_b.jpg",
                                       name: "Parroquia Francesa - Cristo Resucitado y Nuestra Señora de Lourdes",
                                       distanceInKm: 2.5,
                                       fullAddress: "Av. Horacio 1758, Chapultepec Morales, Polanco I Secc, Miguel Hidalgo, 11510 Ciudad de México, CDMX",
                                       description: "Los Hermanos de San Juan en la Parroquia Francesa atienden a toda la comunidad francófona de México así como la comunidad mexicana.",
                                       services: [ChurchService.service_1,
                                                  ChurchService.service_9,
                                                  ChurchService.service_15,
                                                  ChurchService.service_6,
                                                  ChurchService.service_2,
                                                  ChurchService.service_4],
                                       lattitude: 19.435222,
                                       longitud: -99.210278)

    static let chuch_dummy_11 = Church(id: 10,
                                       image_url: "https://lh3.googleusercontent.com/moP1QOjVpGVEg3bFlprIYF0-XSerPG7yGhRF_oltZGzDxtvCG4cAMmSmwIXLYhbEGtWAcL-p=w1080-h608-p-no-v0",
                                       name: "Parroquia de San Isidro Labrador",
                                       distanceInKm: 2.5,
                                       fullAddress: "Sierra Santa Rosa 150,Reforma Social, Ciudad de México, D.F., Reforma Social - San Isidro, 11650 México. Miguel Hidalgo, CDMX",
                                       description: "Parroquia de San Isidro Labrador ubicada en la colonia Reforma Social, en la delegación Miguel Hidalgo de la Ciudad de México antes Distrito Federal DF",
                                       services: [ChurchService.service_7],
                                       lattitude: 19.431056,
                                       longitud: -99.218056)

    static func getDummyChurches() -> Array<Church> {
        var churches: Array<Church> = Array()
        churches.append(Church.chuch_dummy_1)
        churches.append(Church.chuch_dummy_2)
        churches.append(Church.chuch_dummy_3)
        churches.append(Church.chuch_dummy_4)
        churches.append(Church.chuch_dummy_5)
        churches.append(Church.chuch_dummy_6)
        churches.append(Church.chuch_dummy_7)
        churches.append(Church.chuch_dummy_8)
        churches.append(Church.chuch_dummy_9)
        churches.append(Church.chuch_dummy_10)
        churches.append(Church.chuch_dummy_11)

        return churches
    }
}
