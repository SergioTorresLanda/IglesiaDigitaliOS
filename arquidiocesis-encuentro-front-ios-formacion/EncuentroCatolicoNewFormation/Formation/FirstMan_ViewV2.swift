//
//  FirstMan_ViewV2.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Billy  on 11/11/21.
//

import UIKit

protocol SSVIPER_PresenterToViewProtocol: class {
    var _presenter : SSVIPER_ViewToPresenterProtocol? {set get}
    func setData(data: FF_FormationObj_Entity)
    func setDataChild(data: [FF_Formation_Entity])
    func errorCloseSesion(code : Int?, msg : String?)
    func successcloseSesion(data : String?, msg : String?)
    func setDataCatalog(data: FF_CatalogObj_Entity)
}

class FirstMan_ViewV2: UIViewController{
    
    
    public var arrCatalogo = [FF_Catalog_Entity]()
    var searchField : UITextField?
    var _presenter: SSVIPER_ViewToPresenterProtocol?
    var pressedCatalog = false
    var strCodeCatalog = ""
    var arrController: [UIViewController] = [UIViewController]()

    
    fileprivate let collectionViewCatalg:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CatalogCell.self, forCellWithReuseIdentifier: "CatalogCell")
        return cv
    }()
    
    lazy var safeArea = { () -> UILayoutGuide in
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide
        }else{
            return self.view.layoutMarginsGuide
        }
    }()
    
    let container1 = UIView()
    let container2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        if arrCatalogo.count > 0{
            strCodeCatalog  = arrCatalogo[0].code
        }
        refreshView()
    }
        
    func setUp(){
        container1.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(container1)
    }
    
    
    func refreshView(){
        searchField = UITextField(frame: CGRect.zero)
        guard let searchField = searchField else { debugPrint("Can't create searchField"); return }
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.layer.cornerRadius = 20
        searchField.layer.masksToBounds = true
        searchField.layer.borderWidth = 2
        searchField.layer.borderColor = UIColor.black.cgColor
        searchField.rightViewMode = UITextField.ViewMode.always
        
        let view1 = NavigationGeneric()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.delegate = self
        
        self.view.addSubview(view1)
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -50),
            view1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            view1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            view1.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        view.addSubview(collectionViewCatalg)
        collectionViewCatalg.backgroundColor = .white
        collectionViewCatalg.delegate = self
        collectionViewCatalg.dataSource = self
        collectionViewCatalg.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionViewCatalg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        collectionViewCatalg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 8).isActive = true
        collectionViewCatalg.heightAnchor.constraint(equalToConstant: 60).isActive = true
        collectionViewCatalg.showsHorizontalScrollIndicator = false
    }
    
    
    override func viewDidLayoutSubviews() {
        let height = navigationController?.navigationBar.frame.maxY
        collectionViewCatalg.frame = CGRect(x: 0, y: (height ?? 0) + 78.2, width: collectionViewCatalg.frame.size.width, height: collectionViewCatalg.frame.size.height)
        self.collectionViewCatalg.tintColor = UIColor(red: 28.0 / 255.0, green: 117.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
        super.viewDidLayoutSubviews()
    }
    
    
    var tableYoung: UITableView?
    private var colorBackground = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    private var imageFooter: UIImageView?
    private var onSearch: Bool = false
    private var arGeneralSection: [TableYoungSection] = []
    private var sgmSelection = 0
    private var arTitles: [String]? = []
    private var tableFilterData: [FF_Formation_Entity] = []
    private var tableInfoNew: [FF_Formation_Entity]?
    let imageCached = NSCache<NSString, UIImage>()
    private var viewNoResult: NoResults_ViewV2?
    private var stSearch: String? = ""
    var strTypeComponents: String? = ""
    
    func setUpView(){
//        self._presenter?.getData(strTypeCatalog: "CHILDREN")
        self.view.backgroundColor = colorBackground
        tableYoung?.backgroundColor = colorBackground
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
        
        tableYoung = UITableView(frame: CGRect.zero)
        guard let tableYoung = tableYoung else { debugPrint("Can't create tableNew"); return }
        tableYoung.translatesAutoresizingMaskIntoConstraints = false
        tableYoung.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableYoung.delegate = self
        tableYoung.dataSource = self
        tableYoung.register(InfoView_Cell.self, forCellReuseIdentifier: "cell")
        tableYoung.separatorColor = UIColor.clear
        tableYoung.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        let codeSegmented = CustomSegmentController(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0), sgmTitles: arTitles ?? [])
        codeSegmented.backgroundColor = UIColor.clear
        codeSegmented.delegate = self
        codeSegmented.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(codeSegmented)
        
        self.view.addSubview(searchField)
        self.view.addSubview(tableYoung)
        self.view.addSubview(imageFooter)
        
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: 50),
            searchField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            searchField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16.3),
            searchField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16.3),
            
            tableYoung.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 118),
            tableYoung.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -17),
            tableYoung.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17),
            tableYoung.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 40),
            
            imageFooter.topAnchor.constraint(equalTo: codeSegmented.topAnchor, constant: -5),
            imageFooter.widthAnchor.constraint(equalToConstant: 50),
            imageFooter.heightAnchor.constraint(equalToConstant: 5),
            imageFooter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.bounds.width/20)*11.2),
            
            codeSegmented.heightAnchor.constraint(equalToConstant: 50),
            codeSegmented.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 66),
            codeSegmented.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            codeSegmented.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            
        ])
    }
    
    func loadViewController(strCatalog: String, navigation: UINavigationController){
        

    }
}

