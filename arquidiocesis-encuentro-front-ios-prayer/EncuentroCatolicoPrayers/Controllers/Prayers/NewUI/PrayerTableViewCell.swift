//
//  PrayerTableViewCell.swift
//  TestPrayer
//
//  Created by Miguel Eduardo  Valdez Tellez  on 26/04/21.
//

import UIKit


protocol DelegateCellViewCollectionPrayers: NSObjectProtocol {
    func tapDetail(id: Int)
}

class PrayerTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var namePrayer: UILabel!
    @IBOutlet weak var imagePrayer: UIImageView!
    @IBOutlet weak var subPrayerCollection: UICollectionView!

    private var dataSource: [Devotion] = []
   
    weak var delegateCollectionPrayer: DelegateCellViewCollectionPrayers?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.subPrayerCollection.delegate = self
        self.subPrayerCollection.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(data: [Devotion]) {
        self.dataSource = data
       
    }

}

extension PrayerTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCell", for: indexPath) as! NamePrayerCollectionCell
        cell.subPrayerText.text = dataSource[indexPath.row].name
        cell.subPrayerText.adjustsFontSizeToFitWidth = true
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegateCollectionPrayer?.tapDetail(id: dataSource[indexPath.row].id ?? 0)
    }
    
    
}
