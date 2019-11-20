//
//  EmployeeViewController.swift
//  Pooler
//
//  Created by Marco Antonio Ruiz Robles on 8/14/19.
//  Copyright © 2019 Marco Antonio Ruiz Robles. All rights reserved.
//

import UIKit

class EmployeeViewController: UITabBarController {
    
    
    var employee :Employee?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewControllers = viewControllers else { return  }
        for viewController in viewControllers {
            if let employeeNavigationC = viewController as? EmployeeViewController{
                if let employeeViewController =  employeeNavigationC.viewControllers?.first as? EmployeeHomeViewController{
                    employeeViewController.employee = employee!
                }
            }
        }
        // Do any additional setup after loading the view.
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
