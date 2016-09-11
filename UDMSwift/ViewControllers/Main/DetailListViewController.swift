//
//  DetailListViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

final class DetailListViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    @IBOutlet weak var tableDetail: UITableView!
    
    var courseList: [String] = []
    
    struct Notification {
        static let updateDraft = "UpdateDraftOfConversation"
    }
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("DetailListViewControllerID") as! DetailListViewController
    }
    
    func configItems() {
        
        tableDetail.estimatedRowHeight = 44.0
        tableDetail.rowHeight = UITableViewAutomaticDimension
    }
    
    func initData() {
        courseList = ["1","2","3","4","5","6","7", "8", "9"]
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen DetailListViewController")
        
        configItems()
        
        initData()
    }
}
// MARK: - Table view
extension DetailListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCell.ReuseIdentifier) as? CourseCell
        if cellCourse == nil {
            tableView.registerNib(UINib(nibName: CourseCell.NibName, bundle: nil), forCellReuseIdentifier: CourseCell.ReuseIdentifier)
            cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCell.ReuseIdentifier) as? CourseCell
        }
        return cellCourse!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Clicked cell row: \(indexPath.row)")
    }
}