extension FirstMan_ViewV2: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63.0, height: 63.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCatalogo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.arrCatalogo[indexPath.row]
        guard let cell = collectionViewCatalg.dequeueReusableCell(withReuseIdentifier: "CatalogCell", for: indexPath) as? CatalogCell else { return UICollectionViewCell() }
        cell.backgroundColor = UIColor.white
        cell.setData(data: item, strCode: strCodeCatalog)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        strCodeCatalog = arrCatalogo[indexPath.row].code
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.reloadSections(IndexSet(integer: 0))
//        loadViewController(strCatalog: arrCatalogo[indexPath.row].code, navigation: self.navigationController ?? UINavigationController())
    }
}

extension FirstMan_ViewV2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !onSearch {
            return arGeneralSection[sgmSelection].data.count
        }else{
            return tableFilterData.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
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
                    let url = URL(string: youtubeURL)
                    let data = try? Data(contentsOf: (url ?? URL(string: "www.com"))!)
                    
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                        self.imageCached.setObject(image, forKey: NSString(string:(youtubeURL)))
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
                    let url = URL(string: youtubeURL )
                    let data = try? Data(contentsOf: (url ?? URL(string: "www.com"))!)
                    
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                        self.imageCached.setObject(image, forKey: NSString(string:(youtubeURL )))
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

extension FirstMan_ViewV2: UITextFieldDelegate {
    
    @objc func textFieldActive() {
        if onSearch{
            viewNoResult?.removeFromSuperview()
            tableYoung?.isHidden = tableFilterData.count > 0 ? false : true
        }else{
            viewNoResult?.removeFromSuperview()
            let enable = tableFilterData.count > 0 ? true : false
            tableYoung?.isHidden = enable
            viewNoResult?.isHidden = true
        }
        if tableFilterData.count <= 0 &&  onSearch {
       
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
        
        tableYoung?.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 <= 0{
            onSearch = false
            tableFilterData = []
        }
        textFieldActive()
        tableYoung?.reloadData()
        view.endEditing(true)
        return true
    }
    
    func searchFieldUsing(string: String){
        tableYoung?.isHidden = false
        onSearch = true
        tableFilterData = tableInfoNew?.filter({ (result) -> Bool in
            return result.title.range(of: string, options: .caseInsensitive) != nil
        }) ?? []
        textFieldActive()
        tableYoung?.reloadData()
    }
    
}

extension FirstMan_ViewV2: CustomSegmentControllerDelegate{
    func change(to index: Int) {
        sgmSelection = index
        tableYoung?.reloadData()
    }
}

extension FirstMan_ViewV2: NavigationDelegationAction{
    func getAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension FirstMan_ViewV2: SSVIPER_PresenterToViewProtocol{
    
    func setDataCatalog(data: FF_CatalogObj_Entity) {
        print("Imprimio en First: \(data)")
    }
    
    
    func errorCloseSesion(code: Int?, msg: String?) {
//        print("Regreso la data errorCloseSesion")
    }
    
    func successcloseSesion(data: String?, msg: String?) {
//        print("Regreso la data successcloseSesion")
    }
    
    func setData(data: FF_FormationObj_Entity){
//        print("Regreso la data")
    }
    
    func setDataChild(data: [FF_Formation_Entity]) {
//        print("Regreso la data")
    }
    
}
