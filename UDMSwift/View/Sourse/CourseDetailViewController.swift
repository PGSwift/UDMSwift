//
//  CourseDetailViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/19/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

enum tabButtonSeeAll: Int {
    case Description = 1, Curriculum, Review, Instructor
}

class CourseDetailViewController: UIViewController {
    //MARK: Properties
    let idCourseVideoCell = "idCourseVideoCell"
    let idCourseDescriptionCell = "idCourseDescriptionCell"
    let idCourseCurriculumCell = "idCourseCurriculumCell"
    let idCourseReviewsCell = "idCourseReviewsCell"
    let idCourseCell = "idCourseCell"
    let idCourseInstructorCell = "idCourseInstructorCell"
    
    
    @IBOutlet weak var tableCourseDetail: UITableView!
    
    //MARK: Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableCourseDetail.estimatedRowHeight = 44.0
        tableCourseDetail.rowHeight = UITableViewAutomaticDimension
    }
}
//MARK: Table view
extension CourseDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 5 {
            return 5
        }
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 5 {
            return "Course tha other students viewed"
        }
        return ""
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            var cellVideo = tableView.dequeueReusableCellWithIdentifier(idCourseVideoCell) as? CourseVideoCell
            if cellVideo == nil {
                tableView.registerNib(UINib(nibName: "CourseVideoCell", bundle: nil), forCellReuseIdentifier: idCourseVideoCell)
                cellVideo = tableView.dequeueReusableCellWithIdentifier(idCourseVideoCell) as? CourseVideoCell
                cellVideo?.buttonBuy.addTarget(self, action: #selector(CourseDetailViewController.actionButtonBuy(_:)), forControlEvents: .TouchUpInside)
            }
            return cellVideo!
        case 1:
            var cellDescription = tableView.dequeueReusableCellWithIdentifier(idCourseDescriptionCell) as? CourseDescriptionCell
            if cellDescription == nil {
                tableView.registerNib(UINib(nibName: "CourseDescriptionCell", bundle: nil), forCellReuseIdentifier: idCourseDescriptionCell)
                cellDescription = tableView.dequeueReusableCellWithIdentifier(idCourseDescriptionCell) as? CourseDescriptionCell
                cellDescription?.buttonSeeAll.tag = tabButtonSeeAll.Description.rawValue
                cellDescription?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellDescription!
        case 2:
            var cellCurriculum = tableView.dequeueReusableCellWithIdentifier(idCourseCurriculumCell) as? CourseCurriculumCell
            if cellCurriculum == nil {
                tableView.registerNib(UINib(nibName: "CourseCurriculumCell", bundle: nil), forCellReuseIdentifier: idCourseCurriculumCell)
                cellCurriculum = tableView.dequeueReusableCellWithIdentifier(idCourseCurriculumCell) as? CourseCurriculumCell
                cellCurriculum?.buttonSeeAll.tag = tabButtonSeeAll.Curriculum.rawValue
                cellCurriculum?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellCurriculum!
        case 3:
            var cellReviews = tableView.dequeueReusableCellWithIdentifier(idCourseReviewsCell) as? CourseReviewsCell
            if cellReviews == nil {
                tableView.registerNib(UINib(nibName: "CourseReviewsCell", bundle: nil), forCellReuseIdentifier: idCourseReviewsCell)
                cellReviews = tableView.dequeueReusableCellWithIdentifier(idCourseReviewsCell) as? CourseReviewsCell
                cellReviews?.buttonSeeAll.tag = tabButtonSeeAll.Review.rawValue
                cellReviews?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellReviews!
        case 4:
            var cellInstructor = tableView.dequeueReusableCellWithIdentifier(idCourseInstructorCell) as? CourseInstructorCell
            if cellInstructor == nil {
                tableView.registerNib(UINib(nibName: "CourseInstructorCell", bundle: nil), forCellReuseIdentifier: idCourseInstructorCell)
                cellInstructor = tableView.dequeueReusableCellWithIdentifier(idCourseInstructorCell) as? CourseInstructorCell
                cellInstructor?.buttonSeeAll.tag = tabButtonSeeAll.Instructor.rawValue
                cellInstructor?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellInstructor!
        case 5:
            var cellCourse = tableView.dequeueReusableCellWithIdentifier(idCourseCell) as? CourseCell
            if cellCourse == nil {
                tableView.registerNib(UINib(nibName: "CourseCell", bundle: nil), forCellReuseIdentifier: idCourseCell)
                cellCourse = tableView.dequeueReusableCellWithIdentifier(idCourseCell) as? CourseCell
            }
            return cellCourse!
        default:
            print("cannot create cell table at section: \(indexPath.section)")
            break
        }

        var cellTable = tableView.dequeueReusableCellWithIdentifier(idDefauleCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Default, reuseIdentifier: idDefauleCell)
        }
        cellTable!.textLabel?.text = String(indexPath.section)
        
        return cellTable!

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("click row \(indexPath.section)")
    }
    //MARK: Event handling
    func actionButtonBuy(sender: UIButton) {
        print("Click button buy!")
    }
    
    func actionButtonSeeAll(sender: UIButton) {
        switch sender.tag {
        case tabButtonSeeAll.Description.rawValue:
            print("show page See all Description!")
            break
        case tabButtonSeeAll.Curriculum.rawValue:
            print("show page See all Curriculum!")
            break
        case tabButtonSeeAll.Review.rawValue:
            print("show page See all Review!")
            break
        case tabButtonSeeAll.Instructor.rawValue:
            print("show page See all Instructor!")
            break
        default:
            print("Click button See all Not Found action!")
            break
        }
    }
}

