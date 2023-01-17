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
    var allData3: [HomeSaintOfDay] = []
    var disc=0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupSlider(data: [HomeSuggestions]) {
        disc=0
        lblTitle.text=" SUGERENCIAS PARA TI "
        allData = data
        pagesControl.numberOfPages = data.count
        globalCV.dataSource = self
        globalCV.delegate = self
        globalCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
    }
    
    func setupSlider2(data: [HomePosts]) {
        disc=2
        lblTitle.text=" DESDE LA FE "
        allData2 = data
        pagesControl.numberOfPages = data.count
        globalCV.dataSource = self
        globalCV.delegate = self
        globalCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
    }
    
    func setupSlider3(data: [HomeSaintOfDay]) {
        disc=3
        lblTitle.text=" SANTO DEL DÍA "
        allData3 = data
        //pagesControl.isHidden=true
        pagesControl.numberOfPages = data.count
        globalCV.dataSource = self
        globalCV.delegate = self
        globalCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pagesControl.currentPage = Int(x / globalCV.frame.width)

    }
    
    @objc func suggestionAction(sender: UIButton) {
        print(":::::::::IMAGE URL:::::::")
        delegate.didPressButton(sender.tag, type: allData[sender.tag].type ?? "", library: allData[sender.tag].category ?? "", url: allData[sender.tag].article_url ?? "", id: allData[sender.tag].id ?? 1)
    }
    
    @objc func postAction(sender: UIButton) {
        print("POST cLIcK::;;"+String(sender.tag))
        delegate.didPressButtonPost(url: allData2[sender.tag].publish_url ?? "Unspecified")
    }
    
// MARK: COLLECTION VEWI DELEGATE & DATA SOURCE -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var num=0
        switch disc {
        case 0:
            print("sugest YYYYY")
            num=allData.count
        case 2:
            print("post YYYYY")
            num=allData2.count
        case 3:
            print("saint YYYYY")
            num=allData3.count
        default:
            break
        }
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCOLSD", for: indexPath) as! SliderCollectionCell
        cell.imgCustom.layer.cornerRadius = 10
        cell.lblCustom.adjustsFontSizeToFitWidth = true
        
        switch disc {
        case 0:
            print("sugest")
            if indexPath.row >= allData.startIndex && indexPath.row < allData.endIndex {
            cell.imgCustom.loadS(urlS: allData[indexPath.item].image_url ?? "https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012") //o imgCustom.DownloadStaticImageH()
            cell.lblCustom.text = allData[indexPath.item].title ?? ""
            cell.btnCell.addTarget(self, action: #selector(suggestionAction), for: .touchUpInside)
            cell.btnCell.tag = indexPath.item
            }
        case 2:
            print("post")
            if indexPath.row >= allData2.startIndex && indexPath.row < allData2.endIndex {
            cell.imgCustom.loadS(urlS: allData2[indexPath.item].image_url ?? "https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012")
            cell.lblCustom.text = allData2[indexPath.item].title ?? ""
            cell.btnCell.addTarget(self, action: #selector(postAction), for: .touchUpInside)
                cell.btnCell.tag = indexPath.item
                
            }
        case 3:
            print("saint")
            if indexPath.row >= allData3.startIndex && indexPath.row < allData3.endIndex {
            cell.imgCustom.loadS(urlS: allData3[indexPath.item].image_url ?? "https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012")
            cell.lblCustom.text = allData3[indexPath.item].title ?? ""
            //cell.btnCell.addTarget(self, action: #selector(postAction), for: .touchUpInside)
                cell.btnCell.tag = indexPath.item
                
            }
        default:
                print("NO")
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
