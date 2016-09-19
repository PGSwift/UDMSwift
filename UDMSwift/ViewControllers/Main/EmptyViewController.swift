//
//  EmptyViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 9/13/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import Foundation

class EmptyViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: - Properties
    private var handlerNotificationConnetInternet: AnyObject?
    
    // MARK: Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("EmptyViewControllerID") as! EmptyViewController
    }

    // MARK: Notification
    func registerNotification() {
        
        handlerNotificationConnetInternet = NSNotificationCenter.defaultCenter().addObserverForName(UDMConfig.Notification.ConnectedInternet, object: nil, queue: nil, usingBlock: { notification in
            
            println("Class: \(NSStringFromClass(self.dynamicType)) recived: \(notification.name)")
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func deregisterNotification() {
        
        if let _ = handlerNotificationConnetInternet {
            NSNotificationCenter.defaultCenter().removeObserver(handlerNotificationConnetInternet!)
        }
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init EmptyViewController screen)")
        
        registerNotification()
    }
    
    deinit {
        deregisterNotification()
    }
}