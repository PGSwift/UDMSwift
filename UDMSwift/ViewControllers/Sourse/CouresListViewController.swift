//
//  CouresListViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

final class CouresListViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    @IBOutlet weak var courseTable: UITableView!
    
    var courseArr: [RCourse] = []
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("CouresListViewControllerID") as! CouresListViewController
    }
    
    func configItems() {
        courseTable.estimatedRowHeight = 44.0
        courseTable.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen CouresListViewController")

        configItems()
    }

}
// MARK: - Table view
extension CouresListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellCourse: CourseCell? = tableView.dequeueReusableCellWithIdentifier(CourseCell.ReuseIdentifier) as? CourseCell
        if cellCourse == nil {
            tableView.registerNib(UINib(nibName: CourseCell.NibName, bundle: nil), forCellReuseIdentifier: CourseCell.ReuseIdentifier)
            cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCell.ReuseIdentifier) as? CourseCell
        }
        let course = courseArr[indexPath.row]
        cellCourse?.title.text = course.title
        cellCourse?.teacherName.text = course.author
        cellCourse?.moneyTextField.text = "$" +  course.newPrice
        cellCourse?.moneyNew.text = "$" + course.oldPrice
        
        cellCourse?.ratingControl.rating = Double(course.review) ?? 3.5
        
        let url = self.courseArr[indexPath.row].thumbnail
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let img = UDMHelpers.getImageByURL(with: url)
            
            dispatch_async(dispatch_get_main_queue(), {
                cellCourse?.courseImage.image = img
            })
        }
        
        return cellCourse!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Clicked cell row: \(indexPath.row)")
        
        let courseDetailViewController: CourseDetailViewController = CourseDetailViewController.createInstance() as! CourseDetailViewController
        courseDetailViewController.course = courseArr[indexPath.row]
        
        var courseArrSmall = [RCourse]()
        for (index, course) in courseArr.enumerate() {
            if index > 5 {
                break
            }
            courseArrSmall.append(course)
        }
        courseDetailViewController.courseArr = courseArrSmall
        self.navigationController?.pushViewController(courseDetailViewController, animated: true)
    }
}
