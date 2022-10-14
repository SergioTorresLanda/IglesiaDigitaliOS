//
//  PageIndicator.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 18/11/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public protocol PageIndicatorView: class {
    
    var view: UIView { get }
    var page: Int { get set }
    var numberOfPages: Int { get set}
}

extension UIPageControl: PageIndicatorView {
    public var view: UIView {
        return self
    }

    public var page: Int {
        get {
            return currentPage
        }
        set {
            currentPage = newValue
        }
    }

    open override func sizeToFit() {
        var frame = self.frame
        frame.size = size(forNumberOfPages: numberOfPages)
        frame.size.height = 30
        self.frame = frame
    }
}
