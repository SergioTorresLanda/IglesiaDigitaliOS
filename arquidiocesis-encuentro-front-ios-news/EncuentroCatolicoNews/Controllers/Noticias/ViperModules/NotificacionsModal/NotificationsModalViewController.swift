//
//  NotificationsModalViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Consultor on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import LetterAvatarKit

public protocol NotificationsModalDelegate: class {
    func deletedNotification(index: Int)
}

public class NotificationsModalViewController: UIViewController, NotificationsModalViewProtocol {

    public weak var delegate: NotificationsModalDelegate?
    
    var presenter: NotificationsModalPresenterProtocol?
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var viewPanIndicator: UIView!
    @IBOutlet public weak var userImage: UIImageView!
    @IBOutlet public weak var notificationLabel: UILabel!
    @IBOutlet public weak var btnDeleteNotification: UIButton!
    
    //MARK: - Properties
    public var document: NotificationDocument?
    public var user = Int()
    public var index = Int()

    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    //MARK: - Methods
    private func setUpView() {
        viewPanIndicator.setCorner(cornerRadius: 2)
        
        let nameString = document?.autor.name != nil ? document?.autor.name ?? "" : document?.group.name ?? ""
        userImage.image = LetterAvatarMaker()
            .build { c in
                c.circle = true
                c.username = nameString.twoWords
                c.borderWidth = 1.0
                c.backgroundColors = [ UIColor(red: 132/255, green: 132/255, blue: 132/255, alpha: 1.00) ]
        }
        
        let myAttributeName = [ NSAttributedString.Key.font: UIFont(name: "Avenir-Black", size: 15)! ]
        let myAttrStringName = NSAttributedString(string: nameString + " ", attributes: myAttributeName)
        
        let messageString = document?.message ?? ""
        let myAttributeMessage = [ NSAttributedString.Key.font: UIFont(name: "Avenir-Book", size: 15)! ]
        let myAttrStringMessage = NSAttributedString(string: messageString, attributes: myAttributeMessage)
        
        let combination = NSMutableAttributedString()
        combination.append(myAttrStringName)
        combination.append(myAttrStringMessage)
        
        notificationLabel.attributedText = combination
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        guard let documentId = document?.documentID else { return }
        deleteNotification(documentId: documentId, user: user, index: index)
    }
    
    func deleteNotification(documentId: String, user: Int, index: Int) {
        /*guard let firebase_instance = SocialNetworkConstant.shared.instance else {
            debugPrint("ProspectosInteractor error: firebase instance was nil.")
            return
        }
        
        guard let documentId = document?.documentID else { return }
        let fireStore = Firestore.firestore(app: firebase_instance)
        fireStore.collection("user")
            .document(String(user))
            .collection("notifications")
            .document(documentId)
            .delete() { error in
                if error == nil {
                    self.delegate?.deletedNotification(index: index)
                    self.dismiss(animated: true, completion: nil)
                }
        }*/
    }
}
