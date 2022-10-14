//
//  AdultView_Controller.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 02/05/21.
//

import UIKit

protocol FAV_VIPER_PresenterToViewProtocol: class {
    var _presenter : FAV_VIPER_ViewToPresenterProtocol? {set get}
    func setDataChild(data: [FF_Formation_Entity])
}

class AdultView_Controller: UIViewController {

    var searchField : UITextField?
    var tableAdult: UITableView?
    private var tableInfoNew: [FF_Formation_Entity]?
    private var tableFilterData: [FF_Formation_Entity] = []
    private var onSearch: Bool = false
    private var searchView: NoResults_View?
    private var imageFooter: UIImageView?
    var _presenter: FAV_VIPER_ViewToPresenterProtocol?
    let imageCached = NSCache<NSString, UIImage>()
    private var sgmSelection = 0
    private var arGeneralSection: [TableYoungSection] = []
    private var viewNoResult: NoResults_ViewV2?
    private var stSearch: String? = ""
    private var colorBackground = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    
    lazy var safeArea = { () -> UILayoutGuide in
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide
        }else{
            return self.view.layoutMarginsGuide
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorBackground
        self._presenter?.getData()
        tableAdult?.backgroundColor = colorBackground
        let backSearch = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        backSearch.backgroundColor = UIColor.white
        
        self.view.addSubview(backSearch)
        searchField = Search_TextField(frame: CGRect.zero)
        guard let searchField = searchField else { debugPrint("Can't create searchField"); return }
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.delegate = self
        searchField.placeholder = "formation_button_search".getStringFrom()
        
        imageFooter = UIImageView(frame: CGRect.zero)
        guard let imageFooter = imageFooter else { debugPrint("Can't create imageFooter"); return }
        imageFooter.translatesAutoresizingMaskIntoConstraints = false
        imageFooter.image = UIImage(named: "rectNgulo360", in: Bundle(for: FirstMan_Route.self), compatibleWith: nil)
        imageFooter.contentMode = .scaleAspectFit
        
        let imageView_ = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 25.0, height: 25.0))
        let image_ = UIImage(named: "iconoBuscar", in: Bundle(for: FirstMan_Route.self), compatibleWith: nil)
        imageView_.image = image_
        imageView_.contentMode = .scaleAspectFit

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageView_)
        searchField.rightViewMode = UITextField.ViewMode.always
        searchField.rightView = view
        
        
        tableAdult = UITableView(frame: CGRect.zero)
        guard let tableAdult = tableAdult else { debugPrint("Can't create tableNew"); return }
        tableAdult.translatesAutoresizingMaskIntoConstraints = false
        tableAdult.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableAdult.delegate = self
        tableAdult.dataSource = self
        tableAdult.register(InfoView_Cell.self, forCellReuseIdentifier: "cell")
        tableAdult.separatorColor = UIColor.clear
        tableAdult.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        let codeSegmented = CustomSegmentController(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0), sgmTitles: ["PDF","Video","Enlances"])
        codeSegmented.backgroundColor = .clear
        codeSegmented.delegate = self
        codeSegmented.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(codeSegmented)
        
        self.view.addSubview(searchField)
        self.view.addSubview(tableAdult)
        self.view.addSubview(imageFooter)
        
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: 50),
            searchField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            searchField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16.3),
            searchField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16.3),
            
            tableAdult.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 118),
            tableAdult.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -17),
            tableAdult.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17),
            tableAdult.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 40),
            
            imageFooter.topAnchor.constraint(equalTo: codeSegmented.topAnchor, constant: -5),
            imageFooter.widthAnchor.constraint(equalToConstant: 50),
            imageFooter.heightAnchor.constraint(equalToConstant: 5),
            imageFooter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.bounds.width/20)*16.2),
            codeSegmented.heightAnchor.constraint(equalToConstant: 50),
            codeSegmented.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 66),
            codeSegmented.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            codeSegmented.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
        ])
    }
}

extension AdultView_Controller: FAV_VIPER_PresenterToViewProtocol {
    
    func setDataChild(data: [FF_Formation_Entity]) {
        tableInfoNew = data
        let arrFilterFile = tableInfoNew?.filter { $0.type == "FILE"} ?? []
        let arrFilterVideo = tableInfoNew?.filter { $0.type == "VIDEO"} ?? []
        let arrFilterLink = tableInfoNew?.filter { $0.type == "LINK"} ?? []
        
        arGeneralSection.append(TableYoungSection(title: "FILE", data: arrFilterFile))
        arGeneralSection.append(TableYoungSection(title: "VIDEO", data: arrFilterVideo))
        arGeneralSection.append(TableYoungSection(title: "LINK", data: arrFilterLink))
        
        tableAdult?.reloadData()
    }
}

