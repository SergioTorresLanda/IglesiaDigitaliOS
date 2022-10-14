//
//  educationHome.swift
//  EncuentroCatolicoHome
//
//  Created by Desarrollo on 25/03/21.
//

import UIKit

class educationHome: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var courses: Array<Array<String>> = [["Catequesis", "Experiencias y apoyos para la catequesis"], ["Formación básica", "La fe explicada"], ["Formación básica 1", "Lo que creemos"], ["Teología", "Introducción a la teologia"], ["Sagrada escritura", "Introducción a la Sagrada escritura"], ["Formación básica", "La fe explicada"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "featuredEducationCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "featured")
        collection.register(UINib(nibName: "coursesHeader", bundle: Bundle.local), forCellWithReuseIdentifier: "coursesHeader")
        collection.register(UINib(nibName: "coursesCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "coursesCVC")
        collection.register(UINib(nibName: "mentorsViewCVC", bundle: Bundle.local), forCellWithReuseIdentifier: "mentors")
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension educationHome: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 + courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "featured", for: indexPath) as! featuredEducationCVC
            return cell
        case 1:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "coursesHeader", for: indexPath) as! coursesHeader
            return cell
        case 2 + courses.count:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "mentors", for: indexPath) as! mentorsViewCVC
            return cell
        default:
            let cell = collection.dequeueReusableCell(withReuseIdentifier: "coursesCVC", for: indexPath) as! coursesCVC
            cell.lblTitle.text = courses[indexPath.row - 2][0]
            cell.lblSubtitle.text = courses[indexPath.row - 2][1]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        switch indexPath.row {
        case 0:
            return CGSize(width: screenSize.width - 30 , height: 140)
        case 1:
            return CGSize(width: screenSize.width - 15 , height: 54)
        case 2 + courses.count:
            return CGSize(width: screenSize.width - 30 , height: 210)
        default:
            return CGSize(width: screenSize.width - 30 , height: 63)
        }
    }
}
