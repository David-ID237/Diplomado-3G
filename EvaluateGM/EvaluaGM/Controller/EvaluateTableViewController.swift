//
//  EvaluateTableViewController.swift
//  EvaluateGM
//
//  Created by José Antonio Arellano Mendoza on 6/23/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class EvaluateTableViewController: UITableViewController {
    
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var averageIndicator: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var evaluationAverage: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var firstSectionView: UIView!
    @IBOutlet weak var firstSectionStackView: UIStackView!
    
    //General Outlets
    @IBOutlet weak var cultureAttatchmentLabel: UILabel!
    @IBOutlet weak var cultureAttatchmentSlider: UISlider!
    @IBOutlet weak var dpoImplementationLabel: UILabel!
    @IBOutlet weak var dpoImplementationSlider: UISlider!
    @IBOutlet weak var attitudeLabel: UILabel!
    @IBOutlet weak var attitudeSlider: UISlider!
    @IBOutlet weak var traningAdaptationLabel: UILabel!
    @IBOutlet weak var trainingAdaptationSlider: UISlider!
    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var performanceSlider: UISlider!
    
    //Specific Outlets (Forklift)
    @IBOutlet weak var forkliftSecurityLabel: UILabel!
    @IBOutlet weak var forkliftSecuritySlider: UISlider!
    @IBOutlet weak var forkliftSecurityRoutineLabel: UILabel!
    @IBOutlet weak var forkliftSecurityRoutineSlider: UISlider!
    @IBOutlet weak var forkliftChecklistLabel: UILabel!
    @IBOutlet weak var forkliftChecklistSlider: UISlider!
    @IBOutlet weak var forkliftDownloadUploadLabel: UILabel!
    @IBOutlet weak var forkliftDownloadUploadSlider: UISlider!
    @IBOutlet weak var forkliftExampleToFollowLabel: UILabel!
    @IBOutlet weak var forkliftExampleToFollowSlider: UISlider!
    
    //Specific Outlets (Delivery & DeliveryAssistant)
    @IBOutlet weak var deliverySecurityLabel: UILabel!
    @IBOutlet weak var deliverySecuritySlider: UISlider!
    @IBOutlet weak var deliveryTrainingLabel: UILabel!
    @IBOutlet weak var deliveryTrainingSlider: UISlider!
    @IBOutlet weak var deliveryKnowSegmentLabel: UILabel!
    @IBOutlet weak var deliveryKnowSegmentSlider: UISlider!
    @IBOutlet weak var deliveryKnowledgeIndicatorsLabel: UILabel!
    @IBOutlet weak var deliveryKnowledgeIndicatorsSlider: UISlider!
    @IBOutlet weak var deliveryAssistsLabel: UILabel!
    @IBOutlet weak var deliveryAssistsSlider: UISlider!
    @IBOutlet weak var deliveryTeamworkLabel: UILabel!
    @IBOutlet weak var deliveryTeamworkSlider: UISlider!
    
    //Specific Outlets (WarehouseAssistant)
    @IBOutlet weak var warehouseSecurityLabel: UILabel!
    @IBOutlet weak var warehouseSecuritySlider: UISlider!
    @IBOutlet weak var warehouseSelectionGoalLabel: UILabel!
    @IBOutlet weak var warehouseSelectionGoalSlider: UISlider!
    @IBOutlet weak var warehousePickeoGoalLabel: UILabel!
    @IBOutlet weak var warehousePickeoGoalSlider: UISlider!
    @IBOutlet weak var warehouseJobGoalsLabel: UILabel!
    @IBOutlet weak var warehouseJobGoalsSlider: UISlider!
    @IBOutlet weak var warehouseExampleToFollowLabel: UILabel!
    @IBOutlet weak var warehouseExampleToFollowSlider: UISlider!
    
    //Properties
    var employee: Employee?
    var user: User?
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        guard let employee = employee, let user = user else{
            print("Employee or user no received in detailVC")
            return
        }
        print("Employee received in evaluateVC: \(employee)")
        print("User received in evaluateVC: \(user)")
        setupUI()
    }
    
    //General Actions
    @IBAction func cultureAttatchmentSliderChange(_ sender: UISlider) {
        let roundedValue = round(cultureAttatchmentSlider.value * 2) / 2
        cultureAttatchmentLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func dpoImplementationSliderChange(_ sender: UISlider) {
        let roundedValue = round(dpoImplementationSlider.value * 2) / 2
        dpoImplementationLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func attitudeSliderChange(_ sender: UISlider) {
        let roundedValue = round(attitudeSlider.value * 2) / 2
        attitudeLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func trainingAdaptation(_ sender: UISlider) {
        let roundedValue = round(trainingAdaptationSlider.value * 2) / 2
        traningAdaptationLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func performanceSliderChange(_ sender: UISlider) {
        let roundedValue = round(performanceSlider.value * 2) / 2
        performanceLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    
    //Specific Actions (Forklift)
    @IBAction func forkliftSecuritySliderChange(_ sender: UISlider) {
        let roundedValue = round(forkliftSecuritySlider.value * 2) / 2
        forkliftSecurityLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func forkliftSecurityRoutineSliderChange(_ sender: UISlider) {
        let roundedValue = round(forkliftSecurityRoutineSlider.value * 2) / 2
        forkliftSecurityRoutineLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func forkliftChecklistSliderChange(_ sender: UISlider) {
        let roundedValue = round(forkliftChecklistSlider.value * 2) / 2
        forkliftChecklistLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func forkliftDownloadUploadSliderChange(_ sender: UISlider) {
        let roundedValue = round(forkliftDownloadUploadSlider.value * 2) / 2
        forkliftDownloadUploadLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func forkliftExampleToFollowSliderChange(_ sender: UISlider) {
        let roundedValue = round(forkliftExampleToFollowSlider.value * 2) / 2
        forkliftExampleToFollowLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    
    //Specific Actions (Delivery & DeliveryAssistant)
    @IBAction func deliverySecuritySliderChange(_ sender: UISlider) {
        let roundedValue = round(deliverySecuritySlider.value * 2) / 2
        deliverySecurityLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func deliveryTrainingSliderChange(_ sender: UISlider) {
        let roundedValue = round(deliveryTrainingSlider.value * 2) / 2
        deliveryTrainingLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func deliveryKnowSegmentSliderChange(_ sender: Any) {
        let roundedValue = round(deliveryKnowSegmentSlider.value * 2) / 2
        deliveryKnowSegmentLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func deliveryKnowledgeIndicatorsSliderChange(_ sender: UISlider) {
        let roundedValue = round(deliveryKnowledgeIndicatorsSlider.value * 2) / 2
        deliveryKnowledgeIndicatorsLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func deliveryAssistsSliderChange(_ sender: UISlider) {
        let roundedValue = round(deliveryAssistsSlider.value * 2) / 2
        deliveryAssistsLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func deliveryTeamworkSliderChange(_ sender: UISlider) {
        let roundedValue = round(deliveryTeamworkSlider.value * 2) / 2
        deliveryTeamworkLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    
    //Specific Actions (WarehouseAssistant)
    @IBAction func warehouseSecuritySliderChange(_ sender: UISlider) {
        let roundedValue = round(warehouseSecuritySlider.value * 2) / 2
        warehouseSecurityLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func warehouseSelectionGoalSliderChange(_ sender: UISlider) {
        let roundedValue = round(warehouseSelectionGoalSlider.value * 2) / 2
        warehouseSelectionGoalLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func warehousePickeoGoalSliderChange(_ sender: UISlider) {
        let roundedValue = round(warehousePickeoGoalSlider.value * 2) / 2
        warehousePickeoGoalLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func warehouseJobGoalsSliderChange(_ sender: UISlider) {
        let roundedValue = round(warehouseJobGoalsSlider.value * 2) / 2
        warehouseJobGoalsLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    @IBAction func warehouseExampleToFollowSliderChange(_ sender: UISlider) {
        let roundedValue = round(warehouseExampleToFollowSlider.value * 2) / 2
        warehouseExampleToFollowLabel.text = "\(String(format: "%.1f", roundedValue))"
        getEvaluationAverage()
    }
    
    //Setup segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        employee?.cultureAttatchmentArray.append((cultureAttatchmentLabel.text! as NSString).floatValue)
        employee?.dpoImplementationArray.append((dpoImplementationLabel.text! as NSString).floatValue)
        employee?.attitudeArray.append((attitudeLabel.text! as NSString).floatValue)
        employee?.trainingAdaptationArray.append((traningAdaptationLabel.text! as NSString).floatValue)
        employee?.performanceArray.append((performanceLabel.text! as NSString).floatValue)
        
        if (employee?.type == .forklift) {
            //Forklift
            employee?.firstSpecificGradeArray.append((forkliftSecurityLabel.text! as NSString).floatValue)
            employee?.secondSpecificGradeArray.append((forkliftSecurityRoutineLabel.text! as NSString).floatValue)
            employee?.thirdSpecificGradeArray.append((forkliftChecklistLabel.text! as NSString).floatValue)
            employee?.fourthSpecificGradeArray.append((forkliftDownloadUploadLabel.text! as NSString).floatValue)
            employee?.fifthSpecificGradeArray.append((forkliftExampleToFollowLabel.text! as NSString).floatValue)
            employee?.averageArray.append(((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (forkliftSecurityLabel.text! as NSString).floatValue + (forkliftSecurityRoutineLabel.text! as NSString).floatValue + (forkliftChecklistLabel.text! as NSString).floatValue + (forkliftDownloadUploadLabel.text! as NSString).floatValue + (forkliftExampleToFollowLabel.text! as NSString).floatValue) / 10)
            user?.averageArray.append(((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (forkliftSecurityLabel.text! as NSString).floatValue + (forkliftSecurityRoutineLabel.text! as NSString).floatValue + (forkliftChecklistLabel.text! as NSString).floatValue + (forkliftDownloadUploadLabel.text! as NSString).floatValue + (forkliftExampleToFollowLabel.text! as NSString).floatValue) / 10)
        } else if (employee?.type == .delivery || employee?.type == .deliveryAssistant) {
            //Delivery & DeliveryAssistant
            employee?.firstSpecificGradeArray.append((deliverySecurityLabel.text! as NSString).floatValue)
            employee?.secondSpecificGradeArray.append((deliveryTrainingLabel.text! as NSString).floatValue)
            employee?.thirdSpecificGradeArray.append((deliveryKnowSegmentLabel.text! as NSString).floatValue)
            employee?.fourthSpecificGradeArray.append((deliveryKnowledgeIndicatorsLabel.text! as NSString).floatValue)
            employee?.fifthSpecificGradeArray.append((deliveryAssistsLabel.text! as NSString).floatValue)
            employee?.sixthSpecificGradeArray.append((deliveryTeamworkLabel.text! as NSString).floatValue)
            employee?.averageArray.append(((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (deliverySecurityLabel.text! as NSString).floatValue + (deliveryTrainingLabel.text! as NSString).floatValue + (deliveryKnowSegmentLabel.text! as NSString).floatValue + (deliveryKnowledgeIndicatorsLabel.text! as NSString).floatValue + (deliveryAssistsLabel.text! as NSString).floatValue + (deliveryTeamworkLabel.text! as NSString).floatValue) / 11)
            user?.averageArray.append(((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (deliverySecurityLabel.text! as NSString).floatValue + (deliveryTrainingLabel.text! as NSString).floatValue + (deliveryKnowSegmentLabel.text! as NSString).floatValue + (deliveryKnowledgeIndicatorsLabel.text! as NSString).floatValue + (deliveryAssistsLabel.text! as NSString).floatValue + (deliveryTeamworkLabel.text! as NSString).floatValue) / 11)
        } else {
            //Warehouse
            employee?.firstSpecificGradeArray.append((warehouseSecurityLabel.text! as NSString).floatValue)
            employee?.secondSpecificGradeArray.append((warehouseSelectionGoalLabel.text! as NSString).floatValue)
            employee?.thirdSpecificGradeArray.append((warehousePickeoGoalLabel.text! as NSString).floatValue)
            employee?.fourthSpecificGradeArray.append((warehouseJobGoalsLabel.text! as NSString).floatValue)
            employee?.fifthSpecificGradeArray.append((warehouseExampleToFollowLabel.text! as NSString).floatValue)
            employee?.averageArray.append(((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (warehouseSecurityLabel.text! as NSString).floatValue + (warehouseSelectionGoalLabel.text! as NSString).floatValue + (warehousePickeoGoalLabel.text! as NSString).floatValue + (warehouseJobGoalsLabel.text! as NSString).floatValue + (warehouseExampleToFollowLabel.text! as NSString).floatValue) / 10)
            user?.averageArray.append(((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (warehouseSecurityLabel.text! as NSString).floatValue + (warehouseSelectionGoalLabel.text! as NSString).floatValue + (warehousePickeoGoalLabel.text! as NSString).floatValue + (warehouseJobGoalsLabel.text! as NSString).floatValue + (warehouseExampleToFollowLabel.text! as NSString).floatValue) / 10)
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
        
        cultureAttatchmentLabel.text = "\(String(format: "%.1f", cultureAttatchmentSlider.value))"
        dpoImplementationLabel.text = "\(String(format: "%.1f", dpoImplementationSlider.value))"
        attitudeLabel.text = "\(String(format: "%.1f", attitudeSlider.value))"
        traningAdaptationLabel.text = "\(String(format: "%.1f", trainingAdaptationSlider.value))"
        performanceLabel.text = "\(String(format: "%.1f", performanceSlider.value))"
        
        forkliftSecurityLabel.text = "\(String(format: "%.1f", forkliftSecuritySlider.value))"
        forkliftSecurityRoutineLabel.text = "\(String(format: "%.1f", forkliftSecurityRoutineSlider.value))"
        forkliftChecklistLabel.text = "\(String(format: "%.1f", forkliftChecklistSlider.value))"
        forkliftDownloadUploadLabel.text = "\(String(format: "%.1f", forkliftDownloadUploadSlider.value))"
        forkliftExampleToFollowLabel.text = "\(String(format: "%.1f", forkliftExampleToFollowSlider.value))"
        
        deliverySecurityLabel.text = "\(String(format: "%.1f", deliverySecuritySlider.value))"
        deliveryTrainingLabel.text = "\(String(format: "%.1f", deliveryTrainingSlider.value))"
        deliveryKnowSegmentLabel.text = "\(String(format: "%.1f", deliveryKnowSegmentSlider.value))"
        deliveryKnowledgeIndicatorsLabel.text = "\(String(format: "%.1f", deliveryKnowledgeIndicatorsSlider.value))"
        deliveryAssistsLabel.text = "\(String(format: "%.1f", deliveryAssistsSlider.value))"
        deliveryTeamworkLabel.text = "\(String(format: "%.1f", deliveryTeamworkSlider.value))"
        
        warehouseSecurityLabel.text = "\(String(format: "%.1f", warehouseSecuritySlider.value))"
        warehouseSelectionGoalLabel.text = "\(String(format: "%.1f", warehouseSelectionGoalSlider.value))"
        warehousePickeoGoalLabel.text = "\(String(format: "%.1f", warehousePickeoGoalSlider.value))"
        warehouseJobGoalsLabel.text = "\(String(format: "%.1f", warehouseJobGoalsSlider.value))"
        warehouseExampleToFollowLabel.text = "\(String(format: "%.1f", warehouseExampleToFollowSlider.value))"
        
        getEvaluationAverage()
        
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
            if currentEmployee.averageIndicator {
                averageIndicator.textColor = UIColor(red:0.00, green:0.56, blue:0.00, alpha:1.0)
                averageIndicator.text = "↑"
            } else {
                averageIndicator.textColor = .red
                averageIndicator.text = "↓"
            }
        } else {
            averageLabel.text = "Sin evaluaciones"
            averageIndicator.text = ""
        }
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
    
    func getEvaluationAverage() {
        var evalAverage: Float = 0.0
        guard let currentEmployee = employee else {
           return
        }
        switch currentEmployee.type {
        case .forklift:
            evalAverage = ((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (forkliftSecurityLabel.text! as NSString).floatValue + (forkliftSecurityRoutineLabel.text! as NSString).floatValue + (forkliftChecklistLabel.text! as NSString).floatValue + (forkliftDownloadUploadLabel.text! as NSString).floatValue + (forkliftExampleToFollowLabel.text! as NSString).floatValue) / 10
        case .delivery, .deliveryAssistant:
            evalAverage = ((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (deliverySecurityLabel.text! as NSString).floatValue + (deliveryTrainingLabel.text! as NSString).floatValue + (deliveryKnowSegmentLabel.text! as NSString).floatValue + (deliveryKnowledgeIndicatorsLabel.text! as NSString).floatValue + (deliveryAssistsLabel.text! as NSString).floatValue + (deliveryTeamworkLabel.text! as NSString).floatValue) / 11
        case .warehouseAssistant:
            evalAverage = ((cultureAttatchmentLabel.text! as NSString).floatValue + (dpoImplementationLabel.text! as NSString).floatValue + (attitudeLabel.text! as NSString).floatValue + (traningAdaptationLabel.text! as NSString).floatValue + (performanceLabel.text! as NSString).floatValue + (warehouseSecurityLabel.text! as NSString).floatValue + (warehouseSelectionGoalLabel.text! as NSString).floatValue + (warehousePickeoGoalLabel.text! as NSString).floatValue + (warehouseJobGoalsLabel.text! as NSString).floatValue + (warehouseExampleToFollowLabel.text! as NSString).floatValue) / 10
        }
        evaluationAverage.text = "Promedio de evaluación: \(String(format: "%.2f", evalAverage))"
    }
    
    //TableView Configuration
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
