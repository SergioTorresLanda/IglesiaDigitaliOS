//
//  PromiseView.swift
//  EncuentroCatolicoProfile
//
//  Created by Desarrollo on 30/03/21.
//

import UIKit

class PromiseView: UIView {

    @IBOutlet var withoutPromisseView: UIView!
    @IBOutlet var promisseTableView: UITableView!
    @IBOutlet var promisseTemporalView: UIView!
    
    // MARK: Properties
    var flag = false
    var presenter: ProfileInfoPresenterProtocol?
    var promisses: [PromiseModel] =  [PromiseModel](){
        didSet{
            if(flag == true){
                if(promisses.count == 0){
                    withoutPromisseView.isHidden = false
                    promisseTemporalView.isHidden = true
                }else{
                    withoutPromisseView.isHidden = true
                    promisseTemporalView.isHidden = false
                }
            }
            promisseTableView.reloadData()
        }
    }
    
    override class func awakeFromNib() {
       // promisseTableView.delegate = self
       // promisseTableView.dataSource = self
       // promisseTableView.register(PromisseViewCell.nib,forCellReuseIdentifier: PromisseViewCell.reuseIdentifier)
    }
    
    func displayCustomAlert(pharraphers:NSAttributedString, image: String) {
        let promisseAlertView = PromisseAlertView(frame: UIScreen.main.bounds)
        promisseAlertView.translatesAutoresizingMaskIntoConstraints = false
       // promisseAlertView.delegate = self
        self.addSubview(promisseAlertView)
       // promisseAlertView.initCustom(context: self, pharraphers: pharraphers, image: image)
        promisseAlertView.displayAnimation()
        // promisseAlertView.displayAnimation()
    }
    
    func getPromisse() {
//        let promisse = dataManager.allPromisse(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
//        view?.reloadPromisse(promisse: promisse)
    }
}

extension PromiseView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promisses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = promisseTableView.dequeueReusableCell(withIdentifier: PromisseViewCell.reuseIdentifier, for: indexPath) as! PromisseViewCell
        cell.descriptionPromisse.text = "Prometiste a \(promisses[indexPath.row].promisseTo) \(promisses[indexPath.row].promisseDescription ?? "") por \(promisses[indexPath.row].periodInterval ?? "")"
        if(promisses[indexPath.row].periodInterval == "Siempre"){
            cell.timeToOver.text = "Días restantes: Por siempre"
        }else if(Calendar.current.numberOfDaysBetween(Date(), and: promisses[indexPath.row].dateEnd ?? Date()) == 1){
            cell.timeToOver.text = "Días restantes: 1 día"
        }else if(Calendar.current.numberOfDaysBetween(Date(), and: promisses[indexPath.row].dateEnd ?? Date()) == 0){
            cell.timeToOver.text = "Días restantes: Hoy"
        }else{
            cell.timeToOver.text = "Días restantes: \(Calendar.current.numberOfDaysBetween(Date(), and: promisses[indexPath.row].dateEnd ?? Date())) días"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promiseModel = promisses[indexPath.row]
        let attributesMedium: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .regular
            ),
            .foregroundColor: #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        ]
        let attributesBold: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        ]
        let attributedFirst = NSMutableAttributedString(string: "Prometiste a ", attributes: attributesMedium)
        let attributedSecond = NSAttributedString(string: " por ", attributes: attributesMedium)
        
        let attributedPromisseTo = NSAttributedString(string: promiseModel.promisseTo, attributes: attributesBold)
        let attributedPromisseDescription = NSAttributedString(string: " \(promiseModel.promisseDescription ?? "")", attributes: attributesBold)
        let attributedPeriodInterval = NSAttributedString(string: promiseModel.periodInterval ?? "", attributes: attributesBold)
        
        attributedFirst.append(attributedPromisseTo)
        attributedFirst.append(attributedPromisseDescription)
        attributedFirst.append(attributedSecond)
        attributedFirst.append(attributedPeriodInterval)
        displayCustomAlert(pharraphers: attributedFirst, image: promiseModel.imageSaint ?? "")
    }

}
