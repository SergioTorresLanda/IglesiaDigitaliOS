//
//  PhotoAlbumsViewControllerDelegate.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

internal protocol PhotoAlbumsViewControllerDelegate: class {
    func photoAlbumsViewController(_ controller: PhotoAlbumsViewController, didSelectAlbum album: PHAssetCollection)
}


internal final class PhotoAlbumsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    internal init(source: [PHFetchResult<PHAssetCollection>], configuration: ImagePickerConfigurable? = nil) {
        self.source = source
        self.configuration = configuration
        super.init(nibName: nil, bundle: Bundle.init(for: InitViewViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        self.source = []
        self.configuration = nil
        super.init(coder: aDecoder)
    }

    // MARK: - Properties

    weak var delegate: PhotoAlbumsViewControllerDelegate?

    override var prefersStatusBarHidden: Bool {
        return configuration?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return configuration?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return configuration?.preferredStatusBarUpdateAnimation ?? super.preferredStatusBarUpdateAnimation
    }

    private let configuration: ImagePickerConfigurable?

    private(set) lazy var tableView: UITableView = {
        let tableView = PhotoAlbumsTableView(configuration: self.configuration)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private let source: [PHFetchResult<PHAssetCollection>]

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = 90
        tableView.register(PhotoAlbumCell.self, forCellReuseIdentifier: String(describing: PhotoAlbumCell.self))
        (PHCachingImageManager.default() as? PHCachingImageManager)?.allowsCachingHighQualityImages = false
    }

    // MARK: - UITableViewDataSource

    internal func numberOfSections(in tableView: UITableView) -> Int {
        return source.count
    }

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source[section].count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotoAlbumCell.self), for: indexPath)
        (cell as? PhotoAlbumCell)?.configure(with: source[indexPath.section][indexPath.row])
        return cell
    }

    // MARK: - UITableViewDelegate

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.photoAlbumsViewController(self, didSelectAlbum: source[indexPath.section][indexPath.row])
    }

}

