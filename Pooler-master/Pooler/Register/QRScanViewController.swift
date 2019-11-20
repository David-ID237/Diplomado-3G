//
//  QRScanViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/7/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//
import Firebase
import UIKit
import AVFoundation

protocol getEnterpriseCodeDelegate {
    func getEnterprise(enterprise:Enterprise)
}

class QRScanViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    var delegate:getEnterpriseCodeDelegate?
    var session = AVCaptureSession()
    var qrCodeFrameView:UIView?
    var qrString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrSessionReader()
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(qrCodeFrameView)
        }
       
    }
    override func viewDidAppear(_ animated: Bool) {
        self.video.frame.size = self.view!.frame.size
    }
    
    
    func qrSessionReader()  {
       
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
//            session.addInput(input)
            if session.inputs.isEmpty {
                session.addInput(input)
            }
        } catch  {
            print("Error")
        }
        let output = AVCaptureMetadataOutput()
//        session.addOutput(output)
        if session.outputs.isEmpty {
            session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame.size = self.view.frame.size
        video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        video.bounds = view.layer.bounds;
        view.layer.addSublayer(video)
        session.startRunning()
            
        }
    }
    
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr{
                        // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
                    if object.stringValue != ""{
                        session.stopRunning()
                        let barCodeObject = video.transformedMetadataObject(for: object)
                        qrCodeFrameView?.frame = barCodeObject!.bounds
                        qrString = object.stringValue!
                        self.getEnterprise(qrString: self.qrString)
                    }
                }
//                let alert = UIAlertController(title: "Código escaneado", message: "El código ha sido escaneado.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//                    self.getEnterprise(qrString: self.qrString)
//                }))
//                self.present(alert, animated: true)
//
            }
        }
        
    }
    
    func getEnterprise(qrString:String) {
        let ref = Database.database().reference(withPath: "users")
        ref.child(qrString).observeSingleEvent(of: .value, with: { (snapshot) in
            var enterprise = Enterprise()
            enterprise.location = Location()
            if !snapshot.exists() {
                let alert = UIAlertController(title: "Código inválido", message: "El código escaneado no pertenece a ninguna empresa registrada.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Reintentar", style: .default, handler: {[weak self]  (action) in
                      self!.session.startRunning()
                }))
                alert.addAction(UIAlertAction(title: "Salir", style: .cancel, handler: { [weak self] (action) in
                    self!.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true)
                return
            }
            enterprise.name = snapshot.childSnapshot(forPath: "name").value as? String
            enterprise.location?.locationSubtitle = snapshot.childSnapshot(forPath: "addressSubtitle").value as? String
            enterprise.location?.locationTitle = snapshot.childSnapshot(forPath: "addressTitle").value as? String
            enterprise.location?.longitude = snapshot.childSnapshot(forPath: "longitude").value as? String
            enterprise.location?.latitude = snapshot.childSnapshot(forPath: "latitude").value as? String
            enterprise.profileImage = snapshot.childSnapshot(forPath: "profileImage").value as? String
            enterprise.UID = snapshot.childSnapshot(forPath: "uid").value as? String
            self.delegate?.getEnterprise(enterprise:enterprise)
            self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
             print(error.localizedDescription)
            let alert = UIAlertController(title: "Error de lectura", message: "No se puedó obtener la información, intenta más tarde.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action) in
                self!.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true)
           
        }
    }
}
