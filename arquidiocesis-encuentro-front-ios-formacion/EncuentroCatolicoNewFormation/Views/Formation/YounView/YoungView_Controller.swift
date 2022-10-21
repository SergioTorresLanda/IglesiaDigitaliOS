//
//  YoungView_Controller.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 02/05/21.
//

import UIKit
import EncuentroCatolicoUtils

struct TableYoungSection{
    var title: String
    var data: [FF_Formation_Entity]
}

class YoungView_Controller: UIViewController {
    //MARK: - Properties
    var searchField : UITextField?
    var tableYoung: UITableView?
    private var tableInfoNew: [FF_Formation_Entity]?
    private var tableFilterData: [FF_Formation_Entity] = []
    private var onSearch: Bool = false
    private var searchView: NoResults_View?
    private var imageFooter: UIImageView?
    var _presenter: FYV_VIPER_ViewToPresenterProtocol?
    let imageCached = NSCache<NSString, UIImage>()
    var arGeneralSection: [TableYoungSection] = []
    private var sgmSelection = 0
    private var viewNoResult: NoResults_ViewV2?
    private var stSearch: String? = ""
    var strTypeComponents: String? = ""
    var arTitles: [ECNFFormationType] = ECNFFormationType.allCases
    var costmSgmtCotroller = CustomSegmentController()
    private var colorBackground = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    
    public var arrCatalogo = [FF_Catalog_Entity]()
    var pressedCatalog = false
    var strCodeCatalog = ""
    
    let collectionViewCatalg:UICollectionView = {
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
        }
        
        return self.view.layoutMarginsGuide
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strCodeCatalog = arrCatalogo.count > 0 ? arrCatalogo[0].code : ""
        setUpView(reload: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK: - Methods
    func setUpView(reload: Bool){
        if reload{
            tableYoung?.removeFromSuperview()
            searchField?.removeFromSuperview()
            imageFooter?.removeFromSuperview()
            costmSgmtCotroller.removeFromSuperview()
            collectionViewCatalg.removeFromSuperview()
        }else{
            setUpNavigation()
        }
        
        self.showSpinner()
        setupUI()
        setupConstraints()
        arrCatalogo.isEmpty ? self._presenter?.getCatalogData() : _presenter?.getData(strTypeCatalog: strCodeCatalog)
    }
}

//MARK: - FYV_VIPER_PresenterToViewProtocol
extension YoungView_Controller: FYV_VIPER_PresenterToViewProtocol {
    func setDataCatalog(data: [FF_Catalog_Entity]) {
        self.arrCatalogo = data
        
        collectionViewCatalg.reloadData()
        
        _presenter?.getData(strTypeCatalog: strCodeCatalog)
    }
    
    func setDataChild(data: [FF_Formation_Entity]) {
        sgmSelection = 0
        tableInfoNew = data
        
        Dictionary(grouping: tableInfoNew ?? [], by: { $0.type }).forEach {
            self.arGeneralSection.append(TableYoungSection(title: $0.key, data: $0.value))
        }
        
        self.hideSpinner()
        self.arGeneralSection.count > 0 ? self.tableYoung?.reloadData() : self.viewNoResultV2(bSearch: false)
    }
}

//MARK: - UITableViewDataSource
extension YoungView_Controller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        !onSearch ? (arGeneralSection[safe: sgmSelection]?.data.count ?? 0) : tableFilterData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        arGeneralSection.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = tableView.dequeueReusableCell(withIdentifier: "cell") as? InfoView_Cell else {
            return UITableViewCell()
        }
        
        guard let sgmSection = arGeneralSection[safe: sgmSelection] else {
            viewNoResultV2(bSearch: false)
            return UITableViewCell()
        }
        
        row.backgroundColor = colorBackground
        if !onSearch{
            row.details = sgmSection.data[indexPath.row].asFormationCell()
            let imageString = sgmSection.data[indexPath.row].asFormationCell().image
            
            
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
                let youtubeURL = sgmSection.data[indexPath.row].url.getYouTubeThubnailFromURL()
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
                let youtubeURL = sgmSection.data[indexPath.row].url.getYouTubeThubnailFromURL()
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
        80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate
extension YoungView_Controller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !onSearch{
            let libraryData = arGeneralSection[sgmSelection].data[indexPath.row].url
            guard let url = URL(string: libraryData.embedAndPlayYoutubeURL()) else { return }
            let view = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle().getBundle())
            view.screenURL = url.absoluteString
            self.navigationController?.pushViewController(view, animated: true)
            return
        }
        
