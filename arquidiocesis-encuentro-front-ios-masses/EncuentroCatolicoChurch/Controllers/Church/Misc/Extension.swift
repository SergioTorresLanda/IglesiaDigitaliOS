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
    
    @nonobjc class var eMainGold: UIColor {
        return UIColor(named: "eMainGold",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .yellow
    }
    
    @nonobjc class var eMainBlue: UIColor {
      return UIColor(named: "eMainBlue",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .blue
    }
    
    @nonobjc class var eLightBlack: UIColor {
      return UIColor(named: "eLightBlack",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .gray
    }
    
    @nonobjc class var eDarkGold: UIColor {
      return UIColor(named: "eDarkGold",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .brown
    }
    
    @nonobjc class var eBlack: UIColor {
      return UIColor(named: "eBlack",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .black
    }
    
    @nonobjc class var eLightGray: UIColor {
      return UIColor(named: "eLightGray",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .black
    }
    
    @nonobjc class var eLightBlue: UIColor {
      return UIColor(named: "eLightBlue",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .blue
    }
    
    @nonobjc class var eGreenishBlue: UIColor {
      return UIColor(named: "eGreenishBlue",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .green
    }
    
    
    @nonobjc class var eBlueNew: UIColor {
      return UIColor(named: "eBlueNew",in: Bundle(for: Home_MiIglesia.self), compatibleWith: nil) ?? .blue
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
    
    var containerController: UIViewController? {
        return self.collectionView?.next as? UIViewController
    }
}


extension UIView {
func shake() {
    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    animation.duration = 0.6
    animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
    layer.add(animation, forKey: "shake")
    
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
}


    extension UIViewController {
        func showAlert(title: String, msg: String) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        func hideKeyboardWhenTappedAround() {
               let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
               tap.cancelsTouchesInView = false
               view.addGestureRecognizer(tap)
           }
           
           @objc func dismissKeyboard() {
               view.endEditing(true)
           }
    }
public extension Bundle {
    static let local: Bundle = Bundle(for: Home_MiIglesia.self)
}

extension Bundle {

    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.local.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view with type " + String(describing: type))
    }
}

extension UIScrollView {
    func updateContentView() {
         contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
     }
 }

extension UIViewController{

func showToast(message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
 }


extension UIImageView {
    func DownloadStaticImage(_ uri : String) {
        guard let url = URL(string: uri) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {responseData,response,error in
            //print("->>  response: ", response)
            //print("->>  error: ", error)

            if error == nil {
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                       
                        //print("Fin del hilo imagen muestra")
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print("error")
            }
        }
        task.resume()
    }
}

extension String {

    func split(regex pattern: String) -> [String] {

        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
            else { return [] }

        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
}

extension UIButton {
    func borderButtonColor(color: UIColor) {
        self.layer.cornerRadius = 8
        let colorBorde = color
        self.layer.borderWidth = 1
        self.clipsToBounds = true
        self.layer.borderColor = colorBorde.cgColor
        self.backgroundColor = .white
        self.setTitleColor(color, for: .normal)
    }
    
}

extension Date {
    
    func timeAgoDisplay() -> String {

        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let monthAgo = calendar.date(byAdding: .weekOfMonth, value: -1, to: Date())!
        
        var time = ""

        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            if diff == 1 {
                time = "segundo"
            }else{
                time = "segundos"
            }
            return "hace \(diff) \(time)"
            
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            if diff == 1 {
                time = "minuto"
            }else{
                time = "minutos"
            }
            return "hace \(diff) \(time)"
            
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            if diff == 1 {
                time = "hora"
            }else{
                time = "horas"
            }
            return "hace \(diff) \(time)"
            
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            if diff == 1 {
                time = "día"
            }else{
                time = "días"
            }
            return "hace \(diff) \(time)"
            
        }else if monthAgo > self {
            let diff = Calendar.current.dateComponents([.weekOfMonth], from: self, to: Date()).weekOfMonth ?? 0
            if diff == 1 {
                time = "semana"
            }else{
                time = "semanas"
            }
            return "hace \(diff) \(time)"
        }
        let diff = Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0
        if diff == 1 {
            time = "mes"
        }else{
            time = "meses"
        }
        return "hace \(diff) \(time)"

    }
    
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}


