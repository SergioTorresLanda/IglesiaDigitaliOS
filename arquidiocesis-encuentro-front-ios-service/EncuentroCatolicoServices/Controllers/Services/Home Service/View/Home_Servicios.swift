//
//  HomeServicesController.swift
//  Services
//
//  Created by Miguel Eduardo  Valdez Tellez  on 21/04/21.
//

import UIKit

class Home_Servicios: BaseViewController,HomeServiceViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func dissButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    let titleData = ["Intenciones", "Otros servicios", "Sacramentos"]
    let subDat = ["Menciones en la misa", "Bendiciones, celebraciones y otros" , "Requisitos"]
    let profile = UserDefaults.standard.string(forKey: "profile")
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    var imageDat: [UIImage?] = []
    var presenter: HomeServicePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - HomeServiceVC ")

    }
    
    private func setImage() {
        imageDat = [
            UIImage(named: "iconInt",in: Bundle.local,compatibleWith: nil),
            UIImage(named: "iconOt",in: Bundle.local,compatibleWith: nil),
            UIImage(named: "sacramentos",in: Bundle.local,compatibleWith: nil)]
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceTableViewCell
        cell.titleText.text = titleData[indexPath.row]
        cell.subText.text = subDat[indexPath.row]
        cell.imageCell.image = imageDat[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch profile {
          
        case "PRIEST_ADMIN", "DEAN_PRIEST":
            switch indexPath.row {
            case 0:
                let view = NewListIntentionsRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            case 1:
                let view = ListServiceRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            case 2:
                let view = SacramentsRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            default:
                break
                
            }
            
        case  "DEVOTED_ADMIN":
            if ((locationcomponents?.contains{ $0 == "SERVICES"}) == true){
                switch indexPath.row {
                case 0:
                    let view = NewListIntentionsRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                case 1:
                    let view = ListServiceRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                case 2:
                    let view = SacramentsRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                default:
                    break
                    
                }
                
            }else {
                switch indexPath.row {
                case 0:
                    let view = IntentionsRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                case 1:
                    let view = OtherServicesRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                case 2:
                    let view = SacramentsRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                default:
                    break
                    
                }
            }
            
        default:
            switch indexPath.row {
            case 0:
                let view = IntentionsRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            case 1:
                let view = OtherServicesRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            case 2:
                let view = SacramentsRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            default:
                break
                
            }
        
        }
        
    }
}
