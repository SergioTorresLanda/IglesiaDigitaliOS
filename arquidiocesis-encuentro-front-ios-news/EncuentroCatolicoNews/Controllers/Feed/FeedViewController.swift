//
//  FeedViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 01/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import RealmSwift
import EncuentroCatolicoProfile

protocol FeedViewControllerDelegate{
    func reloadTblData()
}

public class FeedViewController: UIViewController, FeedViewProtocol, FeedViewControllerDelegate {
    
    var presenter: FeedPresenterProtocol?
    let shimmer = Shimmer()
    
    //MARK: - @IBoutlets
    @IBOutlet public weak var notificationView: UIView!
    @IBOutlet public weak var tableView: UITableView! {
        didSet { tableView.tableFooterView = UIView() }
    }
    @IBOutlet weak var barraNavegacion: UIView!
    @IBOutlet weak var txfSearch: UITextField!
    @IBOutlet weak var btnCreatePost: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewS: UIView!
    
    
    @IBOutlet weak var btnGoTo: UIButton!
    @IBOutlet public weak var notificationImage: UIImageView!  = {
        let imageView = UIImageView()
        imageView.image = "Notification".getImage()
        
        return imageView
    }()
    
    //MARK: - Properties
    private let refreshControl = UIRefreshControl()
    public var isPrefetching = false
    let name = UserDefaults.standard.string(forKey: "COMPLETENAME")
    let image = UserDefaults.standard.data(forKey: "userImage")
    
    public var posts: [PublicationRealm]? {
        didSet { tableView.reloadData() }
    }
    
    var newPosts = [Posts]()
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationFeed"), object: nil)
        
        setUpView()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC ECNews - FeedVC ")
        setupTabBar()
        presenter?.getNewPosts(isFromPage: false, isRefresh: false)
    }

    //MARK: - Methods
    func setupTabBar(){
        let tabBar = self.tabBarController as? SocialNetworkController
        tabBar?.tabBar.isHidden = true
        tabBar?.customTabBar.isHidden = false
    }
    
    func startShimmer(){
        shimmer.startLoader(view: viewS, rows: [100, 200, 100, 200, 100])
    }
    
    private func setUpView() {
        
        let img = UIImage(named: "iconSearch", in: Bundle(for: FeedViewController.self), compatibleWith: nil)
        setPaddingWithImage(image: img ?? UIImage(), textField: txfSearch)
        imgProfile.layer.borderWidth = 0.5
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.clipsToBounds = true
        imgProfile.makeRounded()
        imgProfile.setImage(name: name, image: nil)
        btnCreatePost.setTitle("", for: .normal)
        barraNavegacion.layer.cornerRadius = 30
        barraNavegacion.layer.shadowRadius = 5
        barraNavegacion.layer.shadowOpacity = 0.5
        barraNavegacion.layer.shadowColor = UIColor.black.cgColor
        barraNavegacion.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        if let imageString = UserDefaults.standard.string(forKey: "imageUrl") {
                    imgProfile.loadS(urlS:imageString)
                }
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        tableView.addSubview(refreshControl)
        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "FeedTVC", bundle: Bundle(for: FeedTVC.self)), forCellReuseIdentifier: "FeedTVC")
        tableView.register(UINib(nibName: "createPostTVC", bundle: Bundle(for: CreatePostTVC.self)), forCellReuseIdentifier: "CreatePostTVC")
    }
    
    
    func setPaddingWithImage(image: UIImage, textField: UITextField){
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let viewR = UIView(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        imageView.frame = CGRect(x: 13.0, y: 13.0, width: 25.0, height: 25.0)
        let seperatorView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 47))
        seperatorView.backgroundColor = UIColor.clear
        textField.leftViewMode = .always
        viewR.addSubview(imageView)
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = seperatorView
        textField.rightViewMode = UITextField.ViewMode.always
        textField.rightView = viewR
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        storedData.skip = 0
        startShimmer()
        presenter?.getNewPosts(isFromPage: false, isRefresh: true) //--> Nuevo
    }
    
    func didFinishGettingPosts(isFromPage: Bool, posts: [Posts]) {
        if isFromPage {
            isPrefetching = false
        } else {
            refreshControl.endRefreshing()
        }
        shimmer.stopLoader()
        
        newPosts = posts
        tableView.reloadData()
        //posts = retrieveFromRealm()
    }
    
    func didFinishGettingPostsWithErrors(error: SocialNetworkErrors) {
        posts = retrieveFromRealm()
        refreshControl.endRefreshing()
        shimmer.stopLoader()
    }
    
    func didFinishGettingNotifications(notificationsCount: String?) {
        notificationView.addbadge(text: notificationsCount)
    }
    
    // GGG --> Obtiene de base datos
    private func retrieveFromRealm() -> [PublicationRealm]? {
        let results = RealmManager.fetchDataSorted(object: PublicationRealm.self)
        return results
    }
    
    //MARK: - Actions
    @IBAction private func popView(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        RealmManager.clearDataBase()
    }
    
    @IBAction func goToFollow(_ sender: Any) {
        self.navigationController?.pushViewController(FollowersWireFrame.createFollowersModule(), animated: true)
    }
    
    
    @IBAction private func showNotifications(_ sender: UIButton) {
        let vc = NotificationsRouter.createModule()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @available(iOS 13.0, *)
    @IBAction func goToSearch(_ sender: Any) {
        let view = SocialSearchRouter.createModule()
        self.view.endEditing(true)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    
    @IBAction func btnActionCreatePost(_ sender: UIButton) {
        let view = CreatePostViewController.showModalPost(type: "Crear")
        view.transitioningDelegate = self
        view.delegateTbl = self
        self.present(view, animated: true, completion: nil)
    }
    
    func reloadTblData() {
        //self.presenter?.getNewPosts(isFromPage: false, isRefresh: true)
        tableView.reloadData()
    }
}

