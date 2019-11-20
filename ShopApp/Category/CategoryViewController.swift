//
//  CategoryViewController.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    var categories: [Category] = [Category]()
    let rehuseID:String = "banner"
    let client = CategoryClient()
    var selectedRawId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setUpUIForDefaultView()
        navigationItem.title = "Categorías"
        setUpUITable()
        getData()
    }
    
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpUITable() {
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: rehuseID)
        categoryTableView.separatorStyle = .none
    }
    
    func getData() {
        CategoryClient.shared.list { [weak self] (categories) in
            self?.categories = categories
            self?.categoryTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rehuseID, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.name = categories[indexPath.row].name
        cell.url = Config.host.value! + "/" + categories[indexPath.row].thumbnailUrl
        cell.uploadView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRawId = indexPath.row
        performSegue(withIdentifier: "categoryToProductsbyCat", sender: nil)
    }
    
}

extension CategoryViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToProductsbyCat" {
            guard let dest = segue.destination as? IndividualCategoryViewController else { return }
            dest.category = categories[selectedRawId]
        }
    }
    
}
