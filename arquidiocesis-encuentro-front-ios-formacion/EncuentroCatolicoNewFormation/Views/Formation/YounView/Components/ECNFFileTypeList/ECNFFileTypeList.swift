//  ECNFFileTypeList.swift
//  FormacionApp
//
//  Created by Alejandro Orihuela. 
//

import UIKit
import EncuentroCatolicoUtils

class ECNFFileTypeList: UIView {
    //MARK: - Properties
    weak var delegate: ECNFFileTypeDelegate?
    
    var options: [ECNFFormationType] = [] {
        didSet {
            fileCollectionView.reloadData()
        }
    }

    private(set) var selectedOption: ECNFFormationType? {
        didSet {
            guard let selectedOption = selectedOption,
                  let indexSelected = options.firstIndex(of: selectedOption) else {
                return
            }
            
            let indexPath = IndexPath(row: indexSelected, section: 0)
            
            animateSelectionBar(indexPath)
            fileCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    private let selectionBarView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 117.0/255.0, green: 120.0/255.0, blue: 123.0/255.0, alpha: 1)
        
        return view
    }()
    
    private lazy var fileCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ECNFFileTypeCell.self, forCellWithReuseIdentifier: ECNFFileTypeCell.identifier)
        
        return collectionView
    }()
    private var cellSize: CGSize = CGSize(width: 100, height: 50)
    private let boderBottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .black
        
        return view
    }()
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    //MARK: - Methods
    func setSelected(_ option: ECNFFormationType) {
        selectedOption = option
    }
}

//MARK: - UICollectionViewDataSource
extension ECNFFileTypeList: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        options.count
    }
    
    ///Collection View method
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ECNFFileTypeCell.identifier, for: indexPath) as? ECNFFileTypeCell,
              let option = options[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.setData(option)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ECNFFileTypeList: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let option = options[safe: indexPath.row] else {
            return
        }
        
        delegate?.fileTypeList(didSelect: option)
        selectedOption = option
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ECNFFileTypeList: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsToShow: CGFloat = CGFloat(options.count >= 3 ? 3 : options.count)
        let marginBetweenItems: CGFloat = 1
        let totalSpacing: CGFloat = (2 * marginBetweenItems) + ((itemsToShow + 3) * marginBetweenItems)
        let width = (collectionView.bounds.width  - totalSpacing) / itemsToShow
        
        cellSize.width = width
        selectionBarView.frame.size = CGSize(width: width, height: selectionBarView.frame.height)
        
        return cellSize
    }
}

//MARK: - Private functions
extension ECNFFileTypeList {
    private func animateSelectionBar(_ indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            [weak self] in
            
            guard let self = self else { return }
            
            self.selectionBarView.frame = CGRect(x: self.fileCollectionView.layoutAttributesForItem(at: indexPath)?.frame.minX ?? 0, y: self.selectionBarView.frame.minY, width: self.selectionBarView.frame.width, height: self.selectionBarView.frame.height)
        }, completion: nil)
    }

    private func commonInit() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.addSubview(boderBottomView)
        self.addSubview(fileCollectionView)
        
        fileCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fileCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            fileCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            fileCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            fileCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        boderBottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            boderBottomView.heightAnchor.constraint(equalToConstant: 1),
            boderBottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            boderBottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            boderBottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        fileCollectionView.addSubview(selectionBarView)
        
        selectionBarView.frame = CGRect(x: 0, y: cellSize.height - 4, width: cellSize.width, height: 4)
    }
}
