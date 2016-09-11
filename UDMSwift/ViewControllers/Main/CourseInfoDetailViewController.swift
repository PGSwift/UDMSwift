//
//  CourseInfoDetailViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//
import UIKit

final class CourseInfoDetailViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var textViewContants: UITextView!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("DetailListViewControllerID") as! CourseInfoDetailViewController
    }
    
    func configItems() {
        
    }
    
    func initData() {
        
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
         super.viewDidLoad()
        
        println("Init screen CourseInDetailViewController")
    }
}
