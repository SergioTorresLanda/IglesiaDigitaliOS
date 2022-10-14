//
//  Loader.swift
//  EncuentroCatolicoNews
//
//  Created by Diego Martinez on 02/03/21.
//

import Foundation
import UIKit

public class Loader: UIView, UITableViewDataSource, UITableViewDelegate {
    private weak var superView: UIView?
    private var tableView: UITableView?
    private var heightForRows: [CGFloat]?
    private var indicator: UIActivityIndicatorView?
    
    public init(superviewForIndicatorActivity: UIView) {
        super.init(frame: superviewForIndicatorActivity.frame)
        backgroundColor = .white
        
        let percentage = UIScreen.main.bounds.width*0.5
        indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator?.color = .black
        //indicator.frame = CGRect(x: 0, y: 0, width: percentage, height: percentage)
        indicator?.center = superviewForIndicatorActivity.center
        addSubview(indicator!)
        indicator!.addAnchorsAndCenter(centerX: true, centerY: true, width: percentage, height: percentage, left: nil, top: nil, right: nil, bottom: nil)
        
        indicator!.startAnimating()
    }
    
    public func removeIndicator(){
        indicator?.stopAnimating()
        self.removeFromSuperview()
    }
    
    public init(superView: UIView, heightForRows: [CGFloat]?) {
        super.init(frame: superView.frame)
        self.superView = superView
        self.heightForRows = heightForRows
    }
    
    public func start() {
        backgroundColor = .clear
        superView?.addSubview(self)
        
        tableView = UITableView()
        tableView?.backgroundColor = .white
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorColor = .clear
        tableView?.isUserInteractionEnabled = false
        addSubview(tableView!)
        addAnchorsWithMargin(0)
        tableView?.addAnchorsWithMargin(0)
        
        tableView?.reloadData()
    }
    
    public func stop() {
        tableView?.removeFromSuperview()
        tableView = nil
        self.removeFromSuperview()
    }
    
    // MARK: - TableView Protocol
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let _heightForRows = heightForRows {
            if _heightForRows.count > indexPath.row {
                return LoaderCell(withHeight: _heightForRows[indexPath.row]+20)
            } else { return LoaderCell(withHeight: 135.0) }
        } else { return LoaderCell(withHeight: 135.0) }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _heightForRows = heightForRows {
            if _heightForRows.count > indexPath.row {
                return _heightForRows[indexPath.row]+20
            } else { return 100 }
        } else { return 100 }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LoaderCell: UITableViewCell {
    
    var background: UIView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        background = UIView()
        background?.backgroundColor = .white
        background?.layer.cornerRadius = 10
        addSubview(background!)
    }
    
    convenience init(withHeight height: CGFloat) {
        self.init(style: .default, reuseIdentifier: nil)
        
        backgroundColor = .clear
        background?.addAnchorsAndSize(width: kWidth-20, height: height+20, left: 10, top: 10, right: 10, bottom: 10)
        background?.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        let firstL = UILabel.loader()
        background?.addSubview(firstL)
        firstL.addAnchorsAndSize(width: kWidth/2-20, height: 200, left: 0, top: 0, right: 0, bottom: 0)
        
        background?.addShimmerEffect()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UILabel {
    static func loader() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }
}
