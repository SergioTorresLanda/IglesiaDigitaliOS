//
//  LocationsViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 06/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import MapKit

public protocol LocationFinderDelegate: class {
    func saveLocation(id: String, name: String, direction: String, coordinates: CLLocationCoordinate2D, image: UIImage?)
}

public class LocationsViewController: UIViewController, LocationsViewProtocol {
    
    var presenter: LocationsPresenterProtocol?
    
    //MARK: - @IBOutlets
    @IBOutlet public weak var textFieldContainerView: UIView!
    @IBOutlet public weak var textField: UITextField!
    @IBOutlet public weak var containerView: UIView!
    @IBOutlet public weak var tableView: UITableView! {
        didSet { tableView.tableFooterView = UIView() }
    }
    
    //MARK: - Properties
    public weak var delegate: LocationFinderDelegate?
    var selectedItem: LocationAutocompletion?
    var selectedItemCoordinates: CLLocationCoordinate2D?
    var searchCompleter = MKLocalSearchCompleter()
    private var tableData = [LocationAutocompletion]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    //MARK: - Methods
    private func setUpView() {
        searchCompleter.queryFragment = "Torre Grupo Salinas"
        
        containerView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 40)
        textFieldContainerView.setCorner(cornerRadius: 10)
        
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion(.world)
        
        textField.autocorrectionType = .yes
        textField.returnKeyType = .done
        textField.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UINib(nibName: "LocationsTVC", bundle: Bundle(for: LocationsTVC.self)), forCellReuseIdentifier: "LocationsTVC")
    }
    
    //MARK: - Methods
    func didFinishGettingMap(image: UIImage?) {
        guard let item = selectedItem, let coordinates = selectedItemCoordinates else { return }
        delegate?.saveLocation(id: "0", name: item.getName(), direction: item.getDirection(), coordinates: coordinates, image: image)
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFinishGettingMapWithErrors(error: SocialNetworkErrors) {
        print(error.message)
    }
    
    //MARK: - Actions
    @IBAction public func textFieldDidChange(_ sender: UITextField) {
        guard let textFieldText = sender.text else { return }
        searchCompleter.queryFragment = textFieldText
        if textFieldText.isEmpty {
            tableData.removeAll()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension LocationsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "LocationsTVC", for: indexPath) as! LocationsTVC
        let place = tableData[indexPath.row]
        
        cell.nameLabel.text = place.getName()
        cell.directionsLabel.text = place.getDirection()
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension LocationsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalIndicator(message: "Cargando ubicación...")
        let placeName = tableData[indexPath.row].getName()
        let searchRequest = MKLocalSearch.Request(completion: tableData[indexPath.row].getSeatchCompletion())
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in
            self?.presentingViewController?.dismiss(animated: true, completion: nil)
            guard let mapItem = response?.mapItems.first, mapItem.name == placeName else { return }
            self?.selectedItem = self?.tableData[indexPath.row]
            self?.selectedItemCoordinates = mapItem.placemark.coordinate
            self?.presenter?.getMapImage(coordinates: mapItem.placemark.coordinate)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

//MARK: - UITextFieldDelegate
extension LocationsViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - MKLocalSearchCompleterDelegate
extension LocationsViewController: MKLocalSearchCompleterDelegate {
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        var results = [LocationAutocompletion]()
        completer.results.forEach { (result) in
            let location = LocationAutocompletion(searchCompletion: result, name: result.title, direction: result.subtitle)
            results.append(location)
        }
        
        tableData = results
    }
}
