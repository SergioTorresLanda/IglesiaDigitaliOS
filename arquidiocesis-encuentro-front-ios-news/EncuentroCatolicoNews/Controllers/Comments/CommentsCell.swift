//
//  CommentsCell.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 19/11/21.
//

import Foundation
import UIKit

protocol CommentsCellDelegate{
    func btnsActions(strBtnSelected: String, indx: Int, snder: UIButton)
}

protocol CommentsEditDelegate {
    func editPost3(id: Int, snder: UIButton)
}
public class CommentsCell: UITableViewCell, CustomPopOverDelegate{
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var customLabel: CustomLabel!
    
    @IBOutlet weak var lblSecondDate: UILabel!
    
    @IBOutlet weak var btnOracion: UIButton!
    
    @IBOutlet weak var btnResponder: UIButton!
    @IBOutlet weak var lblNumLikes: UILabel!
    
    @IBOutlet weak var imgvProfile: UIImageView!
    
    @IBOutlet weak var ctnView: NSLayoutConstraint!
    @IBOutlet weak var btnMoreActions: UIButton!
    
    var delegateComment: CommentsCellDelegate?
    var btnsender: UIButton!
    var customPopOver: CustomPopOverView!
   // var delegateEdit: FeedTVCProtocol?
   // var delegateEdit: CommentsProtocols?
    var delegateEdit: CommentsEditDelegate?
    
    override public func awakeFromNib(){
        super.awakeFromNib()
        btnOracion.setTitle("", for: .normal)
        let attributedText = NSAttributedString(string: "Responder", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 12) ?? UIFont()])
        btnResponder.setAttributedTitle(attributedText, for: .normal)
    }
    
    func setupData(id: Int, strName: String, strComment: String, stDate: String, strSecondDate: String, imgName: String, reaction: Int, likes: Int){
        lblName.text = strName
        customLabel.text = strComment
        lblSecondDate.text = strSecondDate
        lblDate.text = stDate
        imgvProfile.setImage(name: imgName, image: nil)
        lblNumLikes.text = "\(likes)"
        
        let stNameLike = reaction == 1 ? "iconOracion2" : "iconOracion"
        
        btnOracion.setImage(UIImage(named: stNameLike, in: Bundle.local, compatibleWith: nil), for: .normal)
        
        btnMoreActions.isHidden = id == UserDefaults.standard.integer(forKey: "SNId")
    }
    
    func setUpNewData(commnts: CmComments?){
        if let communityName = commnts?.scope?.name {
            lblName.text = communityName

        }else{
            lblName.text = commnts?.author?.name

        }
        customLabel.text = commnts?.content
        let iDate = commnts?.createdAt
        let  stDate = "\(iDate ?? 0)"
        lblSecondDate.text = "\(Date(timeIntervalSince1970: TimeInterval(stDate) ?? 0.0).formatRelativeString())"
        lblDate.isHidden = true
        imgvProfile.setImage(name: commnts?.author?.image, image: nil)
    }
    
    
    @IBAction func btnActionLike(_ sender: UIButton) {
        delegateComment?.btnsActions(strBtnSelected: "Like", indx: btnOracion.tag, snder: self.btnMoreActions)
    }
    
    @IBAction func btnActionResponder(_ sender: UIButton) {
        delegateComment?.btnsActions(strBtnSelected: "Responder", indx: btnResponder.tag, snder: self.btnMoreActions)
    }
    
    
    @IBAction func moreActions(_ sender: UIButton) {
        btnsender = sender
        customPopOver = CustomPopOverView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: 70.0, height: 60)))
        customPopOver.table.optionSelectDelegate = self
        customPopOver.showPopover(sourceView: sender)
        
    }
    
    func selectedOption(select: String) {
        switch select{
        case "Editar":
            customPopOver.dismissPopover(animated: true, completion: {
                // GGG1
              //  self.delegateEdit?.editPost3(id: self.btnMoreActions.tag, snder: self.btnsender)
                self.delegateComment?.btnsActions(strBtnSelected: "Editar", indx: self.btnMoreActions.tag, snder: self.btnsender)
                
            })
        case "Eliminar", "Denunciar":
            customPopOver.dismissPopover(animated: true, completion: {
               // self.delegateEdit?.editPost3(id: self.btnMoreActions.tag, snder: self.btnsender)
                self.delegateComment?.btnsActions(strBtnSelected: "Eliminar", indx: self.btnMoreActions.tag, snder: self.btnsender)
            })
        default:
            break
        }
    }
    
}
