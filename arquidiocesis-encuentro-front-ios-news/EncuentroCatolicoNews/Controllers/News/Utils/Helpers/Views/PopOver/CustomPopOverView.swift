//
//  CustomPopOverView.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 28/10/21.
//

import Foundation
import WebKit

class CustomPopOverView: UIView, KUIPopOverUsable {
    
    var contentSize: CGSize {
        return CGSize(width: 250.0, height: 90.0)
    }
    
    var popOverBackgroundColor: UIColor? {
        return .black
    }
    
    var arrowDirection: UIPopoverArrowDirection {
        return .up
    }
    
    let table = MyTableViewController()
    let tableView: UITableView = UITableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
                tableView.dataSource = table
                tableView.delegate = table
        
        tableView.backgroundColor = UIColor.white
        tableView.reloadData()
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = self.bounds
    }
    
}

protocol CustomPopOverDelegate {
    func selectedOption(select: String)
}

class MyTableViewController: UITableViewController {

    var myDataArray = ["Editar", "Eliminar"]
    
    var optionSelectDelegate: CustomPopOverDelegate?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.labUerName.text = "\(myDataArray[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch myDataArray[indexPath.row]{
        case "Editar":
            optionSelectDelegate?.selectedOption(select: "Editar")
        case "Eliminar":
            optionSelectDelegate?.selectedOption(select: "Eliminar")
        case "Denunciar":
            optionSelectDelegate?.selectedOption(select: "Denunciar")
        default:
            break
        }
    }
}

class CustomTableViewCell: UITableViewCell{
    let labUerName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labUerName.textColor = UIColor.black
        labUerName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labUerName)
        
        NSLayoutConstraint.activate([
            labUerName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labUerName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            labUerName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labUerName.heightAnchor.constraint(equalToConstant: 50)
                ])
    }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
}
