//
//  SignUpViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/23/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

class SignUpViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("SignUpViewControllerID") as! SignUpViewController
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
