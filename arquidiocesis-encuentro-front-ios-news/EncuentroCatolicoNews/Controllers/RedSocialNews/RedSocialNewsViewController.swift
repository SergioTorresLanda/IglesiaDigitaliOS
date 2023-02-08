//
//  redSocialNewsViewController.swift
//  EncuentroCatolicoNews
//
//  Created by Luis Angel on 11/01/23.
//

import UIKit
import EncuentroCatolicoLive
import EncuentroCatolicoProfile
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoPrayers
//import EncuentroCatolicoHome
import Foundation
import EncuentroCatolicoNewFormation
import SwiftUI


class RedSocialNewsViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //outletss
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var titulo: UILabel!
   
    @IBOutlet weak var redUrl: UILabel!
    @IBOutlet weak var desc: CustomLabel!
    @IBOutlet weak var imagen: UIImageView!
    
    @IBOutlet weak var globalCV: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //variables globales
    var id = ""
    var post:Posts?
    var url: CustomLabelType = .url
    var arrImages:[String]=[]
    var urlG="https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012"
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        id=" ya "
        desc.delegate = self
        print(String(post!.content!))
        
        globalCV.dataSource = self
        globalCV.delegate = self
        globalCV.register(UINib(nibName: "SliderCell2", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD2")
        globalCV.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //llamadas a base de datos
        print("la vista esta apunto de aparecer")
        titulo.text = post?.author?.name
        desc.text = post?.content
       
        let iDate = post?.createdAt
        let strDate = "\(iDate ?? 0)"
        fecha.text = Date(timeIntervalSince1970: TimeInterval(strDate) ?? 0.0).formatRelativeString()
        if post?.multimedia! == nil{
            print("multimedia::::empty")
        }else{
            if !post!.multimedia!.isEmpty{
                for media in post!.multimedia! {
                    switch media.format {
                    case "jpeg", "png", "image/jpeg":
                        let url = media.url ?? ""
                        arrImages.append(url)
                    default:
                        print("no format available")
                    }
                }
                globalCV.reloadData()
                pageControl.numberOfPages = arrImages.count
            }else{
                arrImages.append(urlG)
                globalCV.reloadData()
                pageControl.numberOfPages = arrImages.count
            }
        }
        
    }

    override func viewDidLayoutSubviews() {
        print("los elementos de la vista ya se cargaron y se les dio sus constraints y diseño (ideal para formato de botomes textos etc..)")
        //backbtn.setBorder(borderColor: )
        
    }
    
    @IBAction func backBtnClick(_ sender: Any) {
        print("click back")
        navigationController?.popViewController(animated: true)
    }
    ///collection view
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / globalCV.frame.width)

    }
    // MARK: COLLECTION VEWI DELEGATE & DATA SOURCE -
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrImages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCOLSD2", for: indexPath) as! SliderCollectionCell2
            cell.imgCustom2.layer.cornerRadius = 10
            
            if indexPath.row >= arrImages.startIndex && indexPath.row < arrImages.endIndex {
                cell.imgCustom2.loadS(urlS: arrImages[indexPath.item])
                
            }
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            print("&&&", indexPath.item)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: globalCV.frame.width, height: globalCV.frame.height + 30)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 0.0
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            
            return 0.0
        }
    
    
}

extension RedSocialNewsViewController: CustomLabelDelegate {
    public func didSelect(_ text: String, type: CustomLabelType) {
        print("aqui esta el link 2 \(text)")
        if let url = URL(string: text) {
                  UIApplication.shared.open(url)
               }
    }
}


extension UIImageView {
    
    func loadS(urlS: String) {
        guard let url = URL(string:urlS)else{
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        //imageCache.setObject(image, forKey: urlS as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

