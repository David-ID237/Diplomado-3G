
import UIKit

class InstitutionController: UIViewController {
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var institutionTableView: UITableView!
  @IBOutlet weak var emptyState: UIView!
  
  var selectedNew: NewModel?
  var institutionsList: institutionsList?
  var newsList: newsList?
  var filteredList = [NewModel]()
  
  var institutionService: InstitutionsService?
  var dateService: DateService?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    self.institutionTableView.register( TimeLineCustomCell.self, forCellReuseIdentifier: "InstitutionCell")
    setupUi()
    setupDependencies()
    setInstitutionsSnapshotListener()
  }
  
  private func setupDependencies() {
    institutionService = BasicService.shared.institutionsService
    dateService = BasicService.shared.dateService
  }
  
  private func setInstitutionsSnapshotListener() {
    institutionService!.getInstitutions(success: { (institutionsList) in
      self.institutionsList = institutionsList
      self.doFiltering()
    }) { (error) in
      
    }
  }
  
  func doFiltering() {
    for new in newsList ?? [] {
      if new.nickname == selectedNew?.nickname {
        filteredList.append( new )
      }
    }
    emptyStateProcess()
    institutionTableView.reloadData()
  }
  
  private func emptyStateProcess() {
    if filteredList.isEmpty {
      emptyState.isHidden = false
    } else {
      emptyState.isHidden = true
    }
  }
  
  private func setupUi() {
    self.navigationItem.title = selectedNew?.institutionName
    self.navigationItem.largeTitleDisplayMode = .never
    self.institutionTableView.separatorColor = UIColor.AppColor.mainBlue
    
    nicknameLabel.text = selectedNew?.nickname
  }
}

extension InstitutionController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.institutionTableView.dequeueReusableCell(withIdentifier: "InstitutionCell") as! TimeLineCustomCell
    
    cell.content = filteredList[indexPath.row].content
    cell.nickname = filteredList[indexPath.row].nickname
    cell.date =
      dateService!.dateFormatterFromFirebase(
        date: filteredList[indexPath.row].date ?? Date().description )
    cell.institutionName = filteredList[indexPath.row].institutionName
    cell.selectionStyle = .none
    cell.layoutSubviews()
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.filteredList.count
  }
}
