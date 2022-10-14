//
//  mentorsViewCVC.swift
//  EncuentroCatolicoHome
//
//  Created by Desarrollo on 25/03/21.
//

import UIKit

class mentorsViewCVC: UICollectionViewCell {
    
    @IBOutlet weak var collection: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "mentorsCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "cell")
    }

}

extension mentorsViewCVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! mentorsCVC
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}
