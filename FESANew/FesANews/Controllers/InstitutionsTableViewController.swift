//
//  InstitutionsTableViewController.swift
//  FesANews
//
//  Created by Alan Vargas on 7.08.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class InstitutionsTableViewController: UITableViewController {
  
  var institutions: institutionsList?
  var institutionsService: InstitutionsService?
  var newsService: NewsService?
  let userDefaults = UserDefaults()
  
  var nickname: String?
  var institutionName: String?

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  private func setup() {
    setupDependencies()
    getInstitutions()
  }
  
  private func setupDependencies() {
    institutionsService = BasicService.shared.institutionsService
    newsService = BasicService.shared.newsService
  }
  
  private func getInstitutions() {
    institutionsService?.getInstitutions(success: { (institutionsList) in
      self.institutions = institutionsList
      self.tableView.reloadData()
    }, failure: { (error) in
      
    })
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return institutions?.count ?? 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "institutionCell", for: indexPath)
    cell.textLabel?.text = institutions?[indexPath.row].name
    cell.detailTextLabel?.text = institutions?[indexPath.row].nickname
    cell.selectionStyle = .none
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedOne = institutions![indexPath.row]
    institutionName = selectedOne.name
    nickname = selectedOne.nickname
    
    performSegue(withIdentifier: "institutionSegue3", sender: self)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let controller = segue.destination as? InstitutionController {
      controller.newsList = newsService?.getNewsListFromRam()
      var newModel = NewModel()
      newModel.nickname = nickname
      newModel.institutionName = institutionName
      controller.selectedNew = newModel
    }
  }
}
