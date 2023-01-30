//
//  ChurchViewController.swift
//  Terrabite
//
//  Created by Diego Luna on 06/01/21.
//

//import Foundation
//import UIKit
//
//protocol ChurchViewControllerProtocol: AnyObject {
//    func reloadChurches()
//}
//
//class ChurchViewController: UIViewController {
//    private let presenter: ChurchPresenterProtocol
//    private let refresh = UIRefreshControl()
//    private var timer = Timer()
//    private let identifierCell = "ChurchCell"
//
//    @IBOutlet private var searchView: UIView! {
//        didSet {
//            searchView.backgroundColor = Style.secondary.lightGray
//            searchView.setupRoundedCorners(radius: 24)
//        }
//    }
//
//    @IBOutlet private var searchTextField: UITextField! {
//        didSet {
//            searchTextField.delegate = self
//        }
//    }
//
//    @IBOutlet private var searchImageView: UIImageView!
//    @IBOutlet private var collectionView: UICollectionView!
//
//    init(presenter: ChurchPresenterProtocol) {
//        self.presenter = presenter
//        super.init(nibName: String(describing: ChurchViewController.self), bundle: .local)
//        self.presenter.setViewProtocol(self)
//    }
//
//    deinit {
//        debugPrint("dealloc ChurchViewController")
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupCollection()
//        hideKeyboardWhenTappedAround()
//        pullToRefresh()
//    }
//
//    private func setupTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1.5,
//                                     target: self,
//                                     selector: #selector(loadData),
//                                     userInfo: nil, repeats: false)
//    }
//
//    private func setupCollection() {
//        let nibPreview = UINib(nibName: identifierCell, bundle: .local)
//        refresh.tintColor = .black
//        refresh.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
//        collectionView.alwaysBounceVertical = true
//        collectionView.register(nibPreview, forCellWithReuseIdentifier: identifierCell)
//        collectionView.addSubview(refresh)
//        pullToRefreshAnimation()
//    }
//
//    private func pullToRefreshAnimation() {
//        refresh.beginRefreshing()
//        collectionView.setContentOffset(CGPoint(x: 0, y: -refresh.frame.height),
//                                        animated: true)
//    }
//
//    /// This function reload the data in the UICollectionView and start a visual animation.
//    @objc
//    func pullToRefresh() {
//        pullToRefreshAnimation()
//        loadData()
//    }
//
//    @objc
//    func loadData() {
//        let input = searchTextField.text
//        presenter.getListChurch(input: input?.isEmpty ?? true ? nil : input)
//    }
//
//    @objc
//    func closeScreen() {
//    }
//}
//
//extension ChurchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 81)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter.churches.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let church = presenter.churches[safe: indexPath.item],
//              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell,
//                                                            for: indexPath) as? ChurchCell else {
//            return ChurchCell()
//        }
//        cell.setup(church: church)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // Open here church detail
//    }
//}
//
//extension ChurchViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField.text?.count ?? 0 > 1 { pullToRefreshAnimation() }
//        timer.invalidate()
//        setupTimer()
//        return true
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        view.endEditing(true)
//        loadData()
//        return true
//    }
//}
//
//extension ChurchViewController: ChurchViewControllerProtocol {
//    func reloadChurches() {
//        DispatchQueue.main.async { [weak self] in
//            self?.collectionView.reloadData()
//            self?.refresh.endRefreshing()
//        }
//    }
//}
//
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
//
//    @IBAction func backToView(_ sender: UIButton) {
//        _ = navigationController?.popViewController(animated: true)
//    }
//}
