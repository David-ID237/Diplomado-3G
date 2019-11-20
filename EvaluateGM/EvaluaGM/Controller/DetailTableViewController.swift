//
//  DetailTableViewController.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/20/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

protocol DetailTableViewControllerDelegate: AnyObject {
    func update(_ employee: Employee)
    func updateUser(_ user: User)
}

class DetailTableViewController: UITableViewController {
    
    //Properties
    var user: User?
    var employee: Employee?
    var imagePicker: ImagePicker!
    weak var delegate: DetailTableViewControllerDelegate?
    var ref: DatabaseReference!
    
    //General Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var averageIndicator: UILabel!
    @IBOutlet weak var firstSectionView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var firstSectionStackView: UIStackView!
    @IBOutlet weak var cultureAttatchment: UILabel!
    @IBOutlet weak var cultureAttatchmentIndicator: UILabel!
    @IBOutlet weak var dpoImplementation: UILabel!
    @IBOutlet weak var dpoImplementationIndicator: UILabel!
    @IBOutlet weak var attitude: UILabel!
    @IBOutlet weak var attitudeIndicator: UILabel!
    @IBOutlet weak var trainingAdaptation: UILabel!
    @IBOutlet weak var trainingAdaptationIndicator: UILabel!
    @IBOutlet weak var performance: UILabel!
    @IBOutlet weak var performanceIndicator: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    
    //Specific Outlets (Forklift)
    @IBOutlet weak var forkliftSecurity: UILabel!
    @IBOutlet weak var forkliftSecurityRoutine: UILabel!
    @IBOutlet weak var forkliftChecklist: UILabel!
    @IBOutlet weak var forkliftDownloadUpload: UILabel!
    @IBOutlet weak var forkliftExampleToFollow: UILabel!
    
    //Specific Outlets (Delivery & DeliveryAssistant)
    @IBOutlet weak var deliverySecurity: UILabel!
    @IBOutlet weak var deliveryTraining: UILabel!
    @IBOutlet weak var deliveryKnowSegment: UILabel!
    @IBOutlet weak var deliveryKnowledgeIndicators: UILabel!
    @IBOutlet weak var deliveryAssists: UILabel!
    @IBOutlet weak var deliveryTeamwork: UILabel!
    
    //Specific Outlets (WarehouseAssistant)
    @IBOutlet weak var warehouseSecurity: UILabel!
    @IBOutlet weak var warehouseSelectionGoal: UILabel!
    @IBOutlet weak var warehousePickeoGoal: UILabel!
    @IBOutlet weak var warehouseJobGoals: UILabel!
    @IBOutlet weak var warehouseExampleToFollow: UILabel!
    
