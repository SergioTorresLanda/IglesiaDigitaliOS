//
//  ViewBibliotecaRecursos.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation
import UIKit


class BlibliotecaRecursosView: UIViewController {
    var presenter: BibliotecaRecursosPresenterProtocol?
    let cellIdDestacados = "cellId"
    let cellIdCategorias = "cellId2"
    let cellTable = "cellTable"
    var dataSource: LibraryResourcesResponse?
    var dataSourceCategorias: [Category] = []
    var dataSourceDestacados: [Featured] = []
    var dataSourceNews: [Featured] = []
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)

    var vistasNews: [UIView] = []
    var activityView: UIActivityIndicatorView?
    
    var dataSourceSearch: [LibrarySearchResponse] = []
    
    //UiPageControl
    
    let scrollViewPage = UIScrollView(frame: CGRect(x:0, y: 30, width: 600,height: 270))
    
         var colors:[UIColor] = [UIColor.black, UIColor.blue, UIColor.green]
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
       
    var imagenes: [UIView] = []
    
    
    let blueColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
    let goldenColor = UIColor(red: 190 / 255, green: 169 / 255, blue: 120 / 255, alpha: 1.0)
    
    let img1D = UIImage(named: "img1", in: Bundle.local, compatibleWith: nil)
    let img2D = UIImage(named: "img2", in: Bundle.local, compatibleWith: nil)
    
    let img1C = UIImage(named: "img2", in: Bundle.local, compatibleWith: nil)
    let img2C = UIImage(named: "img3", in: Bundle.local, compatibleWith: nil)
    
   // let imgPapa = UIImage(named: "papa", in: Bundle.local, compatibleWith: nil)
    

    lazy var  navImageBackground : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "navbar_image", in: Bundle.local, compatibleWith: nil)
        img.clipsToBounds = false
        img.contentMode = .scaleAspectFill
        return img
        
    }()
    
    lazy var btnBack: UIButton =  {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popViewBibliotecaRecursos), for: .touchUpInside)
        return button
    }()
    
    

    lazy var lblNav : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Formacion"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    
    lazy var tableSearchBar: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 150, width: self.view.frame.width, height: 650))
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = UITableViewCell.SeparatorStyle.none
        return table
        
    }()
    
    lazy var searchBarF: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 105, width: self.view.frame.width, height: self.view.frame.height-20))
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "¿Qué te interesa?"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        let imageView = UIImageView(image: UIImage(named: "Icono_buscar"))
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.rightView = imageView
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.rightViewMode = UITextField.ViewMode.always
        } else {
            // Fallback on earlier versions
        }
        
        return searchBar
    }()
    
    lazy var pageControl: UIPageControl = {
       let page = UIPageControl()
        page.translatesAutoresizingMaskIntoConstraints = false
        page.numberOfPages = 3
        page.currentPage = 0
        page.tintColor = UIColor.red
        page.pageIndicatorTintColor = .white
        page.currentPageIndicatorTintColor = goldenColor
        
        return page
    }()
    
    
    
    lazy var collectionViewDestacados: UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: lay)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.clipsToBounds = true
        collection.register(CustomCellDestacados.self, forCellWithReuseIdentifier: cellIdDestacados)
        collection.decelerationRate = UIScrollView.DecelerationRate.fast
        collection.contentInsetAdjustmentBehavior = .never
        return collection

    }()
    
    
    lazy var collectionViewCategorias: UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: lay)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.clipsToBounds = true
        collection.register(CustomCellCategorias.self, forCellWithReuseIdentifier: cellIdCategorias)
        collection.decelerationRate = UIScrollView.DecelerationRate.fast
        collection.contentInsetAdjustmentBehavior = .never
        return collection

    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: 20, height: 1000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var lblDestacados: UILabel = {
        let label = UILabel()
        label.text = "Destacados"
        label.textColor = blueColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    lazy var lblCategorias: UILabel = {
        let label = UILabel()
        label.text = "Categorias"
        label.textColor = blueColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
      
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.showActivityIndicator()
        self.showLoading()
        self.presenter?.getDataHome()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavAndSearch()
        
        
       
       
    }
    
    
    
    private func setNavAndSearch() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.navImageBackground)
        self.view.addSubview(self.btnBack)
        self.view.addSubview(self.lblNav)
        self.view.addSubview(self.searchBarF)
       
        self.tableSearchBar.register(UITableViewCell.self, forCellReuseIdentifier: cellTable)

        
        self.navImageBackground.topAnchor(equalTo: view.topAnchor, constant: -5)
        self.navImageBackground.widthAnchor(equalTo: view.frame.width + 60)
        self.navImageBackground.heightAnchor(equalTo: 125)
        self.navImageBackground.centerXAnchor(equalTo: view.centerXAnchor)

        
        self.btnBack.centerYAnchor(equalTo: navImageBackground.centerYAnchor, constant: 4)
        self.btnBack.leadingAnchor(equalTo: view.leadingAnchor, constant: 30)
        self.btnBack.widthAnchor(equalTo: 35)
        self.btnBack.heightAnchor(equalTo: 40)

        self.lblNav.centerXAnchor(equalTo: navImageBackground.centerXAnchor)
        self.lblNav.centerYAnchor(equalTo: navImageBackground.centerYAnchor, constant: 4)
        
        
    }
    private func initUI() {
        
        self.view.addSubview(scrollView)
    
        self.collectionViewCategorias.delegate = self
        self.collectionViewDestacados.delegate = self
        self.collectionViewDestacados.dataSource = self
        self.collectionViewCategorias.dataSource = self
        
        self.scrollView.delegate = self
       //
        self.setConstraints()
        self.setPager()
    }
    
    
