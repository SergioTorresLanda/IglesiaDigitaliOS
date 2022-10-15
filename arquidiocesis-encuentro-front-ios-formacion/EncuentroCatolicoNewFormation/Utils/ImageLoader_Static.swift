//
//  ImageLoader_Static.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 07/05/21.
//

import UIKit

class ImageLoader: UIImageView {
    
    let imageCache = NSCache<AnyObject, AnyObject>()

    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()
    

    func loadImageWithUrl(_ url: URL) {

        // setup activityIndicator...
        activityIndicator.color = .darkGray

        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        imageURL = url

        image = nil
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url.absoluteURL as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        // image does not available in cache.. so retrieving it from url...
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)
            if error != nil {
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }

            DispatchQueue.main.async(execute: {

                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {

                    if self.imageURL == url {
                        self.image = imageToCache
                    }

                    self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
