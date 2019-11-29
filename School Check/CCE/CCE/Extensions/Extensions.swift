//
//  Extensions.swift
//  CCE
//
//  Created by Carlos Ramirez on 7/13/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics



extension UIViewController {
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    func alert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    func setupNavigationBar(){

        
            let gradientLayer = CAGradientLayer()
            var updatedFrame = self.navigationController!.navigationBar.bounds
            updatedFrame.size.height += 44
            gradientLayer.frame = updatedFrame
            gradientLayer.colors = [UIColor(hexString: "#509AAF").cgColor, UIColor(hexString: "#7DD8C7").cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // vertical gradient start
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0) // vertical gradient end
        
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
        
            self.navigationController!.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        
    }
    
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, view: UIView){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        
        view.layer.addSublayer(gradientLayer)
    }
    
    func showProgressView(myView: UIView, message: String){
        
        
        myView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.9028664173)
        myView.layer.zPosition = 1
        myView.alpha = 1
        
        let progress = UIActivityIndicatorView(style: .whiteLarge)
        progress.center = self.view.center
        
        let lblLoading = UILabel(frame: CGRect(x: 0, y: -20, width: 100, height: 36))
        lblLoading.text = message + "..."
        lblLoading.font = UIFont(name: "System-Bold", size: 17)
        lblLoading.textAlignment = .center
        lblLoading.textColor = .white
        lblLoading.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY + 30)
        
        myView.addSubview(lblLoading)
        myView.addSubview(progress)
        self.view.addSubview(myView)

        progress.startAnimating()
        
    }
    
    func dismissProgressView(myView: UIView){
        UIView.animate(withDuration: 1.0, animations: {
            myView.alpha = 0
            
        })
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
}


// String to Hex Color
extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    
}


extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
//        gradient.locations = locations
        print(locations)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIImage {
    

        func rotate(radians: CGFloat) -> UIImage {
            let rotatedSize = CGRect(origin: .zero, size: size)
                .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
                .integral.size
            UIGraphicsBeginImageContext(rotatedSize)
            if let context = UIGraphicsGetCurrentContext() {
                let origin = CGPoint(x: rotatedSize.width / 2.0,
                                     y: rotatedSize.height / 2.0)
                context.translateBy(x: origin.x, y: origin.y)
                context.rotate(by: radians)
                draw(in: CGRect(x: -origin.y, y: -origin.x,
                                width: size.width, height: size.height))
                let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                return rotatedImage ?? self
            }
            
            return self
        }
    
}


extension String {
    
 
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
 
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        

        guard number != 0 as NSNumber else {
            return ""
        }
        
        return formatter.string(from: number)!
    }
}

