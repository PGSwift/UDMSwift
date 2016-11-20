//
//  RatingViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 11/9/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController, ViewControllerProtocol {

    // MARK: - Properties
    
    @IBOutlet weak var ratingControl: CosmosView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!

    var idCourses = ""
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("RatingViewControllerID") as! RatingViewController
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen MyCoursesViewController")
 
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Write review"
    }
    
    @IBAction func actionSend(sender: AnyObject) {
        
        let data = UDMInfoDictionaryBuilder.shareInstance.builderRating(withTitle: titleTextField.text, description: commentTextView.text, value: String(ratingControl.rating))
        
        UDMService.shareInstance.ratingCourses(with: data, coursesID: idCourses) { data, success in
            
            if success {
                println("Comment success!")
                
                dispatch_async(dispatch_get_main_queue(), { 
                    self.dismissViewControllerAnimated(true, completion: {
                        
                    })
                })
                
            } else {
                guard let message = data["message"] as? String else {
                    println("Not found message error")
                    return
                }
                
                UDMAlert.alert(title: "ERROR", message: message, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                return
            }
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
    
    }
}
