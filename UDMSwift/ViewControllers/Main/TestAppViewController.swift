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

    private var handlerNotificationABC: AnyObject?
    
    func registerNotification() {
       handlerNotificationABC = NSNotificationCenter.defaultCenter().addObserverForName(Notification.updateDraft, object: self, queue: nil, usingBlock: { (notification)  in
        print("observer \(notification.name)")
       })
    }
    
    func deregisterNofitication() {
        if let handlerNotificationABC = handlerNotificationABC {
            NSNotificationCenter.defaultCenter().removeObserver(handlerNotificationABC)
        }
    }
    
    deinit {
        deregisterNofitication()
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
    
    
    @IBAction func demoButton(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
    }
    
    @IBAction func postNotification(sender: AnyObject) {
       // self.presentViewController(DetailListViewController.createInstance(), animated: true, completion: nil)
    NSNotificationCenter.defaultCenter().postNotificationName(Notification.updateDraft, object: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        //NSNotificationCenter.defaultCenter().postNotification("Demo where post notification in viewcontroller")  // Remove init Notification
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.navigationController?.viewControllers.contains(self) == false {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
}
