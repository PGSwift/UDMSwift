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
    
    // MARK: - Name Notificatoin ---------xxxxxxxxxx---------
    func demoPostNotification() {
        NSNotificationCenter.defaultCenter().postNotificationName(DetailListViewController.Notification.updateDraft, object: nil)
    }
    
    struct Notification {
        static let updateDraft = "UpdateDraftOfConversation"
    }
    func demoaddObserverNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TestAppViewController.demoPostNotification), name: Notification.updateDraft, object: nil)
    }
    // ---------xxxxxxxxxx---------

    // MAKR: - Using lazy 
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(), forState: .Normal)
        button.tintColor = UIColor.lightGrayColor()
        button.tintAdjustmentMode = .Normal
        button.addTarget(self, action: #selector(TestAppViewController.demoPostNotification), forControlEvents: UIControlEvents.TouchUpInside)
        return button
    }()
    // ---------xxxxxxxxxx---------
    
    
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
