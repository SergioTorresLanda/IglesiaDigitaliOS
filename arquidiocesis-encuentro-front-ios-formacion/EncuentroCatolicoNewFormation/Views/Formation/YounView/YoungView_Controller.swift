//
//  YoungView_Controller.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 02/05/21.
//

import UIKit
import EncuentroCatolicoUtils

class YoungView_Controller: UIViewController {
    //MARK: - Protocol Properties
    var _presenter: FYV_VIPER_ViewToPresenterProtocol?
    
    //MARK: - Properties
    private let searchField : Search_TextField = Search_TextField()
    private var arGeneralSection: [TableYoungSection] = [] {
        didSet {
            updateFormations()
        }
    }
    private var strCodeCatalog = ""
    
    private let collectionViewCatalg: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CatalogCell.self, forCellWithReuseIdentifier: "CatalogCell")
        return cv
    }()
    
    private lazy var safeArea = { () -> UILayoutGuide in
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide
        }
        
        return self.view.layoutMarginsGuide
    }()
    
    private var arrCatalogo = [FF_Catalog_Entity]()

    private let tableYoung: UITableView = UITableView(frame: CGRect.zero)
    private var imageFooter: UIImageView?
    
    private var sgmSelection: ECNFFormationType? {
        didSet {
            defer {
                updateFormations()
            }
            
            guard let sgmSelection = sgmSelection else {
                return
            }
            
            fileTypeList.setSelected(sgmSelection)
        }
    }
    
    private var sgmSelectionIndex: Int {
        arGeneralSection.firstIndex(where: { $0.title == sgmSelection?.rawValue ?? "" }) ?? -1
    }
    private var strTypeComponents: String? = ""
    private var arTitles: [ECNFFormationType] = ECNFFormationType.allCases {
        didSet {
            guard oldValue != arTitles else {
                return
            }
            
            fileTypeList.options = arTitles
            sgmSelection = arTitles.first
        }
    }
    
    private var formations: [FF_Formation_Entity] = [] {
        didSet {
            tableYoung.reloadData()
        }
    }
    private let fileTypeList = ECNFFileTypeList()
    private var colorBackground = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    //MARK: - Events
    @objc func onChangeFilter(_ sender: UITextField) {
        searchField.closeButton?.isHidden = sender.text?.trimmingCharacters(in: [" "]) ?? "" == ""
        updateFormations()
    }
}

//MARK: - FYV_VIPER_PresenterToViewProtocol
extension YoungView_Controller: FYV_VIPER_PresenterToViewProtocol {
    func setDataCatalog(data: [FF_Catalog_Entity]) {
        self.arrCatalogo = data
        
        setCatalog(codeCatalog: arrCatalogo[safe: 0]?.code ?? "")
    }
    
