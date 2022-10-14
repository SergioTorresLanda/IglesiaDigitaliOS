//
//  educationCVC.swift
//  EncuentroCatolicoHome
//
//  Created by Desarrollo on 25/03/21.
//

import UIKit

class featuredEducationCVC: UICollectionViewCell {
    
    @IBOutlet weak var collection   : UICollectionView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "featuredCell", bundle: Bundle.local), forCellWithReuseIdentifier: "cell")
    }
}

extension featuredEducationCVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! featuredCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: screenSize.width - 30 , height: 137)
    }
}
