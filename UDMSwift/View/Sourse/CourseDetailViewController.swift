//
//  CourseDetailViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/19/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var tableCourseDetail: UITableView!
    
    //MARK: Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
//MARK: Table view
extension CourseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(idDefauleCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Default, reuseIdentifier: idDefauleCell)
        }
        cellTable!.textLabel?.text = String(indexPath.section)
        
        return cellTable!

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("click row \(indexPath.row)")
    }
}

