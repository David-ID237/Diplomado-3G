//
//  Extensions.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/5/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit
import Firebase

extension UIImageView{
    func setRoundedImage()  {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension String{
    func base64ToImage() -> UIImage? {
        let dataDecoded:Data = Data(base64Encoded: self, options: .ignoreUnknownCharacters)!
        let decodedimage:UIImage = UIImage(data: dataDecoded)!
        return decodedimage
    }
   
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
}

extension UIImage{
    
    func encodeToBase64(format:ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png:
            imageData = self.pngData()
        case .jpeg(let compression):
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData?.base64EncodedString()
//        guard let imageData = self.jpegData(compressionQuality: 0.95) else { return "" }
//        return data.base64EncodedString()
    }

    
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        return UIGraphicsImageRenderer(size: canvas, format: imageRendererFormat).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    
}

extension Double{
    func convertTimestamp(serverTimestamp: Double) -> String {
        let x = serverTimestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: date as Date)
    }
}



extension UIColor {

    class func cantaloupe() -> UIColor {
        return UIColor(red:255/255, green:204/255, blue:102/255, alpha:1.0)
    }
    class func honeydew() -> UIColor {
        return UIColor(red:204/255, green:255/255, blue:102/255, alpha:1.0)
    }
    class func spindrift() -> UIColor {
        return UIColor(red:102/255, green:255/255, blue:204/255, alpha:1.0)
    }
    class func sky() -> UIColor {
        return UIColor(red:102/255, green:204/255, blue:255/255, alpha:1.0)
    }
    class func lavender() -> UIColor {
        return UIColor(red:204/255, green:102/255, blue:255/255, alpha:1.0)
    }
    class func carnation() -> UIColor {
        return UIColor(red:255/255, green:111/255, blue:207/255, alpha:1.0)
    }
    class func licorice() -> UIColor {
        return UIColor(red:0/255, green:0/255, blue:0/255, alpha:1.0)
    }
    class func snow() -> UIColor {
        return UIColor(red:255/255, green:255/255, blue:255/255, alpha:1.0)
    }
    class func salmon() -> UIColor {
        return UIColor(red:255/255, green:102/255, blue:102/255, alpha:1.0)
    }
    class func banana() -> UIColor {
        return UIColor(red:255/255, green:255/255, blue:102/255, alpha:1.0)
    }
    class func flora() -> UIColor {
        return UIColor(red:102/255, green:255/255, blue:102/255, alpha:1.0)
    }
    class func ice() -> UIColor {
        return UIColor(red:102/255, green:255/255, blue:255/255, alpha:1.0)
    }
    class func orchid() -> UIColor {
        return UIColor(red:102/255, green:102/255, blue:255/255, alpha:1.0)
    }
    class func bubblegum() -> UIColor {
        return UIColor(red:255/255, green:102/255, blue:255/255, alpha:1.0)
    }
    class func lead() -> UIColor {
        return UIColor(red:25/255, green:25/255, blue:25/255, alpha:1.0)
    }
    class func mercury() -> UIColor {
        return UIColor(red:230/255, green:230/255, blue:230/255, alpha:1.0)
    }
    class func tangerine() -> UIColor {
        return UIColor(red:255/255, green:128/255, blue:0/255, alpha:1.0)
    }
    class func lime() -> UIColor {
        return UIColor(red:128/255, green:255/255, blue:0/255, alpha:1.0)
    }
    class func seafoam() -> UIColor {
        return UIColor(red:0/255, green:255/255, blue:128/255, alpha:1.0)
    }
    class func aqua() -> UIColor {
        return UIColor(red:0/255, green:128/255, blue:255/255, alpha:1.0)
    }
    class func grape() -> UIColor {
        return UIColor(red:128/255, green:0/255, blue:255/255, alpha:1.0)
    }
    class func strawberry() -> UIColor {
        return UIColor(red:255/255, green:0/255, blue:128/255, alpha:1.0)
    }
    class func tungsten() -> UIColor {
        return UIColor(red:51/255, green:51/255, blue:51/255, alpha:1.0)
    }
    class func silver() -> UIColor {
        return UIColor(red:204/255, green:204/255, blue:204/255, alpha:1.0)
    }
    class func maraschino() -> UIColor {
        return UIColor(red:255/255, green:0/255, blue:0/255, alpha:1.0)
    }
    class func lemon() -> UIColor {
        return UIColor(red:255/255, green:255/255, blue:0/255, alpha:1.0)
    }
    class func spring() -> UIColor {
        return UIColor(red:0/255, green:255/255, blue:0/255, alpha:1.0)
    }
    class func turquoise() -> UIColor {
        return UIColor(red:0/255, green:255/255, blue:255/255, alpha:1.0)
    }
    class func blueberry() -> UIColor {
        return UIColor(red:0/255, green:0/255, blue:255/255, alpha:1.0)
    }
    class func magenta() -> UIColor {
        return UIColor(red:255/255, green:0/255, blue:255/255, alpha:1.0)
    }
    class func iron() -> UIColor {
        return UIColor(red:76/255, green:76/255, blue:76/255, alpha:1.0)
    }
    class func magnesium() -> UIColor {
        return UIColor(red:179/255, green:179/255, blue:179/255, alpha:1.0)
    }
    class func mocha() -> UIColor {
        return UIColor(red:128/255, green:64/255, blue:0/255, alpha:1.0)
    }
    class func fern() -> UIColor {
        return UIColor(red:64/255, green:128/255, blue:0/255, alpha:1.0)
    }
    class func moss() -> UIColor {
        return UIColor(red:0/255, green:128/255, blue:64/255, alpha:1.0)
    }
    class func ocean() -> UIColor {
        return UIColor(red:0/255, green:64/255, blue:128/255, alpha:1.0)
    }
    class func eggplant() -> UIColor {
        return UIColor(red:64/255, green:0/255, blue:128/255, alpha:1.0)
    }
    class func maroon() -> UIColor {
        return UIColor(red:128/255, green:0/255, blue:64/255, alpha:1.0)
    }
    class func steel() -> UIColor {
        return UIColor(red:102/255, green:102/255, blue:102/255, alpha:1.0)
    }
    class func aluminium() -> UIColor {
        return UIColor(red:153/255, green:153/255, blue:153/255, alpha:1.0)
    }
    class func cayenne() -> UIColor {
        return UIColor(red:128/255, green:0/255, blue:0/255, alpha:1.0)
    }
    class func asparagus() -> UIColor {
        return UIColor(red:128/255, green:120/255, blue:0/255, alpha:1.0)
    }
    class func clover() -> UIColor {
        return UIColor(red:0/255, green:128/255, blue:0/255, alpha:1.0)
    }
    class func teal() -> UIColor {
        return UIColor(red:0/255, green:128/255, blue:128/255, alpha:1.0)
    }
    class func midnight() -> UIColor {
        return UIColor(red:0/255, green:0/255, blue:128/255, alpha:1.0)
    }
    class func plum() -> UIColor {
        return UIColor(red:128/255, green:0/255, blue:128/255, alpha:1.0)
    }
    class func tin() -> UIColor {
        return UIColor(red:127/255, green:127/255, blue:127/255, alpha:1.0)
    }
    class func nickel() -> UIColor {
        return UIColor(red:128/255, green:128/255, blue:128/255, alpha:1.0)
    }
}

extension UIView {
    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}


extension AuthErrorCode {
    var description: String? {
        switch self {
        case .emailAlreadyInUse:
            return "Este correo ya está siendo usado por otro usuario"
        case .userDisabled:
            return "Este usuario ha sido deshabilitado"
        case .operationNotAllowed:
            return "Operación no permitida"
        case .invalidEmail:
            return "Correo electrónico no valido"
        case .wrongPassword:
            return "Contraseña incorrecta"
        case .userNotFound:
            return "No se encontró cuenta del usuario con el correo especificado"
        case .networkError:
            return "Problema al intentar conectar al servidor"
        case .weakPassword:
            return "Contraseña muy debil o no válida"
        case .missingEmail:
            return "Hace falta registrar un correo electrónico"
        case .internalError:
            return "Error interno"
        case .invalidCustomToken:
            return "Token personalizado invalido"
        case .tooManyRequests:
            return "Ya se han enviado muchas solicitudes al servidor"
        default:
            return nil
        }
    }
}

extension StorageErrorCode {
    var description: String? {
        switch self {
        case .unknown:
            return "Error desconocido"
        case .quotaExceeded:
            return "El espacio para guardar archivos ha sido sobrepasado"
        case .unauthenticated:
            return "Usuario no autenticado"
        case .unauthorized:
            return "Usuario no autorizado para realizar esta operación"
        case .retryLimitExceeded:
            return "Tiempo de espera excedido. Favor de intentar de nuevo"
        case .downloadSizeExceeded:
            return "El tamaño de descarga excede el espacio en memoria"
        case .cancelled:
            return "Operación cancelada"
        default:
            return nil
        }
    } }

public extension Error {
    var localizedDescription: String {
        let error = self as NSError
        if error.domain == AuthErrorDomain {
            if let code = AuthErrorCode(rawValue: error.code) {
                if let errorString = code.description {
                    return errorString
                }
            }
        }else if error.domain == StorageErrorDomain {
            if let code = StorageErrorCode(rawValue: error.code) {
                if let errorString = code.description {
                    return errorString
                }
            }
        }
        return error.localizedDescription
    } }
