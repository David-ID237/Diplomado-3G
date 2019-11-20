//
//  CustoTabBarViewController.swift
//  shopapp
//
//  Created by David on 7/20/19.
//  Copyright © 2019 David. All rights reserved.
//

import UIKit

enum tabItemName: String{
    
    case inicio
    case categorías
    case cesta
    case cuenta
    
    var value: String? {
        switch self {
            case .inicio: return "home"
            case .categorías: return "categories"
            case .cesta: return "cart"
            case .cuenta: return "account"
        }
    }
}

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        setUpUI()
    }
    
    func setUpUI() {
        if let items = self.tabBar.items {
            for item in items {
                if let image = item.image {
                    item.image = image.withRenderingMode(.alwaysOriginal)
                    if let titleName = item.title?.lowercased() {
                        guard let titleIcon = tabItemName.init(rawValue: titleName)?.value else { return }
                        item.selectedImage = UIImage(named: "\(titleIcon)-selected")?.withRenderingMode(.alwaysOriginal)
                        
                    }
                }
            }
        }
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
