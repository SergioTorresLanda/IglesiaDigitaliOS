//
//  HomeSliderCell.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 20/08/21.
//

import UIKit

class HomeSliderCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

// MARK: @IBOUTLETS -
    @IBOutlet weak var subCardView: UIView!
    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var globalCV: UICollectionView!
    @IBOutlet weak var pagesControl: UIPageControl!
    
    var delegate:YourCellDelegate!
    
    var allData: [HomeSuggestions] = []
    var allData2: [HomePosts] = []
    var disc=0
    var imgDef="https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(":::::::::SLIDER AWAKEE:::::::")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupSlider(data: [HomeSuggestions]) {
        print(":::::::::SLIDER:::::::")
        disc=0
        lblTitle.text=" ESPIRITUALIDAD "
        allData = data
        pagesControl.numberOfPages = data.count
        globalCV.dataSource = self
        globalCV.delegate = self
        globalCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
        globalCV.reloadData()
    }
    
    func setupSlider2(data: [HomePosts]) {
        print(":::::::::SLIDER 2:::::::")
        disc=2
        lblTitle.text=" NOTICIAS "
        allData2 = data
        pagesControl.numberOfPages = data.count
        globalCV.dataSource = self
        globalCV.delegate = self
        globalCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
        globalCV.reloadData()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pagesControl.currentPage = Int(x / globalCV.frame.width)

    }

    @objc func suggestionAction(sender: UIButton) {
        if disc==0{
            delegate.didPressButton(sender.tag, type: allData[sender.tag].type ?? "", library: allData[sender.tag].category ?? "", url: allData[sender.tag].article_url ?? "", id: allData[sender.tag].id ?? 1, title: allData[sender.tag].title ?? "")
        }
    }
    
    @objc func postAction(sender: UIButton) {
        if disc==2{
            delegate.didPressButtonPost(url: allData2[sender.tag].publish_url ?? "Unspecified")
        }
    }
    
// MARK: COLLECTION VEWI DELEGATE & DATA SOURCE -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num=0
        switch disc {
        case 0:
            print("espiritualidad noris")
            num=allData.count
        case 2:
            print("noticias noris")
            num=allData2.count
        default:
            break
        }
        print(String(num))
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCOLSD", for: indexPath) as! SliderCollectionCell
        cell.imgCustom.layer.cornerRadius = 10
        cell.lblCustom.adjustsFontSizeToFitWidth = true
        switch disc {
        case 0:
            print("espirit c4r@")
            print(String(allData.count))
            if indexPath.row >= allData.startIndex && indexPath.row < allData.endIndex {
                let type = allData[indexPath.item].type
                switch type {
                    case "VIDEO":
                        let url = allData[indexPath.item].article_url
                        if url!.contains("youtube"){
                            cell.imgCustom.loadS(urlS:url!.getYouTubeThubnailFromURL())
                        }else{
                            cell.imgCustom.loadS(urlS: allData[indexPath.item].image_url ?? imgDef)
                        }
                case "FILE","PDF":
                    cell.imgCustom.image=UIImage(named: "pdf2",in: Bundle(for: HomeSliderCell.self), compatibleWith: nil)
                    cell.imgCustom.contentMode = .scaleAspectFit
                default :
                    let imgS = allData[indexPath.item].image_url
                    if imgS == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_link.png"{
                        cell.imgCustom.image=UIImage(named: "arqui",in: Bundle(for: HomeSliderCell.self), compatibleWith: nil)
                        cell.imgCustom.contentMode = .scaleAspectFit
                    }else{
                        cell.imgCustom.loadS(urlS: imgS ?? imgDef)
                    }
                }
            cell.lblCustom.text = allData[indexPath.item].title ?? ""
            cell.btnCell.addTarget(self, action: #selector(suggestionAction), for: .touchUpInside)
            cell.btnCell.tag = indexPath.item
            }
        case 2:
            print("noticias c4r@")
            print(String(allData2.count))
            if indexPath.row >= allData2.startIndex && indexPath.row < allData2.endIndex {
                print("IMAGE URLL")
            let imgS = allData2[indexPath.item].image_url
                if imgS == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_link.png"{
                    cell.imgCustom.image=UIImage(named: "arqui",in: Bundle(for: HomeSliderCell.self), compatibleWith: nil)
                    cell.imgCustom.contentMode = .scaleAspectFit
                }else{
                    cell.imgCustom.loadS(urlS: imgS ?? imgDef)
                }
            cell.lblCustom.text = allData2[indexPath.item].title ?? ""
            cell.btnCell.addTarget(self, action: #selector(postAction), for: .touchUpInside)
                cell.btnCell.tag = indexPath.item
                
            }
        default:
                print("IMPOSIBLE")
            break
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

/*func setupSlider3(data: [HomeSaintOfDay]) {
    print(":::::::::SLIDER 3:::::::")
    disc=3
    lblTitle.text=" SANTO DEL DÍA "
    allData3 = data
    //pagesControl.isHidden=true
    pagesControl.numberOfPages = data.count
    globalCV.dataSource = self
    globalCV.delegate = self
    globalCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
    globalCV.reloadData()
}*/
