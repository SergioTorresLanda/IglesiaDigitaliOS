//
//  RedSocial_Perfil.swift
//  EncuentroCatolicoNews
//
//  Created by Sergio Torres Landa González on 09/02/23.
//

import UIKit

class RedSocial_Perfil: UIViewController {
    
    @IBOutlet weak var viewHead: UIView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var followV: UIView!
    @IBOutlet weak var followText: UILabel!
    @IBOutlet weak var iconFollow: UIImageView!
    
    @IBOutlet weak var publicV: UIView!
    @IBOutlet weak var numPublic: UILabel!
    @IBOutlet weak var publicLbl: UILabel!
    @IBOutlet weak var followersV: UIView!
    @IBOutlet weak var numFollowers: UILabel!
    @IBOutlet weak var followersLbl: UILabel!
    @IBOutlet weak var followedV: UIView!
    @IBOutlet weak var numFollowed: UILabel!
    @IBOutlet weak var followedLbl: UILabel!
    
    @IBOutlet weak var followTV: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var shimmerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClick(_ sender: Any) {
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
