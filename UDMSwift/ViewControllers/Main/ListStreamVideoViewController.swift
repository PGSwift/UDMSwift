//
//  ListStreamVideoViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 10/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class ListStreamVideoViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("ListStreamVideoViewControllerID") as! ListStreamVideoViewController
    }

    func initData() {
       
    }
    
    func configItems() {
        // Init screen Sign
        let signInViewController = SignInViewController.createInstance()
        self.navigationController?.pushViewController(signInViewController, animated: true)
        
        self.navigationItem.title = "Featured"
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init main ListStreamVideoViewController")
        
        configItems()
        initData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    @IBAction func actionCreateStream(sender: AnyObject) {
        
        let streamVideoViewController = StreamVideoViewController.createInstance()
        self.navigationController?.pushViewController(streamVideoViewController, animated: true)
        
        println("name stream: \(self.nameTextField.text)")
        println("Discription stream: \(self.descriptionTextField.text)")
    }
}
