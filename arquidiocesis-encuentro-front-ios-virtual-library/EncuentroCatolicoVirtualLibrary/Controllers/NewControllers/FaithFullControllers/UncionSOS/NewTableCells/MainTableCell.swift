//
//  MainTableCell.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/09/21.
//

import UIKit

protocol CollectionCellDelegate2: AnyObject {
    func selectedItem2()
}

protocol CollectionCellDelegate: class {
    func selectedItem(type: String, tel: String)
}

class MainTableCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nestedcollection: UICollectionView!
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    
    var list : ListChurches?
    var isSupportContact = true
    var arraySubList : [String] = []
    var arrayFlags : [Bool] = []
    weak var delegate2: CollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(listC: ListChurches) {
        list = listC
        arraySubList.removeAll()
        arrayFlags.removeAll()
        if list?.support_contacts.count != 0 {
            list?.support_contacts.forEach({ contact in
                arraySubList.append(contact.name ?? "unspecified")
                arrayFlags.append(true)
            })
        }
        arrayFlags.append(false)
        arraySubList.append(list?.name ?? "")
       
        nestedcollection.register(UINib(nibName: "NestedCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLXIB")
        nestedcollection.register(UINib(nibName: "ContactoCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCONTACT2")
        nestedcollection.delegate = self
        nestedcollection.dataSource = self
        nestedcollection.reloadData()
        nestedcollection.isScrollEnabled = false
        let height = nestedcollection.collectionViewLayout.collectionViewContentSize.height
        heightCollection.constant = height + 60
        self.layoutIfNeeded()
        
    }

}

extension MainTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySubList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if arrayFlags[indexPath.item] == false {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLXIB", for: indexPath) as! NestedCollectionCell
            cell.lbl.text = list?.name
            let distance = list?.distance ?? 0
            print(distance)
            cell.lbllDistance.text = "\(distance / 1000) km"
            print(distance / 1000)
            cell.churchImg.layer.cornerRadius = 10
            cell.churchImg.clipsToBounds = true
            cell.churchImg.DownloadStaticImage(list?.image_url ?? "")
            
            return cell
            
        }else{
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCONTACT2", for: indexPath) as! ContactoCell
            cell.lblNameContact.text = arraySubList[indexPath.item]//list?.support_contacts[indexPath.item].name
            
            return cell
            
        }
                
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: nestedcollection.bounds.width, height: 74)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let singleton = UncionSOSView.singleton
        
        print(indexPath.row, arraySubList.count)
        if indexPath.row + 1 != arraySubList.count {
            singleton.contactID = list?.support_contacts[indexPath.item].id ?? 0
            delegate2?.selectedItem(type: "CONTACT", tel: "")
        }else{
            print("es una iglesia")
            delegate2?.selectedItem(type: "CHURCH", tel: list?.phone ?? "")
        }
        
    }
    
}