    //Indicators Collections Outlets
    @IBOutlet var firstSpecificGradeIndicators: [UILabel]!
    @IBOutlet var secondSpecificGradeIndicators: [UILabel]!
    @IBOutlet var thirdSpecificGradeIndicators: [UILabel]!
    @IBOutlet var fourthSpecificGradeIndicators: [UILabel]!
    @IBOutlet var fifthSpecificGradeIndicators: [UILabel]!
    @IBOutlet var sixthSpecificGradeIndicators: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        guard let employee = employee, let user = user else{
            print("Employee or user no received in detailVC")
            return
        }
        print("Employee received in detailVC: \(employee)")
        print("User received in detailVC: \(user)")
        setupUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setupUI()
    }
    
    //Actions
    @IBAction func save(unwindSegue: UIStoryboardSegue) {
        guard let evaluateViewController = unwindSegue.source as? EvaluateTableViewController else {
            print("Cant receive evaluated employee")
            return
        }
        employee = evaluateViewController.employee
        user = evaluateViewController.user
        if let employee = employee {
            delegate?.update(employee)
        }
        if let user = user {
            delegate?.updateUser(user)
        }
    }
    @IBAction func cancel(unwindSegue: UIStoryboardSegue) {
        
    }
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    @IBAction func evaluateButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toEvaluateVC", sender: nil)
    }
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        guard let user = user  else {
            return
        }
        if(user.isSupervisor) {
            let alertController = UIAlertController(title: "Acceso denegado", message: "Acción sólo válida para usuarios de Recursos Humanos.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Eliminar empleado", message: "¿Está seguro de eliminar el registro? Está acción es irreversible.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Si", style: .destructive) { (_) in
                guard let currentEmployee = self.employee else {
                    return
                }
                switch currentEmployee.type {
                case .forklift:
                    self.ref.child("forkliftEmployees").child(currentEmployee.id).removeValue()
                case .delivery:
                    self.ref.child("deliveryEmployees").child(currentEmployee.id).removeValue()
                case .warehouseAssistant:
                    self.ref.child("warehouseAssistantEmployees").child(currentEmployee.id).removeValue()
                case .deliveryAssistant:
                    self.ref.child("deliveryAssistantEmployees").child(currentEmployee.id).removeValue()
                }
                self.navigationController?.popViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func logout(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Cierre de sesión", message: "¿Está seguro que desea cerrar sesión?", preferredStyle: .actionSheet)
        let acceptAction = UIAlertAction(title: "Si", style: .destructive) { (_) in
            do {
                try Auth.auth().signOut()
                print("Successful logout")
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "toLoginVC2", sender: nil)
            } catch {
                print("Unexpected error: \(error)")
            }
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(acceptAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    @IBAction func supervisorsButtonTapped(_ sender: UIBarButtonItem) {
        guard let user = user else{
            return
        }
        if user.isSupervisor {
            let alertController = UIAlertController(title: "Acceso denegado", message: "Acción sólo válida para usuarios de recursos humanos.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "toSupervisorsVC2", sender: nil)
        }
    }
    
    //Setup Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toEvaluateVC") {
            guard let user = user  else {
                return
            }
            if(user.isSupervisor) {
                guard let navigationController = segue.destination as? UINavigationController, let evaluateTableViewController = navigationController.viewControllers.first as? EvaluateTableViewController else {
                    print("Cant set employee")
                    return
                }
                evaluateTableViewController.employee = employee
                evaluateTableViewController.user = user
            } else {
                let alertController = UIAlertController(title: "Acceso denegado", message: "Acción sólo válida para usuarios supervisores.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    //Methods
    func setupUI() {
        tableView.allowsSelection = false
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.heightAnchor.constraint(equalToConstant: ((firstSectionView.frame.height - firstSectionStackView.frame.height) / 2) + imageView.frame.height / 2).isActive = true
    
        imageView.layer.borderWidth = 6.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        cameraButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10).isActive = true
        cameraButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10).isActive = true
        cameraButton.layer.borderWidth = 1.0
        cameraButton.layer.masksToBounds = false
        cameraButton.layer.borderColor = UIColor.white.cgColor
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height / 2
        cameraButton.clipsToBounds = true
        cameraButton.isEnabled = false
        cameraButton.isHidden = true
        
        guard let currentEmployee = employee else {
            return
        }
        imageView.image = currentEmployee.photo
        nameLabel.text = currentEmployee.name + " " + currentEmployee.lastName
        typeLabel.text = currentEmployee.typeString
        
        //Profile image
        if let photoUrl = URL(string: currentEmployee.photoURL) {
            let task = URLSession.shared.dataTask(with: photoUrl) { (data, response, error) in
                if error != nil {
                    guard let error = error else {
                        return
                    }
                    print("Error while downloading image: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        self.imageView.image = UIImage(data: data)
                    } else {
                        self.imageView.image = UIImage(named: "User")
                    }
                }
            }
            task.resume()
        }
        
        if currentEmployee.hasBeenEvaluated {
            averageLabel.text = "\(String(format: "%.2f", currentEmployee.getGeneralAverage())) ★"
            setIndicator(employee: currentEmployee, label: averageIndicator)
            cultureAttatchment.text = "\(String(format: "%.2f", currentEmployee.getCultureAttatchmentAverage()))"
            setIndicator(employee: currentEmployee, label: cultureAttatchmentIndicator)
            dpoImplementation.text = "\(String(format: "%.2f", currentEmployee.getDpoImplementationAverage()))"
            setIndicator(employee: currentEmployee, label: dpoImplementationIndicator)
            attitude.text = "\(String(format: "%.2f", currentEmployee.getAttitudeAverage()))"
            setIndicator(employee: currentEmployee, label: attitudeIndicator)
            trainingAdaptation.text = "\(String(format: "%.2f", currentEmployee.getTrainingAdaptationAverage()))"
            setIndicator(employee: currentEmployee, label: trainingAdaptationIndicator)
            performance.text = "\(String(format: "%.2f", currentEmployee.getPerformanceAverage()))"
            setIndicator(employee: currentEmployee, label: performanceIndicator)
        } else {
            averageLabel.text = "Sin evaluaciones"
            averageIndicator.text = ""
            cultureAttatchment.text = "⏤"
            cultureAttatchmentIndicator.text = ""
            dpoImplementation.text = "⏤"
            dpoImplementationIndicator.text = ""
            attitude.text = "⏤"
            attitudeIndicator.text = ""
            trainingAdaptation.text = "⏤"
            trainingAdaptationIndicator.text = ""
            performance.text = "⏤"
            performanceIndicator.text = ""
        }
        
        switch currentEmployee.type {
        case .forklift:
            if currentEmployee.hasBeenEvaluated {
                forkliftSecurity.text = "\(String(format: "%.2f", currentEmployee.getFirstSpecificGradeAverage()))"
                forkliftSecurityRoutine.text = "\(String(format: "%.2f", currentEmployee.getSecondSpecificGradeAverage()))"
                forkliftChecklist.text = "\(String(format: "%.2f", currentEmployee.getThirdSpecificGradeAverage()))"
                forkliftDownloadUpload.text = "\(String(format: "%.2f", currentEmployee.getFourthSpecificGradeAverage()))"
                forkliftExampleToFollow.text = "\(String(format: "%.2f", currentEmployee.getFifthSpecificGradeAverage()))"
            } else {
                forkliftSecurity.text = "⏤"
                forkliftSecurityRoutine.text = "⏤"
                forkliftChecklist.text = "⏤"
                forkliftDownloadUpload.text = "⏤"
                forkliftExampleToFollow.text = "⏤"
            }
            
        case .delivery, .deliveryAssistant:
            if currentEmployee.hasBeenEvaluated {
                deliverySecurity.text = "\(String(format: "%.2f", currentEmployee.getFirstSpecificGradeAverage()))"
                deliveryTraining.text = "\(String(format: "%.2f", currentEmployee.getSecondSpecificGradeAverage()))"
                deliveryKnowSegment.text = "\(String(format: "%.2f", currentEmployee.getThirdSpecificGradeAverage()))"
                deliveryKnowledgeIndicators.text = "\(String(format: "%.2f", currentEmployee.getFourthSpecificGradeAverage()))"
                deliveryAssists.text = "\(String(format: "%.2f", currentEmployee.getFifthSpecificGradeAverage()))"
                deliveryTeamwork.text = "\(String(format: "%.2f", currentEmployee.getSixthSpecificGradeAverage()))"
            } else {
                deliverySecurity.text = "⏤"
                deliveryTraining.text = "⏤"
                deliveryKnowSegment.text = "⏤"
                deliveryKnowledgeIndicators.text = "⏤"
                deliveryAssists.text = "⏤"
                deliveryTeamwork.text = "⏤"
            }
            
        case .warehouseAssistant:
            if currentEmployee.hasBeenEvaluated {
                warehouseSecurity.text = "\(String(format: "%.2f", currentEmployee.getFirstSpecificGradeAverage()))"
                warehouseSelectionGoal.text = "\(String(format: "%.2f", currentEmployee.getSecondSpecificGradeAverage()))"
                warehousePickeoGoal.text = "\(String(format: "%.2f", currentEmployee.getThirdSpecificGradeAverage()))"
                warehouseJobGoals.text = "\(String(format: "%.2f", currentEmployee.getFourthSpecificGradeAverage()))"
                warehouseExampleToFollow.text = "\(String(format: "%.2f", currentEmployee.getFifthSpecificGradeAverage()))"
            } else {
                warehouseSecurity.text = "⏤"
                warehouseSelectionGoal.text = "⏤"
                warehousePickeoGoal.text = "⏤"
                warehouseJobGoals.text = "⏤"
                warehouseExampleToFollow.text = "⏤"
            }
        }
        setSpecificIndicators()
    }
    
    func shouldHideSection(section: Int) -> Bool {
        switch section {
        case 2:
            if(employee?.type != Type.forklift) {
                return true
            } else {
                return false
            }
        case 3:
            if(employee?.type != Type.delivery && employee?.type != Type.deliveryAssistant) {
                return true
            } else {
                return false
            }
        case 4:
            if(employee?.type != Type.warehouseAssistant) {
                return true
            } else {
                return false
            }
        default:
            return false
        }
    }
    
    func setIndicator(employee: Employee, label: UILabel) {
        switch label {
        case averageIndicator:
            if employee.averageIndicator {
                label.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                label.text = "↑"
            } else {
                label.textColor = .red
                label.text = "↓"
            }
        case cultureAttatchmentIndicator:
            if employee.cultureAttatchmentIndicator {
                label.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                label.text = "↑"
            } else {
                label.textColor = .red
                label.text = "↓"
            }
        case dpoImplementationIndicator:
            if employee.dpoImplementationIndicator {
                label.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                label.text = "↑"
            } else {
                label.textColor = .red
                label.text = "↓"
            }
        case attitudeIndicator:
            if employee.attitudeIndicator {
                label.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                label.text = "↑"
            } else {
                label.textColor = .red
                label.text = "↓"
            }
        case trainingAdaptationIndicator:
            if employee.trainingAdaptationIndicator {
                label.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                label.text = "↑"
            } else {
                label.textColor = .red
                label.text = "↓"
            }
        case performanceIndicator:
            if employee.performanceIndicator {
                label.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                label.text = "↑"
            } else {
                label.textColor = .red
                label.text = "↓"
            }
        default:
            print("Other case")
        }
    }
    
    func setSpecificIndicators() {
        guard let currentEmployee = employee else {
            return
        }
        if currentEmployee.hasBeenEvaluated {
            //1st
            if currentEmployee.firstSpecificGradeIndicator {
                for firstSpecificIndicator in firstSpecificGradeIndicators {
                    firstSpecificIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                    firstSpecificIndicator.text = "↑"
                }
            } else {
                for firstSpecificIndicator in firstSpecificGradeIndicators {
                    firstSpecificIndicator.textColor = .red
                    firstSpecificIndicator.text = "↓"
                }
            }
            //2nd
            if currentEmployee.secondSpecificGradeIndicator {
                for secondSpecificIndicator in secondSpecificGradeIndicators {
                    secondSpecificIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                    secondSpecificIndicator.text = "↑"
                }
            } else {
                for secondSpecificIndicator in secondSpecificGradeIndicators {
                    secondSpecificIndicator.textColor = .red
                    secondSpecificIndicator.text = "↓"
                }
            }
            //3rd
            if currentEmployee.thirdSpecificGradeIndicator {
                for thirdSpecificIndicator in thirdSpecificGradeIndicators {
                    thirdSpecificIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                    thirdSpecificIndicator.text = "↑"
                }
            } else {
                for thirdSpecificIndicator in thirdSpecificGradeIndicators {
                    thirdSpecificIndicator.textColor = .red
                    thirdSpecificIndicator.text = "↓"
                }
            }
            //4th
            if currentEmployee.fourthSpecificGradeIndicator {
                for fourthSpecificIndicator in fourthSpecificGradeIndicators {
                    fourthSpecificIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                    fourthSpecificIndicator.text = "↑"
                }
            } else {
                for fourthSpecificIndicator in fourthSpecificGradeIndicators {
                    fourthSpecificIndicator.textColor = .red
                    fourthSpecificIndicator.text = "↓"
                }
            }
            //5th
            if currentEmployee.fifthSpecificGradeIndicator {
                for fifthSpecificIndicator in fifthSpecificGradeIndicators {
                    fifthSpecificIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                    fifthSpecificIndicator.text = "↑"
                }
            } else {
                for fifthSpecificIndicator in fifthSpecificGradeIndicators {
                    fifthSpecificIndicator.textColor = .red
                    fifthSpecificIndicator.text = "↓"
                }
            }
            //6th
            if currentEmployee.sixthSpecificGradeIndicator {
                for sixthSpecificIndicator in sixthSpecificGradeIndicators {
                    sixthSpecificIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                    sixthSpecificIndicator.text = "↑"
                }
            } else {
                for sixthSpecificIndicator in sixthSpecificGradeIndicators {
                    sixthSpecificIndicator.textColor = .red
                    sixthSpecificIndicator.text = "↓"
                }
            }
        } else {
            for firstSpecificIndicator in firstSpecificGradeIndicators {
                firstSpecificIndicator.text = ""
            }
            for secondSpecificIndicator in secondSpecificGradeIndicators {
                secondSpecificIndicator.text = ""
            }
            for thirdSpecificIndicator in thirdSpecificGradeIndicators {
                thirdSpecificIndicator.text = ""
            }
            for fourthSpecificIndicator in fourthSpecificGradeIndicators {
                fourthSpecificIndicator.text = ""
            }
            for fifthSpecificIndicator in fifthSpecificGradeIndicators {
                fifthSpecificIndicator.text = ""
            }
            for sixthSpecificIndicator in sixthSpecificGradeIndicators {
                sixthSpecificIndicator.text = ""
            }
        }
    }

    // MARK: - Table view data source

    //Hide headers
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return shouldHideSection(section: section) ? 0.1 : super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    //Hide footers
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return shouldHideSection(section: section) ? 0.1 : super.tableView(tableView, heightForHeaderInSection: section)
    }
    
    //Hide rows in hidden sections
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return shouldHideSection(section: indexPath.section) ? 0 : super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    //Hide header text
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if(shouldHideSection(section: section)) {
            let headerView = view as! UITableViewHeaderFooterView
            headerView.textLabel!.textColor = UIColor.clear
        }
    }
    
    //Hide footer text
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if(shouldHideSection(section: section)) {
            let footerView = view as! UITableViewHeaderFooterView
            footerView.textLabel!.textColor = UIColor.clear
        }
    }
}

extension DetailTableViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let imageSelected = image else {
            return
        }
        employee?.photo = imageSelected
        setupUI()
        if let employee = employee {
            delegate?.update(employee)
        }
    }
}
