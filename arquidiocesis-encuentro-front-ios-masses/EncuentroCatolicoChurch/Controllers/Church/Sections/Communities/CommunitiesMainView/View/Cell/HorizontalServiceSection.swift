//
//  HorizontalServiceSection.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 30/08/21.
//

import UIKit

protocol sellectedCellDeleteProtocol: AnyObject {
    func sellectedCell(index: IndexPath, indexInt: Int, indexSection: Int)
}

class HorizontalServiceSection: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
// MARK: @IBOUTLETS -
    @IBOutlet weak var servicesCV: UICollectionView!
    @IBOutlet weak var mainTitle: UILabel!
    var communityActivities: CommunityGetActivities?
    var hourServiceArray: [ServiceHourActivity]?
    var indexT = IndexPath()
    var indexInt: Int?
    let profileRole = UserDefaults.standard.string(forKey: "profile")
    public weak var delegate: sellectedCellDeleteProtocol?
// MARK: LIFE CYCLE CELL FUCNTIONS -
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func initCollectionView(data: CommunityGetActivities, hourServices: [ServiceHourActivity], indexTable: IndexPath) {
        communityActivities = data
        hourServiceArray = hourServices
        indexInt = hourServiceArray?.count
        indexT = indexTable
        servicesCV.delegate = self
        servicesCV.dataSource = self
        servicesCV.register(UINib(nibName: "CollectionCellServicesH", bundle: Bundle.local), forCellWithReuseIdentifier: "COLLCELLH")
        servicesCV.reloadData()
    }
    
// MARK: COLLECTION VIEW DELEGATE & DATASOURCE -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourServiceArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLCELLH", for: indexPath) as! CollectionCellServicesH
        cell.cardView.layer.cornerRadius = 10
        cell.cardView.clipsToBounds = true
        cell.backCard.layer.cornerRadius = 10
        cell.lblFirst.adjustsFontSizeToFitWidth = true
        cell.lblSecond.adjustsFontSizeToFitWidth = true
        cell.backCard.ShadowCard()
        var serviceDay: String{
            switch hourServiceArray?[indexPath.item].day {
            case 0:
                return "Domingo"
            case 1:
                return "Lunes"
            case 2:
                return "Martes"
            case 3:
                return "Miercoles"
            case 4:
                return "Jueves"
            case 5:
                return "Viernes"
            case 6:
                return "Sábado"
            default:
                return ""
            }
        }
        cell.lblMainTitle.text = serviceDay
        if hourServiceArray?[indexPath.item].schedules?.count != 0 {
            let hourStart = hourServiceArray?[indexPath.item].schedules?[0].hourStart
            let hourEnd = hourServiceArray?[indexPath.item].schedules?[0].hourEnd
            cell.lblTime.text = "\(hourStart ?? "") a \(hourEnd ?? "")"
            
        }
        cell.lblFirst.text = communityActivities?[indexT.row].gearedToward
        cell.lblSecond.text = communityActivities?[indexT.row].communityGetActivityDescription
        switch profileRole {
        case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue:
            cell.removeButton.isHidden = false
        default :
            cell.removeButton.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 219, height: 165)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        hourServiceArray?.remove(at: indexPath.row)
        servicesCV.reloadData()
        indexInt = indexPath.row
        print(indexPath.item)
        self.delegate?.sellectedCell(index: indexT, indexInt: indexInt ?? 0, indexSection: indexT.row)
    }
    
}
