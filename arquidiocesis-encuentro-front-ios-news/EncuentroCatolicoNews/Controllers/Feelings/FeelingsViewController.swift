//
//  FeelingsViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 14/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

public protocol FeelingsSelectorDelegate: class {
    func saveFeeling(id: Int, feeling: String, image: String)
}

public class FeelingsViewController: UIViewController, FeelingsViewProtocol {

	var presenter: FeelingsPresenterProtocol?
    
    //MARK: - @IBoutlets
    @IBOutlet public weak var collectionView: UICollectionView!
    @IBOutlet public weak var textFieldContainerView: UIView!
    @IBOutlet public weak var textField: UITextField!
    @IBOutlet public weak var containerView: UIView!
    
    //MARK: - Properties
    public weak var delegate: FeelingsSelectorDelegate?
    public var feelingsCopy: Feelings?
    public var feelings: Feelings? {
        didSet { collectionView.reloadData() }
    }

    //MARK: - Life cycle
	override public func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        presenter?.getFeelings()
    }
    
    //MARK: - Methods
    private func setUpView() {
        containerView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 40)
        textFieldContainerView.setCorner(cornerRadius: 10)
        
        textField.autocorrectionType = .yes
        textField.returnKeyType = .done
        textField.delegate = self
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(UINib(nibName: "FeelingsCVC", bundle: Bundle(for: FeelingsCVC.self)), forCellWithReuseIdentifier: "FeelingsCVC")
    }
    
    func didFinishGettingFeelings(feelings: Feelings) {
        self.feelings = feelings
        self.feelingsCopy = feelings
    }
    
    func didFinishGettingFeelingsWithErrors(error: SocialNetworkErrors) {
        print(error)
    }
    
    //MARK: - Actions
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterData(_ sender: UITextField) {
        if let text = sender.text {
            if text != "" {
                let filteredData = feelings?.filter({$0.type.contains(text)})
                self.feelings = filteredData
            } else {
                self.feelings = feelingsCopy
            }
        }
    }

}

//MARK: - UICollectionViewDataSource
extension FeelingsViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfReactions = feelings?.count else { return 0 }
        return numberOfReactions
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeelingsCVC", for: indexPath) as? FeelingsCVC else { return UICollectionViewCell() }
        
        if let reaction = feelings?[indexPath.row] {
            
            //Label
            cell.reactionLabel.text = reaction.type
            
            //Image
            if let url = URL(string: reaction.img) {
                cell.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
            }
            
            cell.separator.isHidden = indexPath.row % 2 != 0 ? true : false
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FeelingsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let feeling = feelings?[indexPath.row] {
            delegate?.saveFeeling(id: feeling.feeling_id, feeling: feeling.type, image: feeling.img)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FeelingsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(cellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace - 10) / CGFloat(cellsInRow))

        return CGSize(width: size, height: 70)
    }
}

//MARK: - UITextFieldDelegate
extension FeelingsViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
