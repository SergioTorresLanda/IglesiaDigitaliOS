//
//  NewView_Controller.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 01/05/21.
//

import UIKit
import WebKit

struct TableSections {
    var title: String
    var data: [FF_Formation_Entity]
    var collapse: Bool = false
}

class NewView_Controller: UIViewController, WKNavigationDelegate {
    
    private var searchField : UITextField?
    private var tableNew: UITableView?
    private var tableInfoNew: [FF_Formation_Entity]?
    private var tableInfoFeatured: [FF_Formation_Entity]?
    private var tableSection: [TableSections] = []
    private var tableFilterData: [FF_Formation_Entity] = []
    private var onSearch: Bool = false
    private var searchView: NoResults_View?
    private var viewNoResult: NoResults_ViewV2?
    private var imageFooter: UIImageView?
    let imageCached = NSCache<NSString, UIImage>()
    private var segmentSection: Int = 0
    private var stSearch: String? = ""
    private var colorBackground = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    var _presenter: SSVIPER_ViewToPresenterProtocol?
    
    lazy var safeArea = { () -> UILayoutGuide in
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide
        }else{
            return self.view.layoutMarginsGuide
        }
    }()
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle().getBundle(), compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func hideLoading(error: String?){
        if error != nil{
            self.alert.dismiss(animated: false, completion: {
                let errorAlert = UIAlertController(title: "Alerta", message: error!, preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            })
        }else{
            self.alert.dismiss(animated: false, completion: nil)
        }
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UILoader.show()
        self.view.backgroundColor = colorBackground
        let backSearch = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        backSearch.backgroundColor = UIColor.white
        self.view.addSubview(backSearch)
        searchField = Search_TextField(frame: CGRect.zero)
        guard let searchField = searchField else { debugPrint("Can't create searchField"); return }
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.delegate = self
        searchField.placeholder = "formation_button_search".getStringFrom()
        self.view.addSubview(searchField)
        
        tableNew = UITableView(frame: CGRect.zero)
        guard let tableNew = tableNew else { debugPrint("Can't create tableNew"); return }
        
        imageFooter = UIImageView(frame: CGRect.zero)
        guard let imageFooter = imageFooter else { debugPrint("Can't create imageFooter"); return }
        imageFooter.translatesAutoresizingMaskIntoConstraints = false
        imageFooter.image = UIImage(named: "rectNgulo360", in: Bundle(for: FirstMan_Route.self), compatibleWith: nil)
        imageFooter.contentMode = .scaleAspectFit
        
        
        tableNew.delegate = self
        tableNew.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableNew.dataSource = self
        tableNew.register(InfoView_Cell.self, forCellReuseIdentifier: "cell")
        tableNew.separatorColor = UIColor.clear
        tableNew.backgroundColor = colorBackground
        
        
        tableNew.translatesAutoresizingMaskIntoConstraints = false
        tableNew.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        
        let codeSegmented = CustomSegmentController(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0), sgmTitles: ["Uno","Lo más visto"])
         codeSegmented.backgroundColor = .clear
         codeSegmented.delegate = self
        codeSegmented.translatesAutoresizingMaskIntoConstraints = false
         
        view.addSubview(codeSegmented)
       
        self.view.addSubview(tableNew)
        self.view.addSubview(imageFooter)
        
        
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: 50),
            searchField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 60),
            searchField.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -16.3),
            searchField.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 16.3),
            
            tableNew.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 118),
            tableNew.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            tableNew.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            tableNew.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            
            imageFooter.bottomAnchor.constraint(equalTo: codeSegmented.topAnchor, constant: -1),
            imageFooter.widthAnchor.constraint(equalToConstant: 50),
            imageFooter.heightAnchor.constraint(equalToConstant: 5),
            imageFooter.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: (self.view.bounds.width/20)*1.2),
            
            codeSegmented.heightAnchor.constraint(equalToConstant: 50),
            codeSegmented.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 66),
            codeSegmented.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: 0),
            codeSegmented.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 0),
        ])
    
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self._presenter?.getData()
//            self._presenter?.getDataCatalog()
        })
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        var activityIndicator: UIActivityIndicatorView!
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = webView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        webView.addSubview(activityIndicator)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        for view in webView.subviews {
            if view is UIActivityIndicatorView{
                view.removeFromSuperview()
            }
        }
    }
    
    @objc func collapseSection(sender: UIButton){
        tableSection[sender.tag].collapse = !tableSection[sender.tag].collapse
        tableNew?.reloadData()
    }
}

extension NewView_Controller: SSVIPER_PresenterToViewProtocol{
    
    func errorCloseSesion(code: Int?, msg: String?) {
        print("Regreso la data errorCloseSesion")
    }
    
    func successcloseSesion(data: String?, msg: String?) {
        print("Regreso la data successcloseSesion")
    }
    
    func setData(data: FF_FormationObj_Entity){
        DispatchQueue.main.async {
            self.alert.dismiss(animated: false, completion: { [self] in
                UILoader.hide()
                tableSection.append(TableSections(title: "Lo nuevo", data: data.news))
                tableSection.append(TableSections(title: "Lo más visto", data: data.featured))
                tableNew?.reloadData()
            })
        }
    }
    
    func setDataCatalog(data: FF_CatalogObj_Entity) {
        print("Esto imprime aqui en NewView_Controller: \(data.data[0].iconPressedUrl)")
    }
    
    func setDataChild(data: [FF_Formation_Entity]) {
        
    }
    
}

