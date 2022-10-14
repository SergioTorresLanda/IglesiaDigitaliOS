//
//  DonationCustomAnnotation.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 15/03/22.
//

import UIKit
public class DontaionCustomAnnotation: UIView {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var backgorundView: UIView!
    @IBOutlet weak var imgChurch: UIImageView!
    @IBOutlet weak var lblChurchName: UILabel!
    @IBOutlet weak var lblSelection: UILabel!
    @IBOutlet weak var btnAnnotation: UIButton!
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override init(frame: CGRect) {
        super.init(frame: frame)
       // nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // nibSetup()
    }
}