//    func showActivityIndicator() {
//        if #available(iOS 13.0, *) {
//            activityView = UIActivityIndicatorView(style: .large)
//        } else {
//            // Fallback on earlier versions
//        }
//        activityView?.center = self.view.center
//        self.view.addSubview(activityView!)
//        activityView?.startAnimating()
//    }
//
//    func hideActivityIndicator(){
//        if (activityView != nil){
//            activityView?.stopAnimating()
//        }
//    }
    
    func showLoading(){
            let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
            imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
            loadingAlert.view.addSubview(imageView)
            self.present(loadingAlert, animated: true, completion: nil)
        }
        
        func hideLoading(){
            loadingAlert.dismiss(animated: true, completion: nil)
        }
    
    
    private func hideorShowElements(hide: Bool)
    {
        self.collectionViewDestacados.isHidden = hide
        self.collectionViewCategorias.isHidden = hide
        self.pageControl.isHidden = hide
        self.scrollViewPage.isHidden = hide
        self.lblDestacados.isHidden = hide
        self.lblCategorias.isHidden = hide
        
    }
    
    private func isSuccessHome(){
        self.dataSourceCategorias = self.dataSource?.categories ?? []
        self.dataSourceDestacados = self.dataSource?.featured ?? []
        self.dataSourceNews = self.dataSource?.news ?? []
        self.collectionViewDestacados.reloadData()
        self.collectionViewCategorias.reloadData()
        self.initUI()
    }
    
    private func isSuccesSearch() {
        self.initUI()
        self.tableSearchBar.reloadData()
        self.tableSearchBar.isHidden = false
        self.collectionViewDestacados.reloadData()
        self.collectionViewCategorias.reloadData()
       
    }
    
    private func setPager(){
        let pages = self.dataSourceNews.count
        scrollViewPage.delegate = self
        scrollViewPage.isPagingEnabled = true
        
        
        let frameView = CGRect(x: 0, y: 0, width: self.view.bounds.width,height: 300)
        _ = self.dataSourceNews.map({
            self.vistasNews.append(ViewCustomNews.init(frame: frameView, data: $0))
        })
        
        self.scrollView.addSubview(scrollViewPage)
        for index in 0..<pages {
            
            frame.origin.x = self.scrollViewPage.frame.size.width * CGFloat(index)
            frame.size = self.scrollViewPage.frame.size
            
            let subView = UIView(frame: frame)
            let vista = self.vistasNews[index]
            vista.contentMode = .scaleAspectFill
            subView.addSubview(vista)
            // subView.backgroundColor = colors[index]
            self.scrollViewPage .addSubview(subView)
        }

        self.scrollViewPage.contentSize = CGSize(width:self.scrollViewPage.frame.size.width * CGFloat(pages) ,height: self.scrollViewPage.frame.size.height - 20)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        scrollView.addSubview(self.pageControl)
      
        self.pageControl.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 0).isActive = true
        self.pageControl.topAnchor.constraint(equalTo: self.scrollViewPage.topAnchor, constant: 207).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.pageControl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    
    private func setNews() {
       
       
    }
    
    @objc func changePage(sender: AnyObject) -> () {
            let x = CGFloat(pageControl.currentPage) * scrollViewPage.frame.size.width
            scrollViewPage.setContentOffset(CGPoint(x:x, y:0), animated: true)
        }
    
    private func setConstraints() {
       
       
        self.scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        
    
        //Destacados
        self.scrollView.addSubview(self.lblDestacados)
        self.scrollView.addSubview(self.collectionViewDestacados)
       
    
        lblDestacados.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lblDestacados.widthAnchor.constraint(equalToConstant:300).isActive = true
        lblDestacados.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor,constant: 10).isActive = true
        lblDestacados.topAnchor.constraint(equalTo: self.scrollView.centerYAnchor, constant: 10).isActive = true

        self.collectionViewDestacados.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.collectionViewDestacados.widthAnchor.constraint(equalToConstant: 400 ).isActive = true
        self.collectionViewDestacados.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor, constant: 5).isActive = true
        self.collectionViewDestacados.topAnchor.constraint(equalTo: self.lblDestacados.bottomAnchor, constant:7).isActive = true
      
        
        //Categorias
        self.scrollView.addSubview(self.lblCategorias)
        self.scrollView.addSubview(self.collectionViewCategorias)
       
       
        
        self.lblCategorias.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.lblCategorias.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.lblCategorias.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor,constant: 10).isActive = true
        self.lblCategorias.topAnchor.constraint(equalTo: self.collectionViewDestacados.bottomAnchor , constant: 20).isActive = true
       
        self.collectionViewCategorias.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.collectionViewCategorias.widthAnchor.constraint(equalToConstant: 400 ).isActive = true
        self.collectionViewCategorias.topAnchor.constraint(equalTo: self.lblCategorias.bottomAnchor, constant: 10).isActive = true
        self.collectionViewCategorias.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor, constant: 13).isActive = true
