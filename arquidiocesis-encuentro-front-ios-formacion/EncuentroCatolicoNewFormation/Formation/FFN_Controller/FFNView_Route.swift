//
//  FFNView_Route.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit

open class FFNView_Route {
    
    public static func createView(url: String) -> UIViewController {
        let ffn_vc = FFNView_Controller()
        ffn_vc.url = url
        return ffn_vc
    }
    
}