extension AdultView_Controller: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !onSearch {
            return arGeneralSection[sgmSelection].data.count
        }else{
            return tableFilterData.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arGeneralSection.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = tableView.dequeueReusableCell(withIdentifier: "cell") as? InfoView_Cell else {
            return UITableViewCell()
        }
        row.backgroundColor = colorBackground
        if !onSearch{
            row.details = arGeneralSection[sgmSelection].data[indexPath.row].asFormationCell()
            let imageString = arGeneralSection[sgmSelection].data[indexPath.row].asFormationCell().image
            if let strUrl = imageString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let imgUrl = URL(string: imageString) {
                if imageString == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_file.png"{
                    row.imageViewTitle.image = UIImage(named: "pdf", in: Bundle().getBundle(), compatibleWith: nil)
                }else if imageString == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_link.png"{
                    row.imageViewTitle.image = UIImage(named: "link", in: Bundle().getBundle(), compatibleWith: nil)
                }else{
                DispatchQueue.global(qos: .background).async {
                    let url = imgUrl
                    let data = try? Data(contentsOf: url)
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                         self.imageCached.setObject(image, forKey: NSString(string:(strUrl)))
                        row.imageViewTitle.image = image
                        row.imageViewTitle.contentMode = .scaleAspectFit
                    }
                }
                }
            }else{
                let youtubeURL = arGeneralSection[sgmSelection].data[indexPath.row].url.getYouTubeThubnailFromURL()
                DispatchQueue.global(qos: .background).async {
                    let url = URL(string: youtubeURL ?? "www.youtube.com")
                    let data = try? Data(contentsOf: (url ?? URL(string: "www.com"))!)
                    
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                        self.imageCached.setObject(image, forKey: NSString(string:(youtubeURL ?? "www.youtube.com")))
                        row.imageViewTitle.image = image
                        row.imageViewTitle.contentMode = .scaleAspectFill
                    }
                }
            }
        }else{
            row.details = tableFilterData[indexPath.row].asFormationCell()
            let imageString = tableFilterData[indexPath.row].asFormationCell().image
            if let strUrl = imageString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let imgUrl = URL(string: imageString) {
                if imageString == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_file.png"{
                    row.imageViewTitle.image = UIImage(named: "pdf", in: Bundle().getBundle(), compatibleWith: nil)
                }else if imageString == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_link.png"{
                    row.imageViewTitle.image = UIImage(named: "link", in: Bundle().getBundle(), compatibleWith: nil)
                }else{
                DispatchQueue.global(qos: .background).async {
                    let url = imgUrl
                    let data = try? Data(contentsOf: url)
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                         self.imageCached.setObject(image, forKey: NSString(string:(strUrl)))
                        row.imageViewTitle.image = image
                        row.imageViewTitle.contentMode = .scaleAspectFit
                    }
                }
                }
            }else{
                let youtubeURL = arGeneralSection[sgmSelection].data[indexPath.row].url.getYouTubeThubnailFromURL()
                DispatchQueue.global(qos: .background).async {
                    let url = URL(string: youtubeURL ?? "www.youtube.com")
                    let data = try? Data(contentsOf: (url ?? URL(string: "www.com"))!)
                    
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                        self.imageCached.setObject(image, forKey: NSString(string:(youtubeURL ?? "www.youtube.com")))
                        row.imageViewTitle.image = image
                        row.imageViewTitle.contentMode = .scaleAspectFit
                    }
                }
            }
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if !onSearch{
            let libraryData = arGeneralSection[sgmSelection].data[indexPath.row].url
            guard let url = URL(string: libraryData.embedAndPlayYoutubeURL()) else { return }
            let view = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle().getBundle())
            view.screenURL = url.absoluteString
            self.navigationController?.pushViewController(view, animated: true)
        }else{
            let libraryData = tableFilterData[indexPath.row].url
            guard let url = URL(string: libraryData.embedAndPlayYoutubeURL()) else { return }
            let view = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle().getBundle())
            view.screenURL = url.absoluteString
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
}

extension AdultView_Controller: UITextFieldDelegate {
    
    @objc func textFieldActive() {
        if onSearch{
            viewNoResult?.removeFromSuperview()
            tableAdult?.isHidden = tableFilterData.count > 0 ? false : true
        }else{
            viewNoResult?.removeFromSuperview()
            let enable = tableFilterData.count > 0 ? true : false
            tableAdult?.isHidden = enable
            viewNoResult?.isHidden = true
        }
        if tableFilterData.count <= 0 &&  onSearch {
            viewNoResult?.removeFromSuperview()
            viewNoResult = NoResults_ViewV2(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 50 , height: 280))
            viewNoResult?.NoResultsV2(searchText: stSearch ?? "")
            viewNoResult?.center.x = self.view.center.x
            viewNoResult?.center.y = self.view.center.y + 65
            viewNoResult?.layer.cornerRadius = 9
            viewNoResult?.layer.masksToBounds = true

            self.view.addSubview(viewNoResult ?? UIView())
        }
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        let searchText  = textField.text! + string
        stSearch = searchText
        searchFieldUsing(string: searchText)
        textFieldActive()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 <= 0{
            onSearch = false
            tableFilterData = []
        }
        
        tableAdult?.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 <= 0{
            onSearch = false
            tableFilterData = []
        }
        textFieldActive()
        tableAdult?.reloadData()
        view.endEditing(true)
        return true
    }
    
    func searchFieldUsing(string: String){
        tableAdult?.isHidden = false
        onSearch = true
        tableFilterData = tableInfoNew?.filter({ (result) -> Bool in
            return result.title.range(of: string, options: .caseInsensitive) != nil
        }) ?? []
        textFieldActive()
        tableAdult?.reloadData()
    }
    
}

extension AdultView_Controller: CustomSegmentControllerDelegate{
    func change(to index: Int) {
        sgmSelection = index
        tableAdult?.reloadData()
    }
}

