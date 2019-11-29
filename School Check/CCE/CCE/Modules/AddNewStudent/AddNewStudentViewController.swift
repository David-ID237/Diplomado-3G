//
//  AddNewStudentViewController.swift
//  CCE
//
//  Created by Andrès Leal Giorguli on 7/12/19.
//  Copyright © 2019 Carlos Ramirez. All rights reserved.
//
//
import Firebase
import UIKit
import FirebaseStorage

class AddNewStudentViewController: UIViewController {
    
    var db: Firestore!
    var alumno: Alumnos?
    var name: String = "nil"
    var idStudent: String = "nil"
    var randomStringID: String = ""
    var arrayDataPicker: [String] =  []
    var uid: String = "nil"
    let storage = Storage.storage()
    var myView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    var email: String? = "nil"
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var textfieldNombre: UITextField!
    @IBOutlet weak var textfieldEscuela: UITextField!
    @IBOutlet weak var textfieldTutor: UITextField!
    @IBOutlet weak var textfieldCurso: UITextField!
    @IBOutlet weak var textfieldID: UITextField!
    @IBOutlet weak var textfieldDireccion: UITextField!
    @IBOutlet weak var textfieldTelefono: UITextField!
    @IBOutlet weak var textfieldCorreo: UITextField!
    @IBOutlet weak var imageViewPerfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showProgressView(myView: myView, message: Message.loading)
            setupFirebase()
            setupUI()
            setupNavigationBar()
            setupPicker()
    }
    
    
    
    
    @IBAction func goToPaymentRecord(_ sender: Any) {
        
        performSegue(withIdentifier: SegueIdentifiers.toPaymentRecord, sender: self)
        
    }
    
    @IBAction func editPerfil(_ sender: Any){
        
        alert(title: Title.allowEdit, message: Message.allowEdit)
        
        self.textfieldNombre.isUserInteractionEnabled = true
        self.textfieldEscuela.isUserInteractionEnabled = true
        self.textfieldTutor.isUserInteractionEnabled = true
        self.textfieldCurso.isUserInteractionEnabled = true
        self.textfieldDireccion.isUserInteractionEnabled = true
        self.textfieldTelefono.isUserInteractionEnabled = true
        self.textfieldCorreo.isUserInteractionEnabled = true
        self.imageViewPerfil.isUserInteractionEnabled = true
        
        btnSave.isHidden = false
        
    }
    
    
    func setupDataFromUser(){
        
        btnSave.isHidden = true
        db.collection(FirebaseCollection.studentData).document("\(idStudent)").addSnapshotListener { (documentSnapshot, error) in
            
            guard let document = documentSnapshot else {
                
                return
            }
            
            
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            
            
            if dataDescription == "nil" {
                return
            }
            let dictionary = document.data()! as NSDictionary
            let nombre = dictionary["name"] as! String
            let escuela = dictionary["school"] as! String
            let tutor = dictionary["tutor"] as! String
            let curso = dictionary["class"] as! String
            let iD = dictionary["uid"] as! String
            self.uid = iD
            let direccion = dictionary["address"] as! String
            let telefono = dictionary["phone"] as! String
            let correo = dictionary["email"] as! String
            self.email = correo
            
            
            self.textfieldNombre.text = nombre
            self.textfieldEscuela.text = escuela
            self.textfieldTutor.text = tutor
            self.textfieldCurso.text = curso
            self.textfieldID.text = iD
            self.textfieldDireccion.text = direccion
            self.textfieldTelefono.text = telefono
            self.textfieldCorreo.text = correo
            
            self.textfieldNombre.isUserInteractionEnabled = false
            self.textfieldEscuela.isUserInteractionEnabled = false
            self.textfieldTutor.isUserInteractionEnabled = false
            self.textfieldCurso.isUserInteractionEnabled = false
            self.textfieldID.isUserInteractionEnabled = false
            self.textfieldDireccion.isUserInteractionEnabled = false
            self.textfieldTelefono.isUserInteractionEnabled = false
            self.textfieldCorreo.isUserInteractionEnabled = false
            self.imageViewPerfil.isUserInteractionEnabled = false
            
            
        }
        
    }
    
    
    @IBAction func saveStudentButton(_ sender: UIButton) {

        myView.alpha = 1
        
        let nombre = textfieldNombre.text ?? "nil"
        let escuela = textfieldEscuela.text ?? "nil"
        let tutor = textfieldTutor.text ?? "nil"
        let curso = textfieldCurso.text ?? "nil"

        if uid != "nil"{
            
            randomStringID = uid
            
        }else{
            
            randomStringID = randomString(length: 12)
            
        }
        let direccion = textfieldDireccion.text ?? "nil"
        let telefono = textfieldTelefono.text ?? "nil"
        let correo = textfieldCorreo.text ?? "nil"

        let isEmail = isValidEmail(emailStr: correo)
        if isEmail {
            
            alumno = Alumnos.init(nombre: nombre, escuela: escuela, tutor: tutor, curso: curso, direccion: direccion, telefono: telefono, correo: correo, ID: randomStringID)
            
            if alumno?.correo == "nil" ||
                alumno?.nombre == "nil" ||
                alumno?.escuela == "nil" ||
                alumno?.tutor == "nil" ||
                alumno?.curso == "nil" ||
                alumno?.direccion == "nil" ||
                alumno?.telefono == "nil" {
                
                alert(title: Title.titleUps, message: Message.emptyFields)
                return
                
            }
            
            saveStudentData()
        } else {
            
            alert(title: Title.titleUps, message: Message.wrongEmail)
            dismissProgressView(myView: myView)
        }
        

    }
    
    
    func saveStudentData(){
        self.db.collection(FirebaseCollection.studentData).document(randomStringID).setData([
            "name": alumno!.nombre ,
            "address": alumno!.direccion,
            "class": alumno!.curso,
            "email": alumno!.correo,
            "phone": alumno!.telefono,
            "school": alumno!.escuela,
            "tutor": alumno!.tutor,
            "uid": alumno!.ID
        ]) { err in
            if let err = err {
                self.alert(title: Title.titleUps, message: Message.errorUploading)
                return
            } else {

                let image = self.imageViewPerfil.image
                
                if image != UIImage(named:"perfil_avatar1") {
                    self.uploadImage(image: image!)
                }
                else{
                    self.uploadImage(image: UIImage(named: "perfil_avatar1")!)
                }
                
            }
        }
    }
    
    
    
    func uploadImage(image: UIImage){

        let imageData: NSData = image.pngData()! as NSData
        let storageRef = storage.reference()

        let spaceRef = storageRef.child("users_photo/\(randomStringID).jpg")

        let uploadTask = spaceRef.putData(imageData as Data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {

                self.alert(title: Title.titleUps, message: Message.errorUploading)
                return
            }
            

            spaceRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    self.alert(title: Title.titleUps, message: Message.errorUploading)
                    return
                }
                
                self.dismissProgressView(myView: self.myView)
                
                self.alert(title: Title.saveDataSuccess, message: Message.saveDataSuccess)
            }
        }
    }
    
    func downloadUserPhoto(uid: String){
        let storageRef = storage.reference()
        // Create a reference to the file you want to download
        let starsRef = storageRef.child("users_photo/\(uid).jpg")
        
        // Fetch the download URL
        starsRef.downloadURL { url, error in
            if let error = error {
                // Handle any errors
                print("ErrorDownload: ", error)
            } else {
                // Get the download URL for 'images/stars.jpg'
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                if data == nil{
                    self.imageViewPerfil.image = UIImage(named: "perfil_avatar1")
                }else{
                    let image = UIImage(data: data!)
                    self.imageViewPerfil.image = image
                    self.imageViewPerfil.transform = CGAffineTransform(rotationAngle: 0)
                    self.dismissProgressView(myView: self.myView)
                }
            }
        }
    }
    
    func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == .up) {
            return img
        }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    
}

