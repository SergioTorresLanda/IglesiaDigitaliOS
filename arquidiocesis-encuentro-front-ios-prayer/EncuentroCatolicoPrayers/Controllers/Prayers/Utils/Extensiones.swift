//
//  Extensiones.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 01/03/21.
//


import Foundation
import UIKit


extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImage.RenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }

    func rightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
}


extension  UIViewController {

    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(ok)
        //alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension UIImageView {
    public func imageFromURL(urlString: String) {

        let activityIndicator = UIActivityIndicatorView(style: .gray)
           activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
           activityIndicator.startAnimating()
           if self.image == nil{
               self.addSubview(activityIndicator)
           }

           URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
               
               //print("->  respuesta Status Code: ", response as Any)
               //print("->  error: ", error as Any)
              

               if error != nil {
                   print(error ?? "No Error")
                   return
               }
               DispatchQueue.main.async(execute: { () -> Void in
                   let image = UIImage(data: data!)
                   activityIndicator.removeFromSuperview()
                   self.image = image
               })

           }).resume()
       }
}

extension UIImage {

func downloadImage(url: String) -> UIImage? {
    let url = URL(string: url) ?? URL(string: "")
    if let data = try?  Data(contentsOf: url!){
        guard let image: UIImage = UIImage(data: data) else { return nil }
       return image
    }
    return nil
}
}

extension String {
    public func prepareForPrayer(strToChange: String) -> String {
        var strToChange = strToChange
        let finalString: String
        strToChange = strToChange.replacingOccurrences(of: ". ", with: ".\n")
        strToChange = strToChange.replacingOccurrences(of: ", ", with: ",\n")
        strToChange = strToChange.replacingOccurrences(of: ": ", with: ":\n")
        strToChange = strToChange.replacingOccurrences(of: "; ", with: ";\n")
        finalString = strToChange
        return finalString
    }
}
