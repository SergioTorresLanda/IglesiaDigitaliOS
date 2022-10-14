//
//  DetailPostViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Alamofire
import AVFoundation

public class DetailPostViewController: UIViewController, DetailPostViewProtocol {
        
    var presenter: DetailPostPresenterProtocol?
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var lblTitle: UILabel!
    @IBOutlet public weak var tableView: UITableView! {
        didSet { tableView.tableFooterView = UIView() }
    }
    
    @IBOutlet public weak var backImage: UIImageView!  = {
        let imageView = UIImageView()
        imageView.image = "backIcon".getImage()
        
        return imageView
    }()
    
    //MARK: - Properties
    override public var canBecomeFirstResponder: Bool { return true }
//    public var commentsAccesory: CommentsAccesoryView?
    private let refreshControl = UIRefreshControl()
    public var post = PublicationRealm()
    private let shimmer = Shimmer()
    
    public var topReactions: TopReactions? {
        didSet { tableView.reloadSections([0], with: .none) }
    }
    
    public var comments: Comments? {
        didSet { tableView.reloadSections([1, 2], with: .none) }
    }
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
//        presenter?.getComments(postId: post.id, isFromRefresh: false)
        presenter?.getTopReactions(postId: post.id)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabBar = self.tabBarController as? SocialNetworkController
        tabBar?.tabBar.isHidden = true
        tabBar?.customTabBar.isHidden = true
    }
    
//    override public var inputAccessoryView: UIView? {
//        if commentsAccesory == nil {
//            commentsAccesory = CommentsAccesoryView()
//            commentsAccesory?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
//            commentsAccesory?.textView.delegate = self
//        }
//        
//        return commentsAccesory
//    }
    
    //MARK: - Methods
    private func setUpView() {
        shimmer.startLoader(view: view, rows: [45, 375, 100, 100, 100, 100])
        
        lblTitle.text = "Noticias"
        
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "DetailPostTVC", bundle: Bundle(for: DetailPostTVC.self)), forCellReuseIdentifier: "DetailPostTVC")
        tableView.register(UINib(nibName: "PostDetailCommentTVC", bundle: Bundle(for: PostDetailCommentTVC.self)), forCellReuseIdentifier: "PostDetailCommentTVC")
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
//        presenter?.getComments(postId: post.id, isFromRefresh: true)
//        shimmer.startLoader(view: view, rows: [375, 100, 100, 100, 100])
        refreshControl.endRefreshing()
    }
    
    //MARK: - CommentsSuccess
    func didFinishGettingComments(comments: Comments, pages: Int, total: Int, isFromRefresh: Bool) {
        if isFromRefresh {
            refreshControl.endRefreshing()
        }
        
        self.comments = comments
        shimmer.stopLoader()
    }
    
    func didFinishGettingTopReactions(topReactions: TopReactions) {
        self.topReactions = topReactions
        shimmer.stopLoader()
    }
    
    //MARK: - Errors
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors) {
        print(error.message)
    }
    
    func didFinishGettingTopReactionsWithErrors(error: SocialNetworkErrors) {
        print(error.message)
    }
    
    //MARK: - Actions
    @IBAction private func popView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - UITextViewDelegate
extension DetailPostViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
}