extension AddNewStudentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayDataPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayDataPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textfieldCurso.text = arrayDataPicker[row]
    }
    
    @objc func donePicker() {
        
        textfieldCurso.resignFirstResponder()
        
    }
    
    func setupPicker(){
        arrayDataPicker.append("Ingreso a Bachillerato (COMIPEMS)")
        arrayDataPicker.append("Ingreso Secundaria")
        arrayDataPicker.append("Ingreso a Universidad (UNAM/IPN/UAM)")
        arrayDataPicker.append("Regularización")
        arrayDataPicker.append("Robótica")
        arrayDataPicker.append("Inglés 0")
        arrayDataPicker.append("Inglés 1")
        arrayDataPicker.append("Inglés 2")
        arrayDataPicker.append("Inglés 3")
        arrayDataPicker.append("Inglés 4")
        arrayDataPicker.append("Inglés 5")
        
        let picker: UIPickerView
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width ,height: 300))
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.plain, target: self, action: #selector (donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector (donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textfieldCurso.inputView = picker
        textfieldCurso.inputAccessoryView = toolBar
        
        
    }
    
}

extension AddNewStudentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func cameraAction(_ sender: Any) {
        showAlertPhoto()
    }
    
    func showAlertPhoto() {
        
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: - ImagePicker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        imageViewPerfil.image = fixOrientation(img: image)
//                imageViewPerfil.transform = CGAffineTransform(rotationAngle: (.pi) / 2)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

extension AddNewStudentViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.toPaymentRecord{
            let destinationVC = segue.destination as! PaymentHistory
            //Pasar el studentToDetails a DetailUserCCE
            
            destinationVC.idStudent = idStudent
            destinationVC.email = email
            
            
        }
    }
}

extension AddNewStudentViewController {
    
    func setupFirebase(){
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
    
    func setupUI(){
        
        textfieldID.isUserInteractionEnabled = false
        
        if name != "nil" && idStudent != "nil"{
            
            setupDataFromUser()
            downloadUserPhoto(uid: idStudent)
            
            let editPerfil = UIButton(type: .system)
            editPerfil.setImage(UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal), for: .normal)
            editPerfil.tintColor = .white
            editPerfil.frame = CGRect(x: 0, y: 0, width: 34 , height: 34)
            editPerfil.addTarget(self, action: #selector(editPerfil(_:)), for: .touchUpInside)
            
            let paymentIcon = UIButton(type: .system)
            paymentIcon.setImage(UIImage(named: "payment")?.withRenderingMode(.alwaysOriginal), for: .normal)
            paymentIcon.tintColor = .white
            paymentIcon.frame = CGRect(x: 0, y: 0, width: 34 , height: 34)
            paymentIcon.addTarget(self, action: #selector(goToPaymentRecord(_:)), for: .touchUpInside)
            
            navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: editPerfil), UIBarButtonItem(customView: paymentIcon)]
            
        }
        else {
            dismissProgressView(myView: myView)
        }
        
        if name == "nil"{
            
            self.navigationItem.title = NavigationTitle.newStudent
            
        }else{
            self.navigationItem.title = name
        }
        
        imageViewPerfil.layer.borderWidth = 1
        imageViewPerfil.layer.borderColor = UIColor.lightGray.cgColor
        imageViewPerfil.isUserInteractionEnabled = true
        imageViewPerfil.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cameraAction(_:))))
        
        
    }
    
}

