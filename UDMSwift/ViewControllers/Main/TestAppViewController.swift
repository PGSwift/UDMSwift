//
//  TestAppViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/21/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

class TestAppViewController: UIViewController {
    
    // MARK: - custom view ---------xxxxxxxxxx---------
/*   private static let NibName: String = "CustomView"
    
    static func createInstance() -> CustomView {
        return NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[0] as! CustomView
    } */
    
    let petName = "Krakey-poo"
    lazy var businessCardName: () -> String = { [unowned self] in
        return "Mr. Kraken AKA " + self.petName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func postNotification(sender: AnyObject) {
        self.presentViewController(DetailListViewController.createInstance(), animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        //NSNotificationCenter.defaultCenter().postNotification("Demo where post notification in viewcontroller")
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.navigationController?.viewControllers.contains(self) == false {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
}
