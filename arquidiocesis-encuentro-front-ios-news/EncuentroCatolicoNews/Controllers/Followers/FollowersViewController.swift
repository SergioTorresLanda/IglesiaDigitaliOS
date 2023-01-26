//
//  FollowersViewController.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//

import UIKit

class FollowersViewController: UIViewController {
    // MARK: Properties
    var presenter: FollowersPresenterProtocol?

    var dispatchGroup = DispatchGroup()
    private let shimmer = Shimmer()
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblNameProfile: UILabel!
    @IBOutlet weak var segmentedControlView: UIStackView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet public weak var loadingView: UIView!
    @IBOutlet public weak var activityIndicator: UIActivityIndicatorView!
    
    var arrFollowers: [Followers] = []
    var arrFollowed: [Followers] = []
    
    var arrInfoToShow: [Followers] = []
    var isFollowers = true
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatchGroup.enter()
        presenter?.viewDidLoad()
        dispatchGroup.enter()
        shimmer.startLoader(view: self.view, rows: [75, 200, 100, 200
                                                    , 220])
        
        tblView.delegate = self
        tblView.dataSource = self

        let nib = UINib(nibName: "FollowersTableViewCell", bundle: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoNews"))
        tblView.register(nib, forCellReuseIdentifier: "FollowersTableViewCell")

        lblNameProfile.text = UserDefaults.standard.string(forKey: "COMPLETENAME")
        
        imgProfile.layer.borderWidth = 0.5
        imgProfile.layer.borderColor = UIColor.black.cgColor
        imgProfile.clipsToBounds = true
        imgProfile.makeRounded()
        
        if let imageData = UserDefaults.standard.data(forKey: "userImage"), let image = UIImage(data: imageData) {
            imgProfile.image = image
        }else{
            imgProfile.image = UIImage(named: "iconProfile", in: Bundle.local, compatibleWith: nil)
        }
        
        dispatchGroup.notify(queue: .main) {
            let codeSegmented = CustomSegmentedControl(frame: CGRect(x: self.segmentedControlView.frame.origin.x, y: self.segmentedControlView.frame.origin.y, width: self.segmentedControlView.frame.width, height: 40), buttonTitle: ["\(self.arrFollowers.count) Seguidores", "\(self.arrFollowed.count) Seguidos"])
            codeSegmented.delegate = self
            codeSegmented.backgroundColor = .clear
            self.segmentedControlView.addArrangedSubview(codeSegmented)
            self.shimmer.stopLoader()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECNews - FollowersVC ")

    }
    
    @IBAction func popView(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        RealmManager.clearDataBase()
    }
    
}

extension FollowersViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInfoToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowersTableViewCell", for: indexPath) as? FollowersTableViewCell
        cell?.setData(follower: arrInfoToShow[indexPath.row], and: indexPath.row)
        cell?.delegate = self
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

extension FollowersViewController: CustomSegmentedControlDelegate{
    func changeToIndex(index: Int) {
        arrInfoToShow.removeAll()
        if index == 0{
            arrInfoToShow = arrFollowers
            isFollowers = true
        }else{
            arrInfoToShow = arrFollowed
            isFollowers = false
        }
        tblView.reloadData()
    }
}

extension FollowersViewController: FollowersCellProtocol{
    func actionSelected(follower: Followers?, and index: Int) {
        arrInfoToShow[index].isFollow = follower?.isFollow ?? false
        if isFollowers{
            arrFollowers[index].isFollow = follower?.isFollow ?? false
        }else{
            arrFollowed[index].isFollow = follower?.isFollow ?? false
        }
        guard let follower = follower else {
            return
        }
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        presenter?.followAndUnFollowedService(follower: follower)
    }
}

extension FollowersViewController: FollowersViewProtocol {
    
    func followServiceSuccess() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.activityIndicator.stopAnimating()
        }
       
        print("TODO OK")
    }
    
    func followServiceError(with error: SocialNetworkErrors) {
        loadingView.isHidden = true
        activityIndicator.stopAnimating()
        print("FALLÓ ALGO")
    }
    
    func loadFollowers(followers: [Followers]) {
        print("FOLLOWERS")
        print(followers)
        arrFollowers = followers
        arrInfoToShow = arrFollowers
        
        tblView.reloadData()
        dispatchGroup.leave()
    }
    
    func loadFollowed(followeds: [Followers]) {
        print("FOLLOWEDS")
        print(followeds)
        arrFollowed = followeds
        dispatchGroup.leave()
    }
}
