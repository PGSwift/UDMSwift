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

    var teacher = RTeacher()
    
    @IBOutlet weak var textViewContants: UITextView!
    @IBOutlet weak var avata: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var detailString = ""
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("CourseInfoDetailViewControllerID") as! CourseInfoDetailViewController
    }
    
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
         super.viewDidLoad()
        
        println("Init screen CourseInDetailViewController")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Instructor Info"
        
        if detailString == "" {
            textViewContants.text = teacher.descriptions
            name.text = teacher.fullName
            
            let url = teacher.avatar
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let img = UDMHelpers.getImageByURL(with: url)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.avata.image = img
                })
            }
        } else {
            textViewContants.text = detailString
            name.hidden = true
            avata.hidden = true
        }
        
    }
}