        let libraryData = tableFilterData[indexPath.row].url
        guard let url = URL(string: libraryData.embedAndPlayYoutubeURL()) else { return }
        let view = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle().getBundle())
        view.screenURL = url.absoluteString
        self.navigationController?.pushViewController(view, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension YoungView_Controller: UITextFieldDelegate {
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
            
            viewNoResult?.removeFromSuperview()
            viewNoResultV2(bSearch: true)
        }
    }
    
    func viewNoResultV2(bSearch: Bool){
        viewNoResult = NoResults_ViewV2(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        guard let vwNoresuslt = viewNoResult else { return }
        
        vwNoresuslt.NoResultsV2(searchText: stSearch ?? "", bSearch: bSearch)
        vwNoresuslt.translatesAutoresizingMaskIntoConstraints = false
        vwNoresuslt.layer.cornerRadius = 9
        vwNoresuslt.layer.masksToBounds = true
        
        self.view.addSubview(vwNoresuslt)
        
        NSLayoutConstraint.activate([
            vwNoresuslt.heightAnchor.constraint(equalToConstant: 250),
            vwNoresuslt.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 250),
            vwNoresuslt.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16.3),
            vwNoresuslt.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16.6)
        ])
        
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
        tableFilterData = arGeneralSection[sgmSelection].data.filter({ (result) -> Bool in
            return result.title.range(of: string, options: .caseInsensitive) != nil
        })
        textFieldActive()
        tableYoung?.reloadData()
    }
    
}

//MARK: - CustomSegmentControllerDelegate
extension YoungView_Controller: CustomSegmentControllerDelegate{
    func change(to index: Int) {
        sgmSelection = index
        tableYoung?.reloadData()
    }
}

//MARK: - NavigationDelegationAction
extension YoungView_Controller: NavigationDelegationAction{
    func getAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Private functions
extension YoungView_Controller {
    private func setUpNavigation(){
        let view1 = NavigationGeneric()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.delegate = self
        
        
        let backSearch = UIView(frame: CGRect.zero)
        backSearch.translatesAutoresizingMaskIntoConstraints = false
        backSearch.backgroundColor = UIColor.white
        self.view.addSubview(backSearch)
        self.view.addSubview(view1)
        
        NSLayoutConstraint.activate([
            view1.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -50),
            view1.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            view1.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            view1.heightAnchor.constraint(equalToConstant: 100),
            
            backSearch.topAnchor.constraint(equalTo: view1.topAnchor, constant: 100),
            backSearch.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0),
            backSearch.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
            backSearch.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupUI() {
        self.view.backgroundColor = colorBackground
        tableYoung?.backgroundColor = colorBackground
        searchField = Search_TextField(frame: CGRect.zero)
        searchField?.translatesAutoresizingMaskIntoConstraints = false
        searchField?.delegate = self
        searchField?.placeholder = "formation_button_search".getStringFrom()
        
        let imageView_ = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 25.0, height: 25.0))
        let image_ = UIImage(named: "iconoBuscar", in: Bundle(for: YoungView_Route.self), compatibleWith: nil)
        
        imageView_.image = image_
        imageView_.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageView_)
        
        searchField?.rightViewMode = UITextField.ViewMode.always
        searchField?.rightView = view
        
        collectionViewCatalg.backgroundColor = .white
        collectionViewCatalg.delegate = self
        collectionViewCatalg.dataSource = self
        collectionViewCatalg.showsHorizontalScrollIndicator = false
        
        tableYoung = UITableView(frame: CGRect.zero)

        tableYoung?.translatesAutoresizingMaskIntoConstraints = false
        tableYoung?.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableYoung?.delegate = self
        tableYoung?.dataSource = self
        tableYoung?.register(InfoView_Cell.self, forCellReuseIdentifier: "cell")
        tableYoung?.separatorColor = UIColor.clear
        tableYoung?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        costmSgmtCotroller = CustomSegmentController(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0), sgmTitles: arTitles.map({ $0.getLocatizedString() }))
        costmSgmtCotroller.backgroundColor = .clear
        costmSgmtCotroller.delegate = self
        costmSgmtCotroller.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        guard let tableYoung = tableYoung,
              let searchField = searchField else {
            return
        }

        self.view.addSubview(costmSgmtCotroller)
        self.view.addSubview(searchField)
        self.view.addSubview(tableYoung)
        self.view.addSubview(collectionViewCatalg)
        
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: 50),
            searchField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            searchField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16.3),
            searchField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16.3),
            
            collectionViewCatalg.heightAnchor.constraint(equalToConstant: 65),
            collectionViewCatalg.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 4),
            collectionViewCatalg.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            collectionViewCatalg.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            
            costmSgmtCotroller.heightAnchor.constraint(equalToConstant: 50),
            costmSgmtCotroller.topAnchor.constraint(equalTo: collectionViewCatalg.bottomAnchor, constant: 4),
            costmSgmtCotroller.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            costmSgmtCotroller.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            
            
            tableYoung.topAnchor.constraint(equalTo: costmSgmtCotroller.bottomAnchor, constant: 8),
            tableYoung.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -17),
            tableYoung.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17),
            tableYoung.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 40),
        ])
    }
}