//
       

        self.hideorShowElements(hide: false)
        self.view.addSubview(self.tableSearchBar)
        
        
        self.tableSearchBar.isHidden = true
        
    }
    
    @objc func popViewBibliotecaRecursos() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


extension BlibliotecaRecursosView: BibliotecaRecursosViewProtocol {
    func showResultSearch(result: [LibrarySearchResponse]) {
//        self.hideActivityIndicator()
        self.hideLoading()
        self.dataSourceSearch = result
        self.isSuccesSearch()
        
    }
    
    func showError(_ error: String) {
//        self.hideActivityIndicator()
        self.hideLoading()
    }
    
    func showResult(result: LibraryResourcesResponse) {
//        self.hideActivityIndicator()
        self.hideLoading()
        self.dataSource = result
        self.isSuccessHome()
    }
    
 
   
    
    
}
extension BlibliotecaRecursosView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if textSearched.count > 1 {
           
//            let cBtn = searchBar.value(forKey: "cancelButton") as! UIButton
//            cBtn.setTitle("Buscar", for: .normal)
            self.hideorShowElements(hide: true)
//            self.showActivityIndicator()
            self.showLoading()
            self.presenter?.getDataSearch(text: textSearched)
        }
        
        if textSearched.count == 0{
            self.tableSearchBar.isHidden = true
        }
       
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
    }
    
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.hideorShowElements(hide: true)
//        self.showActivityIndicator()
        self.showLoading()
        self.presenter?.getDataHome()
        self.tableSearchBar.isHidden = true
    }
}

extension BlibliotecaRecursosView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewDestacados {
            return self.dataSourceDestacados.count
        }
        else {
            return self.dataSourceCategorias.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewDestacados {
            let cell = self.collectionViewDestacados.dequeueReusableCell(withReuseIdentifier: cellIdDestacados, for: indexPath) as! CustomCellDestacados
           
            let colorBorder = UIColor(red: 227 / 255, green: 227 / 255, blue: 227 / 255, alpha: 1.0)
            cell.backgroundColor = .white
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 2
            cell.layer.borderColor = colorBorder.cgColor
            cell.layer.masksToBounds = false
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width: 0.5, height: 1.0)
            cell.layer.shadowRadius = 0.2
            cell.layer.shadowOpacity = 0.2
            cell.configure(data: dataSourceDestacados[indexPath.row])
            return cell
            }
                
        else {
           
            let cell = self.collectionViewCategorias.dequeueReusableCell(withReuseIdentifier: cellIdCategorias, for: indexPath) as! CustomCellCategorias
            cell.configure(data: dataSourceCategorias[indexPath.row])
            return cell
            }
        
        
        
        }
          
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionViewDestacados {
            let id = self.dataSourceDestacados[indexPath.row].id ?? 0
            let view = LibraryAndResourcesRouter.createModule(contentID: id)
            self.navigationController?.pushViewController(view, animated: true)
           //Llamamamos router de detalle
        } else {
            let id = self.dataSourceCategorias[indexPath.row].code ?? ""
            let view = CategoriesRouter.createModule(category: id)
            self.navigationController?.pushViewController(view, animated: true)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.collectionViewDestacados {
            return CGSize(width: 200, height: 192)
        } else {
            return CGSize(width: 240, height: 236)
        }
       
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    }
    

    
}
 
extension BlibliotecaRecursosView : UIScrollViewDelegate {
func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
    self.pageControl.currentPage = Int(pageNumber)
    }

}

extension BlibliotecaRecursosView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .subtitle, reuseIdentifier: cellTable)

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataSourceSearch[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchBarF.text = self.dataSourceSearch[indexPath.row].name
        let id = self.dataSourceSearch[indexPath.row].id
        let view = LibraryAndResourcesRouter.createModule(contentID: id)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
}
