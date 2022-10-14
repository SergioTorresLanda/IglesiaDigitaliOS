//
//  UIImage+Utils.swift
//  Nomad
//
//  Created by Diego Luna on 08/07/20.
//
// swiftlint:disable variable_name

import UIKit

struct IconCatalog {
    let duotone: DuotoneIconCatalog = DuotoneIconCatalog()
    let general: GeneralIconCatalog = GeneralIconCatalog()
}

struct DuotoneIconCatalog {
    var search: UIImage { UIImage(named: "iconoBuscar") ?? UIImage() }
    var churchDefault: UIImage { UIImage(named: "iconoIglesia") ?? UIImage() }
}

struct GeneralIconCatalog {
}

extension UIImageView {
    func setImageColor(color: UIColor? = nil) {
        var templateImage: UIImage.RenderingMode
        color.isNull ? (templateImage = .automatic) : (templateImage = .alwaysTemplate)
        image = image?.withRenderingMode(templateImage)
        tintColor = color
    }
    
    func downloadImage(from url: URL, successRequest: @escaping (Bool) -> Void) {
        getData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                successRequest(false)
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
                successRequest(true)
            }
        }
    }
    
    func downloadReturnImage(from url: URL, successImage: @escaping (UIImage?) -> Void) -> BlockOperation {
        return BlockOperation { [weak self] in
            self?.getData(from: url) { data, _, error in
                guard let data = data, error == nil else {
                    successImage(nil)
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    guard !self.isNull else { return }
                    successImage(UIImage(data: data))
                }
            }
        }
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
