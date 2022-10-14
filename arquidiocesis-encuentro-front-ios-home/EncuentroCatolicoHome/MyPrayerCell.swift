//
//  MyPrayerCell.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 18/10/21.
//

import UIKit

class MyPrayerCell: UICollectionViewCell {
    
//MARK: @IBOUTLETS -
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnOptions: UIButton!
    @IBOutlet weak var lblPrayer: UILabel!
    @IBOutlet weak var lblNumberPersons: UILabel!
    @IBOutlet weak var handsIcon: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var sliderCollection: UICollectionView!
    
// MARK: LOCAL VAR -
    var allData: [Datum]?
    
// MARK: LIFE CYCLE CELL FUNCTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupSliderColletcion(data: [Datum]) {
        let dataSorted = data.sorted(by: { $0.id > $1.id })
        allData = dataSorted
        sliderCollection.register(UINib(nibName: "SliderCellView", bundle: Bundle.local), forCellWithReuseIdentifier: "SLIDERCELL")
        sliderCollection.delegate = self
        sliderCollection.dataSource = self
        sliderCollection.reloadData()
    }
    
}

extension MyPrayerCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allData?.count ?? 0//allData?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollection.dequeueReusableCell(withReuseIdentifier: "SLIDERCELL", for: indexPath) as! SliderCellView
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.ShadowCard()
        cell.userImg.borderButtonColor(color: UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1), radius: cell.userImg.bounds.width / 2)
        cell.userImg.DownloadStaticImageH(allData?[indexPath.row].imageName ?? "")
        cell.userImg.DownloadStaticImageH(allData?[indexPath.item].imageName ?? "")
      //  cell.lblUserName.adjustsFontSizeToFitWidth = true
        cell.lblUserName.text = allData?[indexPath.item].fielName
        cell.lblPray.text = allData?[indexPath.item].datumDescription
        cell.lblPray.adjustsFontSizeToFitWidth = true
        cell.lblNumberPersons.text = "\(allData?[indexPath.item].praying ?? 0) personas orando"
        cell.lblNumberPersons.adjustsFontSizeToFitWidth = true
        cell.setupUIMenu(button: cell.btnOptions)
        let isoDate = allData?[indexPath.item].creationDate ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: isoDate) {
            print(dateFormatterPrint.string(from: date), "????")
            cell.lblDate.text = date.timeAgoDisplay()

        }else{
           print("There was an error decoding the string", "????")
        cell.lblDate.text = isoDate
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sliderCollection.frame.width, height: sliderCollection.frame.height)
    }
    
    
}
