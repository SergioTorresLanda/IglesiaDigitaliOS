//
//  promisessListView.swift
//  EncuentroCatolicoProfile
//
//  Created by Desarrollo on 30/03/21.
//

import UIKit

class promisessListViewController: UIViewController {
    
    @IBOutlet var withoutPromisseView: UIView!
    @IBOutlet var promisseTableView: UITableView!
    @IBOutlet var promisseTemporalView: UIView!
    
    // MARK: Properties
    var flag = false
    var dataManager = EditionPromisseDataManager.shareInstance
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promisseTableView.delegate = self
        promisseTableView.dataSource = self
        promisseTableView.register(PromisseViewCell.nib,forCellReuseIdentifier: PromisseViewCell.reuseIdentifier)
        getPromisse()
        flag = true
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            self.view.layoutIfNeeded()
        } completion: { (isAnimated) in
            
        }
        if(promisses.count == 0){
            withoutPromisseView.isHidden = false
            promisseTemporalView.isHidden = true
        }else{
            withoutPromisseView.isHidden = true
            promisseTemporalView.isHidden = false
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData(notification:)), name: Notification.Name("reloadData"), object: nil)
    }
    
    func displayCustomAlert(pharraphers:NSAttributedString, image: String) {
        let promisseAlertView = PromisseAlertView(frame: UIScreen.main.bounds)
        promisseAlertView.translatesAutoresizingMaskIntoConstraints = false
        // promisseAlertView.delegate = self
        self.view.addSubview(promisseAlertView)
        promisseAlertView.initCustom(context: self, pharraphers: pharraphers, image: image)
        promisseAlertView.displayAnimation()
    }
    
    func reloadPromisse(promisse: [PromiseModel]) {
        self.promisses = promisse
    }
    
    func getPromisse() {
        let promisse = dataManager.allPromisse(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
        reloadPromisse(promisse: promisse)
    }
    
    @objc private func reloadData(notification: Notification){
        getPromisse()
        promisseTableView.reloadData()
    }
    
    @IBAction func newPromisseAction(_ sender: Any){
        let viewPromisse = EditionPromisseMain.createModule(navigation: self.navigationController!)
        self.navigationController!.pushViewController(viewPromisse, animated: true)
    }
    
    @IBAction func createPromisseAction(_ sender: Any){
        let viewPromisse = EditionPromisseMain.createModule(navigation: self.navigationController!)
        self.navigationController!.pushViewController(viewPromisse, animated: true)
    }
}

extension promisessListViewController: UITableViewDelegate, UITableViewDataSource{
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
        NotificationCenter.default.post(name: Notification.Name("displayPromiseAlert"), object: promiseModel)
    }
    
}
