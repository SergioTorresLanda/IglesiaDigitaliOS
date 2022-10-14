//
//  MakeDropDown.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 01/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public protocol MakeDropDownDataSourceProtocol: class {
    func getDataToDropDown(cell: UITableViewCell, indexPos: Int, makeDropDownIdentifier: String)
    func numberOfRows(makeDropDownIdentifier: String) -> Int
}

public class MakeDropDown: UIView {
    
    var makeDropDownIdentifier: String = "DROP_DOWN"
    var cellReusableIdentifier: String = "DROP_DOWN_CELL"
    
    var dropDownTableView: UITableView?
    var width: CGFloat = 0
    var offset: CGFloat = 0
    weak var makeDropDownDataSourceProtocol: MakeDropDownDataSourceProtocol?
    var nib: UINib? {
        didSet{ dropDownTableView?.register(nib, forCellReuseIdentifier: self.cellReusableIdentifier)}
    }
    
    var viewPositionRef: CGRect?
    var isDropDownPresent: Bool = false
   
    //MARK: - Methods
    func setUpDropDown(viewPositionReference: CGRect, offset: CGFloat) {
        self.setCorner(cornerRadius: 5)
        self.setBorder(borderColor: UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00))
        self.frame = CGRect(x: viewPositionReference.minX, y: viewPositionReference.maxY + offset, width: 0, height: 0)
        dropDownTableView = UITableView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: 0, height: 0))
        self.width = viewPositionReference.width < 100 ? 100 : viewPositionReference.width
        self.offset = offset
        self.viewPositionRef = viewPositionReference
        dropDownTableView?.showsVerticalScrollIndicator = false
        dropDownTableView?.showsHorizontalScrollIndicator = false
        dropDownTableView?.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        dropDownTableView?.separatorStyle = .singleLine
        dropDownTableView?.delegate = self
        dropDownTableView?.dataSource = self
        dropDownTableView?.allowsSelection = true
        dropDownTableView?.isUserInteractionEnabled = true
        dropDownTableView?.tableFooterView = UIView()
        self.addSubview(dropDownTableView!)
    }
    
    func showDropDown(height: CGFloat) {
        if isDropDownPresent {
            hideDropDown()
        } else {
            isDropDownPresent = true
            self.frame = CGRect(x: (self.viewPositionRef?.minX)!, y: (self.viewPositionRef?.maxY)! + self.offset, width: width, height: 0)
            dropDownTableView?.frame = CGRect(x: 0, y: 0, width: width, height: 0)
            dropDownTableView?.reloadData()
            
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.05, options: .curveLinear
                , animations: {
                self.frame.size = CGSize(width: self.width, height: height)
                    self.dropDownTableView?.frame.size = CGSize(width: self.width, height: height)
            })
        }
        
    }
    
    func reloadDropDown(height: CGFloat) {
        self.frame = CGRect(x: (self.viewPositionRef?.minX)!, y: (self.viewPositionRef?.maxY)!
            + self.offset, width: width, height: 0)
        dropDownTableView?.frame = CGRect(x: 0, y: 0, width: width, height: 0)
        dropDownTableView?.reloadData()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.05, options: .curveLinear
            , animations: {
            self.frame.size = CGSize(width: self.width, height: height)
            self.dropDownTableView?.frame.size = CGSize(width: self.width, height: height)
        })
    }
    
    func setRowHeight(height: CGFloat) {
        dropDownTableView?.rowHeight = height
        dropDownTableView?.estimatedRowHeight = height
    }
    
    func hideDropDown() {
        isDropDownPresent = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
            , animations: {
            self.frame.size = CGSize(width: self.width, height: 0)
            self.dropDownTableView?.frame.size = CGSize(width: self.width, height: 0)
        })
    }
    
    func removeDropDown() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveLinear
            , animations: {
            self.dropDownTableView?.frame.size = CGSize(width: 0, height: 0)
        }) { (_) in
            self.removeFromSuperview()
            self.dropDownTableView?.removeFromSuperview()
        }
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension MakeDropDown: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makeDropDownDataSourceProtocol?.numberOfRows(makeDropDownIdentifier: makeDropDownIdentifier) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = dropDownTableView?.dequeueReusableCell(withIdentifier: cellReusableIdentifier) ?? UITableViewCell()
        makeDropDownDataSourceProtocol?.getDataToDropDown(cell: cell, indexPos: indexPath.row,
                                                          makeDropDownIdentifier: makeDropDownIdentifier)
        return cell
    }
}
