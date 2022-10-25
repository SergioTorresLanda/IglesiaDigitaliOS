//
//  ECNFFileTypeDelegate.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Alejandro on 24/10/22.
//

import Foundation

protocol ECNFFileTypeDelegate: AnyObject {
    //MARK: - Methods
    func fileTypeList(didSelect option: ECNFFormationType)
}
