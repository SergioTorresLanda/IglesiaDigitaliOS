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
    @IBOutlet weak var suggestionsCV: UICollectionView!
    @IBOutlet weak var pagesControl: UIPageControl!
    
    var delegate:YourCellDelegate!
    
    var allData: [HomeSuggestions] = []
    var allData2: [HomeSaintOfDay] = []
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
        lblTitle.text=" Sugerencias para ti "
        allData = data
        pagesControl.numberOfPages = data.count
        suggestionsCV.dataSource = self
        suggestionsCV.delegate = self
        suggestionsCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
    }
    
    func setupSlider2(data: [HomeSaintOfDay]) {
        disc=1
        lblTitle.text=" Desde la fe "
        allData2 = data
        pagesControl.numberOfPages = data.count
        suggestionsCV.dataSource = self
        suggestionsCV.delegate = self
        suggestionsCV.register(UINib(nibName: "SliderCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCOLSD")
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pagesControl.currentPage = Int(x / suggestionsCV.frame.width)

    }
    
    @objc func suggestionAction(sender: UIButton) {
        delegate.didPressButton(sender.tag, type: allData[sender.tag].type ?? "", library: allData[sender.tag].category ?? "", url: allData[sender.tag].article_url ?? "", id: allData[sender.tag].id ?? 1)
    }
    
    @objc func postAction(sender: UIButton) {
        print("POST cLIcK::;;"+String(sender.tag))
        delegate.didPressButtonPost(url: allData2[sender.tag].publish_url ?? "Unspecified")
    }
    
// MARK: COLLECTION VEWI DELEGATE & DATA SOURCE -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if disc==0{
            return allData.count
        }else{
            return allData2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCOLSD", for: indexPath) as! SliderCollectionCell
        cell.imgCustom.layer.cornerRadius = 10
        cell.lblCustom.adjustsFontSizeToFitWidth = true
        if disc==0{
        cell.imgCustom.DownloadStaticImageH(allData[indexPath.item].image_url ?? "")
        cell.lblCustom.text = allData[indexPath.item].title ?? ""
        cell.btnCell.addTarget(self, action: #selector(suggestionAction), for: .touchUpInside)
            cell.btnCell.tag = indexPath.item
            
        }else{
            cell.imgCustom.DownloadStaticImageH(allData2[indexPath.item].image_url ?? "")
            cell.lblCustom.text = allData2[indexPath.item].title ?? ""
            cell.btnCell.addTarget(self, action: #selector(postAction), for: .touchUpInside)
                cell.btnCell.tag = indexPath.item
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("&&&", indexPath.item)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: suggestionsCV.frame.width, height: suggestionsCV.frame.height + 30)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
}