    func setDataChild(data: [FF_Formation_Entity]) {
        self.arGeneralSection = Dictionary(grouping: data, by: { strCodeCatalog == "OUTSTANDING" ? ECNFFormationType.newest.rawValue : $0.type })
            .map { TableYoungSection(title: $0.key, data: $0.value) }
        
        self.hideSpinner()
        self.tableYoung.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension YoungView_Controller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableYoung.backgroundView = formations.count == 0 ? viewNoResultV2(bSearch: false) : nil
        
        return formations.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = tableView.dequeueReusableCell(withIdentifier: "cell") as? InfoView_Cell,
              let sgmSectionData = formations[safe: indexPath.row] else {
            return UITableViewCell()
        }

        row.backgroundColor = colorBackground
        row.details = sgmSectionData.asFormationCell()

        let imageString = sgmSectionData.asFormationCell().image.trimmingCharacters(in: [" "])

        guard let imgUrl = URL(string: imageString) ?? URL(string: sgmSectionData.url.getYouTubeThubnailFromURL()) else {
            row.imageViewTitle.image = UIImage(named: "iglesiaDigital", in: Bundle().getBundle(), compatibleWith: nil)
            return row
        }
        
        if imageString == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_file.png" {
            row.imageViewTitle.image = UIImage(named: "pdf", in: Bundle().getBundle(), compatibleWith: nil)
        } else if imageString == "https://arquidiocesis-app-mx.s3.amazonaws.com/ICONOS/BIBLIOTECA/icon_link.png"{
            row.imageViewTitle.image = UIImage(named: "link", in: Bundle().getBundle(), compatibleWith: nil)
        } else {
            row.imageViewTitle.setCacheImage(with: imgUrl)
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate
extension YoungView_Controller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let libraryDataURL = formations[safe: indexPath.row]?.url,
              let url = URL(string: libraryDataURL) ?? URL(string: libraryDataURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else {
            return
        }
        
        
        let view = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle().getBundle())
        
        view.screenURL = url.absoluteString
        
        self.navigationController?.pushViewController(view, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension YoungView_Controller: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

//MARK: - ECNFFileTypeDelegate
extension YoungView_Controller: ECNFFileTypeDelegate {
    func fileTypeList(didSelect option: ECNFFormationType) {
        sgmSelection = option
    }
}

//MARK: - NavigationDelegationAction
extension YoungView_Controller: NavigationDelegationAction{
    func getAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension YoungView_Controller: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 65, height: collectionViewCatalg.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrCatalogo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let item = self.arrCatalogo[safe: indexPath.row],
              let cell = collectionViewCatalg.dequeueReusableCell(withReuseIdentifier: "CatalogCell", for: indexPath) as? CatalogCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = UIColor.white
        cell.setData(data: item, strCode: strCodeCatalog)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let code = arrCatalogo[safe: indexPath.row]?.code else {
            return
        }
        
        _presenter?.showSpinner()
        setCatalog(codeCatalog: code)
    }
}

//MARK: - Private functions
extension YoungView_Controller {
    private func viewNoResultV2(bSearch: Bool) -> UIView {
        let view = NoResults_View(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        view.details = NoResults(imageDefault: nil,
                                 textSearch: (searchField.text?.trimmingCharacters(in: [" "]) ?? "") == "" ? nil :
                                    String(format: "formation_empty_view_for".localized, searchField.text?.trimmingCharacters(in: [" "]) ?? ""))
        
        return view
    }
    
    private func updateFormations() {
        let filterString = searchField.text?.folding(options: .diacriticInsensitive, locale: nil)
            .lowercased()
            .trimmingCharacters(in: [" "]) ?? ""

        guard let sectionData = arGeneralSection[safe: sgmSelectionIndex]?.data else {
            formations = []
            return
        }
        
        formations = filterString == "" ? sectionData : sectionData.filter({
            $0.title
                .folding(options: .diacriticInsensitive, locale: nil)
                .lowercased()
                .trimmingCharacters(in: [" "])
                .contains(filterString)
        })
    }
    
    private func setCatalog(codeCatalog: String) {
        strCodeCatalog = codeCatalog
        arTitles = ECNFFormationType.getTypesByCatalog(by: codeCatalog)
        collectionViewCatalg.reloadData()
        arGeneralSection.removeAll()
        
        _presenter?.getData(strTypeCatalog: strCodeCatalog)
    }
    
    private func setUpView() {
        setUpNavigation()
        _presenter?.showSpinner()
        setupUI()
        setupConstraints()
        arrCatalogo.isEmpty ? self._presenter?.getCatalogData() : _presenter?.getData(strTypeCatalog: strCodeCatalog)
    }
    
    private func setupUI() {
        self.view.backgroundColor = colorBackground

        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.delegate = self
        searchField.placeholder = "formation_button_search".getStringFrom()
        
        collectionViewCatalg.backgroundColor = .white
        collectionViewCatalg.delegate = self
        collectionViewCatalg.dataSource = self
        collectionViewCatalg.showsHorizontalScrollIndicator = false
        
        tableYoung.translatesAutoresizingMaskIntoConstraints = false
        tableYoung.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        tableYoung.delegate = self
        tableYoung.dataSource = self
        tableYoung.register(InfoView_Cell.self, forCellReuseIdentifier: "cell")
        tableYoung.separatorColor = UIColor.clear
        tableYoung.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableYoung.backgroundColor = colorBackground
        
        fileTypeList.backgroundColor = .clear
        fileTypeList.delegate = self
        fileTypeList.translatesAutoresizingMaskIntoConstraints = false
        
        searchField.addTarget(self, action: #selector(onChangeFilter(_:)), for: .editingChanged)
    }
    
    private func setupConstraints() {
        self.view.addSubview(fileTypeList)
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
            
            fileTypeList.heightAnchor.constraint(equalToConstant: 50),
            fileTypeList.topAnchor.constraint(equalTo: collectionViewCatalg.bottomAnchor, constant: 4),
            fileTypeList.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            fileTypeList.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
            
            
            tableYoung.topAnchor.constraint(equalTo: fileTypeList.bottomAnchor, constant: 8),
            tableYoung.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -17),
            tableYoung.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 17),
            tableYoung.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90),
        ])
    }
    
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
}
