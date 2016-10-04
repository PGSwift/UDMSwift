//
//  SettingViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class SettingViewController: UITableViewController, ViewControllerProtocol {
    // MARK: - Properties
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("SettingViewControllerID") as! SettingViewController
    }
    
    func configItems() {
        
        self.navigationItem.title = "Settings"
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen SettingViewController")
        
        configItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            let signInViewController = SignInViewController.createInstance()
            self.navigationController?.pushViewController(signInViewController, animated: true)
        }
    }

}
