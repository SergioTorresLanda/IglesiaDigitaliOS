//
//  UncionTableCell.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class UncionTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var widthCollection: NSLayoutConstraint!
    @IBOutlet weak var tableCollection: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardView: UIView!
    var dataArray : ListChurches?
    weak var delegate: CollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCollectionViewDataSourceDelegate(forRow row: Int, dataModel: [ListChurches], isFirstLoad: Bool) {
        
        dataArray = dataModel[row]
        tableCollection.delegate = self
        tableCollection.dataSource = self
        tableCollection.tag = row
        tableCollection.setContentOffset(tableCollection.contentOffset, animated: false)
        tableCollection.backgroundColor = .clear
        tableCollection.isScrollEnabled = false
        let height = self.tableCollection.collectionViewLayout.collectionViewContentSize.height
        self.heightConstraint.constant = height
        self.layoutIfNeeded()
       // tableCollection.reloadData()
        
    }
    
    func reloadHeight() {
        let height = self.tableCollection.collectionViewLayout.collectionViewContentSize.height
        self.heightConstraint.constant = height
        self.layoutIfNeeded()
        tableCollection.reloadData()
        print("Entro el reloag height")
    }

    var collectionViewOffset: CGFloat {
        set { tableCollection.contentOffset.y = newValue }
        get { return tableCollection.contentOffset.y }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        let count = 1 + dataArray!.support_contacts.count
        return  count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if dataArray?.support_contacts.count == 0 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "UCHCH", for: indexPath) as! UncionCellChurch
            cell2.backgroundColor = .clear
            
            cell2.lblChurchName.text = dataArray?.name
            cell2.lineaChurchSection.alpha = 0
            cell2.churchImg.downloaded(from: dataArray?.image_url ?? "nil")
            if dataArray?.distance != nil {
                if dataArray != nil {
                    cell2.lblDistanceChurch.text = "\(dataArray!.distance! / 1000)km"
                }
               
            }
            print("Aqui esta la distance: ",(dataArray?.distance)!  / 1000)
            let height = self.tableCollection.collectionViewLayout.collectionViewContentSize.height
            self.heightConstraint.constant = height
            self.layoutIfNeeded()
                        
            return cell2
                        
        }else{
            if indexPath.item == 1 {
                let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "UCHCH", for: indexPath) as! UncionCellChurch
                cell2.backgroundColor = .clear
                
                cell2.lblChurchName.text = dataArray?.name
                cell2.lineaChurchSection.alpha = 0
                cell2.churchImg.downloaded(from: dataArray?.image_url ?? "nil")
                if dataArray?.distance != nil {
                    if dataArray != nil {
                        cell2.lblDistanceChurch.text = "\(dataArray!.distance! / 1000)km"
                    }
                   
                }
                print("Aqui esta la distance: ",(dataArray?.distance)!  / 1000)
               
                let height = self.tableCollection.collectionViewLayout.collectionViewContentSize.height
                self.heightConstraint.constant = height
                self.layoutIfNeeded()
                return cell2
                
            }else{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UCH", for: indexPath) as! UnionCellHelp
                cell.backgroundColor = .clear
                cell.lblNameContact.text = dataArray?.support_contacts[0].name
                let height = self.tableCollection.collectionViewLayout.collectionViewContentSize.height
                self.heightConstraint.constant = height
                self.layoutIfNeeded()
                
                return cell
                
            }
        }
               
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        let singleton = UncionSOSView.singleton
        if dataArray?.support_contacts.count != 0 {
            print(dataArray?.support_contacts[0].id ?? 0)
            singleton.contactID = dataArray?.support_contacts[0].id ?? 0
        }else{
            singleton.contactID = 317
            print("No hay id de contacto")
        }
        
        //self.delegate?.selectedItem()
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = CGSize(width: 340, height: 100)
        return size

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
