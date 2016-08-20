//
//  DetailListViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

class DetailListViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tableDetail: UITableView!
    var courseList: [String]!
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDetail.estimatedRowHeight = 44.0
        tableDetail.rowHeight = UITableViewAutomaticDimension
        courseList = ["1","2","3","4","5","6","7", "8", "9"]
    }
}
//MARK: Table view
extension DetailListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellCourse = tableView.dequeueReusableCellWithIdentifier(idCourseCell) as? CourseCell
        if cellCourse == nil {
            tableView.registerNib(UINib(nibName: "CourseCell", bundle: nil), forCellReuseIdentifier: idCourseCell)
            cellCourse = tableView.dequeueReusableCellWithIdentifier(idCourseCell) as? CourseCell
        }
        return cellCourse!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("clicked cell row: \(indexPath.row)")
    }
}

