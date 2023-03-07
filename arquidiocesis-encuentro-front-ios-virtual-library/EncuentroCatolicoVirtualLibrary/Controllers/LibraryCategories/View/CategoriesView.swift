//
//  CategoriesView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by 4n4rk0z on 16/04/21.
//

import UIKit

class CategoriesView: UIViewController, UITableViewDelegate, UITableViewDataSource, CategoriesViewProtocol{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var tableContent: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnFilters: UIButton!
    
    var presenter: CategoriesPresenterProtocol?
    let urlOptionalImage = "https://arquidiocesis-app-mx.s3.amazonaws.com/BIBLIOTECA/CATEGORIAS/Canciones.png"
    var contentcategory: String?
    var oracionesList: [Content] = []
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableContent.delegate = self
        tableContent.dataSource = self
        tableContent.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableContent.register(UINib(nibName: "CategoriesCell", bundle: Bundle.local), forCellReuseIdentifier: "cell")
        showLoading()
        presenter?.getContentByCategory(category: contentcategory ?? "")
        NotificationCenter.default.addObserver(self, selector: #selector(addFilter(notification:)), name: Notification.Name(rawValue: "changeFilter"), object: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func addFilter(notification: NSNotification){
        let endPoint = "https://xmbcqr3wvd.execute-api.us-east-1.amazonaws.com/develop/library/category/\(contentcategory ?? "ORACIONES")?"
        var age = ""
        var order = ""
        var topic = ""
        let object = notification.object as? [Filter:Order]
        if object != nil{
            let objectFilter = object!.first!.key
            let objectOrder = object!.first!.value
            switch objectFilter {
            case .adult:
                age = "&age=ADULTS"
            case .kids:
                age = "&age=CHILDREN"
            case .young:
                age = "&age=YOUTH"
            case .theme:
                topic = "&topic=true"
            case .none:
                topic = ""
                age = ""
            }
            switch objectOrder {
            case .olderToRecent:
                order = "&order=LOW"
            case .recentToOlder:
                order = "&order=TOP"
            default:
                order = ""
            }
        }
        let urlWithFilter = endPoint + age + order + topic
        
        presenter?.getContentWithFilter(filter: urlWithFilter)
    }
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alerta, animated: true, completion: nil)
    }
    
    func loadContentByCategory(data: LibraryCategories) {
        oracionesList.removeAll()
        if data.contents != nil{
            self.titleLabel.text = data.title
            imageContent.downloaded(from: data.image ?? self.urlOptionalImage)
            imageContent.contentMode = .scaleAspectFill
            btnFilters.setTitle("Ordenar y Filtrar", for: .normal)
            for item in data.contents!{
                oracionesList.append(item)
            }
            self.tableContent.reloadData()
        }
        alert.dismiss(animated: true, completion: nil)
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oracionesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoriesCell
        cell.lblTitle.text = oracionesList[indexPath.row].name
        cell.tag = oracionesList[indexPath.row].id ?? -1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableContent.cellForRow(at: indexPath)
        let view = LibraryAndResourcesRouter.createModule(contentID: cell?.tag ?? -1)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func close(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showFilters(_ sender: Any) {
        let view = FilterAlertRouter.createModule()
        self.present(view, animated: true, completion: nil)
    }
    
}

