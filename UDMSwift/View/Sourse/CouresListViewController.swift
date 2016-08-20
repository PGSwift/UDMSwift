//
//  CouresListViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

class CouresListViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tableCourse: UITableView!
    var courseList: [String]!
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCourse.estimatedRowHeight = 44.0
        tableCourse.rowHeight = UITableViewAutomaticDimension
        courseList = ["1","2","3","4","5","6","7", "8", "9"]
    }
}
//MARK: Table view
extension CouresListViewController: UITableViewDelegate, UITableViewDataSource {
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
