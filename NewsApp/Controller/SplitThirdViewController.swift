//
//  SplitThirdViewController.swift
//  NewsApp
//
//  Created by Jan Moravek on 09/02/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit

class SplitThirdViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

    
    
}
