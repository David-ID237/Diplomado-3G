//
//  CartViewController.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var paidNowButton: UIButton!
    var products: [Product] = [Product]()
    let rehuseId = "rehuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setUpUIForDefaultView()
        title = "Cesta de compras"
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        productsTableView.delegate = self
        productsTableView.dataSource = self
        productsTableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: rehuseId)
        productsTableView.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.ShopApp.backgroundPage
        amountLabel.textColor = UIColor.ShopApp.textImportant
        footerView.addBorder(side: .top, thickness: 1.50, color: UIColor.ShopApp.backgroundPage)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        products = ShopCart.shared.products
        productsTableView.reloadData();
        totalUI()
    }
    
    @IBAction func paidNowButtonAction(_ sender: UIButton) {
    }
    
    func totalUI() {
        calcTotal()
        paidNowButton.isEnabled = (products.count == 0) ? false : true
        paidNowButton.alpha = (products.count == 0) ? 0.8 : 1.0
    }

    func calcTotal() {
        var total:Float = 0.0
        
        for item in products {
                total += (Float(item.price) ?? 0) * (Float(item.number ?? 1))
        }
        let totalToStr = String(format: "%.2f", total)
        amountLabel.text = "Total (sin envío): $ \(totalToStr)"
        
    }
    
    func reloadView() {
        totalUI()
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[2]
            tabItem.badgeValue = products.count > 0 ? String(products.count) : nil
        }
    }
    
    
    @IBAction func payToControllerButtonAction(_ sender: UIButton) {
        let payViewController = storyboard?.instantiateViewController(withIdentifier: "PayViewController") as! PayViewController
        payViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(payViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: rehuseId, for: indexPath) as? CarTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.product = products[indexPath.row]
        cell.cellIndex = indexPath.row
        cell.cellActionDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            products.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            ShopCart.shared.products = products
            productsTableView.reloadData()
            reloadView()
        }
    }
    

}

extension CartViewController: CellActionDelegate {
    
    func updateProduct(index: Int, product: Product) {
        products[index] = product
        ShopCart.shared.products = products
        reloadView()
    }
    
    
    func presentView(view: UIViewController) {
        self.present(view, animated: true)
    }
    
    func deleteCell(cellId: Int) {
        products.remove(at: cellId)
        ShopCart.shared.products = products
        let indexPath = IndexPath(item: 0, section: cellId)
        productsTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        productsTableView.reloadData()
        reloadView()
    }
    
    
    
}
