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
<<<<<<< HEAD
    var streamVideoInfoList = [[String: AnyObject]]()
    
    @IBOutlet weak var tableStream: UITableView!
=======
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    
    
>>>>>>> origin/master
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
    
    func configItems() {
        tableStream.tableFooterView = UIView()
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init main ListStreamVideoViewController")
        
        configItems()
        initData()
        configItems()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Stream List"
    }
<<<<<<< HEAD
    // MARK: - Handling Event
    
}

// MARK: - Table view
extension ListStreamVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamVideoInfoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(UDMConfig.HeaderCellID.defaulCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Subtitle, reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
            cellTable?.textLabel?.text = ""
            cellTable?.detailTextLabel?.text = ""
            cellTable?.imageView?.image = UIImage(named: "x")
        }
=======
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
>>>>>>> origin/master
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    @IBAction func actionCreateStream(sender: AnyObject) {
        
        let streamVideoViewController = StreamVideoViewController.createInstance()
        self.navigationController?.pushViewController(streamVideoViewController, animated: true)
        
        println("name stream: \(self.nameTextField.text)")
        println("Discription stream: \(self.descriptionTextField.text)")
    }
}
