//
//  SettingViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class SettingViewController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Initialzation
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Init screen SettingViewController")
        self.navigationItem.title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
