//
//  Extension.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 03/10/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @available(iOS 11.0, *)
    @nonobjc class var eMainGold: UIColor {
        return UIColor(named: "eMainGold",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .yellow
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eMainBlue: UIColor {
      return UIColor(named: "eMainBlue",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .blue
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eLightBlack: UIColor {
      return UIColor(named: "eLightBlack",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .gray
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eDarkGold: UIColor {
      return UIColor(named: "eDarkGold",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .brown
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eBlack: UIColor {
      return UIColor(named: "eBlack",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .black
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eLightGray: UIColor {
      return UIColor(named: "eLightGray",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .black
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eLightBlue: UIColor {
      return UIColor(named: "eLightBlue",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .blue
    }
    
    @available(iOS 11.0, *)
    @nonobjc class var eGreenishBlue: UIColor {
      return UIColor(named: "eGreenishBlue",in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil) ?? .green
    }
    
}

@IBDesignable
extension UIView {
    
    @IBInspectable var radius: Double {
        get {
            return 0.0
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.clear
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWith: Double {
        get {
            return 0.0
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return self.shadow
        }
        set {
            if newValue {
                self.layer.applySketchShadow(alpha: 0.3, y: 4, blur: 6)
            } else {
                self.layer.applySketchShadow(alpha: 0, y: 0, blur: 0)
            }
        }
    }
    
    func roundCorners(radius: CGFloat, cornersToRound: UIRectCorner) {
        self.clipsToBounds = true
    
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = CACornerMask(rawValue: cornersToRound.rawValue)
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornersToRound, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = rectShape
        }
    }
    
    func rotate(angle: CGFloat, duration: CGFloat = 0.25) {
        UIView.animate(withDuration: TimeInterval(duration), animations: {
            self.transform = self.transform.isIdentity ? CGAffineTransform(rotationAngle: angle) : CGAffineTransform.identity
        })
    }
    
    func setGradientBackground(colors: [UIColor], direction: GradientDirection, alpha: CGFloat = 1) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colors.map({$0.withAlphaComponent(alpha).cgColor})
        switch direction {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)
        }
        gradient.frame = self.bounds

        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addLine( color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
       
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
    }
    
    enum GradientDirection {
        case vertical, horizontal
    }
    
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
}

extension UIImage {
    
    static func colorImage(color: UIColor) -> UIImage? {
        
        var colorImage: UIImage? = UIImage()
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        return colorImage
    }
    
    var roundedImage: UIImage {
        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(
            roundedRect: rect,
            cornerRadius: 4
            ).addClip()
        self.draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
    
    public func correctlyOrientedImage() -> UIImage {
        
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        UIGraphicsEndImageContext()

        return normalizedImage
    }
    
    func imageWithSize(_ size:CGSize) -> UIImage {
        var scaledImageRect = CGRect.zero

        let aspectWidth:CGFloat = size.width / self.size.width
        let aspectHeight:CGFloat = size.height / self.size.height
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight)

        scaledImageRect.size.width = self.size.width * aspectRatio
        scaledImageRect.size.height = self.size.height * aspectRatio
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0

        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        self.draw(in: scaledImageRect)

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage!
    }
}

extension UIButton {
    
    @IBInspectable var touchEffect: Bool {
        get {
            return self.touchEffect
        }
        set {
            if newValue {
                let normalState = UIImage.colorImage(color: UIColor.clear)
                let highlightedState = UIImage.colorImage(color: UIColor.white)
                
                self.setBackgroundImage(normalState, for: .normal)
                self.setBackgroundImage(highlightedState, for: .highlighted)
            } else {
                self.setBackgroundImage(nil, for: .normal)
                self.setBackgroundImage(nil, for: .highlighted)
            }
        }
    }
    
    @IBInspectable var underlined: Bool {
        get {
            return self.touchEffect
        }
        set {
            if newValue {
                let attributes: [NSAttributedString.Key: Any] = [.font: titleLabel?.font ?? UIFont.systemFont(ofSize: 16, weight: .bold),
                                                                 .foregroundColor: currentTitleColor,
                                                                .underlineStyle: NSUnderlineStyle.single.rawValue]
                let attributeString = NSMutableAttributedString(string: currentTitle ?? "",
                                                                attributes: attributes)
                setAttributedTitle(attributeString, for: .normal)
            } else {
                setTitle(currentTitle, for: .normal)
            }
        }
    }
    
    
    func setUnderlined() {
        
    }
    
}

extension String {
    
    //MARK: - String validations
    func isValidEmail() -> Bool {
        let regex = #"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"#
        let validation = NSPredicate(format:"SELF MATCHES %@", regex)
        return validation.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regex = #"^.{7,}$"#
        let validation = NSPredicate(format:"SELF MATCHES %@", regex)
        return validation.evaluate(with: self)
    }
    
    func isValidRFC() -> Bool {
        let rfcPatternPm = "^(([A-ZÑ&]{3})([0-9]{2})([0][13578]|[1][02])(([0][1-9]|[12][\\d])|[3][01])([A-Z0-9]{3}))|" +
                           "(([A-ZÑ&]{3})([0-9]{2})([0][13456789]|[1][012])(([0][1-9]|[12][\\d])|[3][0])([A-Z0-9]{3}))|" +
                           "(([A-ZÑ&]{3})([02468][048]|[13579][26])[0][2]([0][1-9]|[12][\\d])([A-Z0-9]{3}))|" +
                           "(([A-ZÑ&]{3})([0-9]{2})[0][2]([0][1-9]|[1][0-9]|[2][0-8])([A-Z0-9]{3}))$"
    
        let rfcPatternPf = "^(([A-ZÑ&]{4})([0-9]{2})([0][13578]|[1][02])(([0][1-9]|[12][\\d])|[3][01])([A-Z0-9]{3}))|" +
                           "(([A-ZÑ&]{4})([0-9]{2})([0][13456789]|[1][012])(([0][1-9]|[12][\\d])|[3][0])([A-Z0-9]{3}))|" +
                           "(([A-ZÑ&]{4})([02468][048]|[13579][26])[0][2]([0][1-9]|[12][\\d])([A-Z0-9]{3}))|" +
                           "(([A-ZÑ&]{4})([0-9]{2})[0][2]([0][1-9]|[1][0-9]|[2][0-8])([A-Z0-9]{3}))$"
       
        let validationPm = NSPredicate(format:"SELF MATCHES %@", rfcPatternPm)
        let validationPf = NSPredicate(format:"SELF MATCHES %@", rfcPatternPf)
    
        return validationPm.evaluate(with: self) || validationPf.evaluate(with: self)
    }
    
    func isValidCode() -> Bool{
        let regex = #"^[0-9]{4}$"#
        let validation = NSPredicate(format:"SELF MATCHES %@", regex)
        return validation.evaluate(with: self)
    }
    
    func isValidCardNumber() -> Bool {
        let regex = #"^[0-9]{16}$"#
        let regexAmex = #"^[0-9]{15}$"#
        let validation = NSPredicate(format:"SELF MATCHES %@", regex)
        let validationAmex = NSPredicate(format:"SELF MATCHES %@", regexAmex)
        return validation.evaluate(with: self) || validationAmex.evaluate(with: self)
    }
    
    /// Creates a QR code for the current URL in the given color.
        func qrImage(using color: UIColor) -> UIImage? {
            if let cgImage = qrImage?.tinted(using: color) {
                return UIImage(ciImage: cgImage)
            } else {
                return nil
            }
        }

        /// Returns a black and white QR code for this URL.
        var qrImage: CIImage? {
            guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
            let qrData = data(using: String.Encoding.ascii)
            qrFilter.setValue(qrData, forKey: "inputMessage")

            let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
            return qrFilter.outputImage?.transformed(by: qrTransform)
    }
    
    
    enum Descriptor: String {
        case code128 = "CICode128BarcodeGenerator"
        case pdf417 = "CIPDF417BarcodeGenerator"
        case aztec = "CIAztecCodeGenerator"
        case qr = "CIQRCodeGenerator"
    }
    
    func barCodeImage(using color: UIColor) -> UIImage? {
        if let barCodeImage = generateBarcCode(descriptor: .code128)?.tinted(using: color) {
            return UIImage(ciImage: barCodeImage)
        } else {
            return nil
        }
    }
    
    func generateBarcCode(descriptor: Descriptor) -> CIImage? {
        let filterName = descriptor.rawValue

        guard let data = data(using: .ascii),
            let filter = CIFilter(name: filterName) else {
                return nil
        }

        filter.setValue(data, forKey: "inputMessage")

        let codeTransform = CGAffineTransform(scaleX: 12, y: 12)
        
        return filter.outputImage?.transformed(by: codeTransform)
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension CALayer {
    
    func applySketchShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0, y: CGFloat = 2, blur: CGFloat = 4, spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
}

extension UIViewController {
    func add(_ child: UIViewController, in container: UIView? = nil) {
        DispatchQueue.main.async {
            if !self.children.contains(child) {
                child.willMove(toParent: self)
                self.addChild(child)
                if let container = container {
                    child.view.frame = container.bounds
                    container.addSubview(child.view)
                } else {
                    self.view.addSubview(child.view)
                }
                child.didMove(toParent: self)
            }
        }
    }

    func remove() {
        DispatchQueue.main.async {
            // Just to be safe, we check that this view controller
            // is actually added to a parent before removing it.
            guard self.parent != nil else {
                return
            }

            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.didMove(toParent: nil)
        }
    }
}

extension CIImage {
    /// Inverts the colors and creates a transparent image by converting the mask to alpha.
    /// Input image should be black and white.
    var transparent: CIImage? {
        return inverted?.blackTransparent
    }

    /// Inverts the colors.
    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }

        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }

    /// Converts all black to transparent.
    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }

    /// Applies the given color as a tint color.
    func tinted(using color: UIColor) -> CIImage?
    {
        guard
            let transparentQRImage = transparent,
            let filter = CIFilter(name: "CIMultiplyCompositing"),
            let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }

        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage

        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)

        return filter.outputImage!
    }
}

extension UINavigationController {
    func changeRootViewController(_ controller: UIViewController) {
        viewControllers.insert(controller, at: 0)
        popToRootViewController(animated: true)
    }
}

extension UIWindow {

    /// Switch current root view controller with a new view controller.
    ///
    /// - Parameters:
    ///   - viewController: new view controller.
    ///   - animated: set to true to animate view controller change _(default is true)_.
    ///   - duration: animation duration in seconds _(default is 0.5)_.
    ///   - options: animataion options _(default is .transitionFlipFromRight)_.
    ///   - completion: optional completion handler called when view controller is changed.
    func switchRootViewController(to viewController: UIViewController, animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve, _ completion: (() -> Void)? = nil) {

        guard animated else {
            rootViewController = viewController
            return
        }

        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }

}

extension Date {

    static func -(recent: Date, previous: Date) -> (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second

        return (year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }

}

extension UIAlertController {
    func addImage(image: UIImage) {
        let maxSize = CGSize(width: 240, height: 244)
        let imgSize = image.size
        var ratio:CGFloat!
        if (imgSize.width > imgSize.height){
            ratio = maxSize.width / imgSize.width
        }else {
            ratio = maxSize.height / imgSize.height
        }
        let scaleSize = CGSize(width: imgSize.width*ratio, height: imgSize.height*ratio)
        var resizedImage = image.imageWithSize(scaleSize)

        if (imgSize.height > imgSize.width) {
            let left = (maxSize.width - resizedImage.size.width) / 2
            resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -left, bottom: 0, right: 0))
        }

        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")

        self.addAction(imgAction)
    }
}

extension UICollectionViewCell {
    var collectionView: UICollectionView? {
        return self.next as? UICollectionView
    }

    var indexPath: IndexPath? {
        return self.collectionView?.indexPath(for: self)
    }
}

public extension Bundle {
    static let local: Bundle = Bundle(for: ProfileMapViewController.self)
}

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.local.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}