extension NewView_Controller: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !onSearch{
            let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30)
            let footerView = UIView(frame:rect)
            footerView.layer.cornerRadius = 10
            footerView.layer.borderColor = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 246.0 / 255.0, alpha: 1.0).cgColor
            footerView.layer.borderWidth = 1
            footerView.layer.masksToBounds = true
            let titleHeader = UILabel(frame: CGRect.zero)
            let imageArrow = UIButton(frame: CGRect.zero)
            titleHeader.translatesAutoresizingMaskIntoConstraints = false
            imageArrow.translatesAutoresizingMaskIntoConstraints = false
            if tableSection[section].collapse{
                imageArrow.setImage(UIImage(named: "flecha", in: Bundle(for: FirstMan_Route.self), compatibleWith: nil)?.rotate(radians: .pi), for: UIControl.State.normal)
            }else{
                imageArrow.setImage(UIImage(named: "flecha", in: Bundle(for: FirstMan_Route.self), compatibleWith: nil), for: UIControl.State.normal)
            }
            
            imageArrow.tag = section
            imageArrow.addTarget(self, action: #selector(collapseSection(sender:)), for: UIControl.Event.touchUpInside)
            titleHeader.text = tableSection[section].title
            titleHeader.tintColor = UIColor(red: 0.0, green: 33.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
            titleHeader.textColor = UIColor(red: 0.0, green: 33.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
            titleHeader.font = UIFont.boldSystemFont(ofSize: 14)
            footerView.addSubview(titleHeader)
            footerView.addSubview(imageArrow)
            footerView.backgroundColor = UIColor.white
            NSLayoutConstraint.activate([
                imageArrow.widthAnchor.constraint(equalToConstant: 30),
                imageArrow.heightAnchor.constraint(equalToConstant: 30),
                imageArrow.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -10),
                imageArrow.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
                titleHeader.topAnchor.constraint(equalTo: footerView.topAnchor),
                titleHeader.rightAnchor.constraint(equalTo: footerView.rightAnchor),
                titleHeader.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 13),
                titleHeader.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
            ])
            return footerView
        }else{
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !onSearch {
            return .zero
        }else{
            return .zero
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !onSearch {
            return tableSection[segmentSection].data.count
        }else{
            return tableFilterData.count
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !onSearch {
            return tableSection.count > 0 ? 1 : 0
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = tableView.dequeueReusableCell(withIdentifier: "cell") as? InfoView_Cell else {
            return UITableViewCell()
        }
        
        row.backgroundColor = colorBackground
        row.imageViewTitle.image = nil
        row.selectionStyle = UITableViewCell.SelectionStyle.none
        row.tag = indexPath.row
        
        if !onSearch{
            row.details = tableSection[segmentSection].data[indexPath.row].asFormationCell()
            let imageString = tableSection[segmentSection].data[indexPath.row].asFormationCell().image
//            print("La ruta para \(row.details?.title ?? "NA"): -|\(imageString)|-")
            
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
                let youtubeURL = tableSection[segmentSection].data[indexPath.row].url.getYouTubeThubnailFromURL()
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
                let youtubeURL = tableFilterData[indexPath.row].asFormationCell().image.getYouTubeThubnailFromURL()
                DispatchQueue.global(qos: .background).async {
                    let url = URL(string: youtubeURL)
                    let data = try? Data(contentsOf: (url ?? URL(string: "www.com"))!)
                    
                    let image: UIImage = UIImage(data: data ?? Data()) ?? UIImage()
                    DispatchQueue.main.async {
                        self.imageCached.setObject(image, forKey: NSString(string:(youtubeURL)))
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
            let libraryData = tableSection[segmentSection].data[indexPath.row].url
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

extension NewView_Controller: UITextFieldDelegate {
    
    @objc func textFieldActive() {
        if onSearch{
            viewNoResult?.removeFromSuperview()
            tableNew?.isHidden = tableFilterData.count > 0 ? false : true
        }else{
            searchView?.removeFromSuperview()
            let enable = tableFilterData.count > 0 ? true : false
            tableNew?.isHidden = enable
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
        
        tableNew?.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count ?? 0 <= 0{
            onSearch = false
            tableFilterData = []
        }
        textFieldActive()
        tableNew?.reloadData()
        view.endEditing(true)
        return true
    }
    
    func searchFieldUsing(string: String){
        tableNew?.isHidden = false
        onSearch = true
        let datas = tableSection.flatMap { $0.data }
        tableFilterData = datas.filter({ (result) -> Bool in
            return result.title.range(of: string, options: .caseInsensitive) != nil
        })
        textFieldActive()
        tableNew?.reloadData()
    }
    
}

extension String{
    func embedAndPlayYoutubeURL() -> String{
        if self.contains("youtube"){
            return self.replacingOccurrences(of: "watch?v=", with: "embed/") + "?autoplay=1"
        }else{
            return self
        }
    }
    
    func embedYoutubeURL() -> String{
        if self.contains("youtube"){
            return self.replacingOccurrences(of: "watch?v=", with: "embed/")
        }else{
            return self
        }
    }
    
    func getYouTubeThubnailFromURL() -> String{
        var videoID = ""
        videoID = self.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        if self.contains("&list="){
            let array = videoID.components(separatedBy: "&list=")
            if array.count > 0{
                videoID = array[0]
                videoID = "https://img.youtube.com/vi/\(videoID)/0.jpg"
                return videoID
            }else{
                return self
            }
        }else{
            videoID = "https://img.youtube.com/vi/\(videoID)/0.jpg"
            return videoID
        }
    }
}


extension NewView_Controller: CustomSegmentControllerDelegate{
    func change(to index: Int) {
        segmentSection = index
        tableNew?.reloadData()
    }
}
