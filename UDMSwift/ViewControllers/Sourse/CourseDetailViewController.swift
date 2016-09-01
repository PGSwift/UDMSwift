//
//  CourseDetailViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/19/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class CourseDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var courseDetailTable: UITableView!
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseDetailTable.estimatedRowHeight = 44.0
        courseDetailTable.rowHeight = UITableViewAutomaticDimension
    }
}
// MARK: - Table view
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
            var cellVideo = tableView.dequeueReusableCellWithIdentifier(CourseVideoCell.ReuseIdentifier) as? CourseVideoCell
            if cellVideo == nil {
                tableView.registerNib(UINib(nibName: CourseVideoCell.NibName, bundle: nil), forCellReuseIdentifier: CourseVideoCell.ReuseIdentifier)
                cellVideo = tableView.dequeueReusableCellWithIdentifier(CourseVideoCell.ReuseIdentifier) as? CourseVideoCell
                cellVideo?.buttonBuy.addTarget(self, action: #selector(CourseDetailViewController.actionButtonBuy(_:)), forControlEvents: .TouchUpInside)
            }
            return cellVideo!
        case 1:
            var cellDescription = tableView.dequeueReusableCellWithIdentifier(CourseDescriptionCell.ReuseIdentifier) as? CourseDescriptionCell
            if cellDescription == nil {
                tableView.registerNib(UINib(nibName: CourseDescriptionCell.NibName, bundle: nil), forCellReuseIdentifier: CourseDescriptionCell.ReuseIdentifier)
                cellDescription = tableView.dequeueReusableCellWithIdentifier(CourseDescriptionCell.ReuseIdentifier) as? CourseDescriptionCell
                cellDescription?.buttonSeeAll.tag = TabButtonSeeAll.Description.rawValue
                cellDescription?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellDescription!
        case 2:
            var cellCurriculum = tableView.dequeueReusableCellWithIdentifier(CourseCurriculumCell.ReuseIdentifier) as? CourseCurriculumCell
            if cellCurriculum == nil {
                tableView.registerNib(UINib(nibName: CourseCurriculumCell.NibName, bundle: nil), forCellReuseIdentifier: CourseCurriculumCell.ReuseIdentifier)
                cellCurriculum = tableView.dequeueReusableCellWithIdentifier(CourseCurriculumCell.ReuseIdentifier) as? CourseCurriculumCell
                cellCurriculum?.buttonSeeAll.tag = TabButtonSeeAll.Curriculum.rawValue
                cellCurriculum?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellCurriculum!
        case 3:
            var cellReviews = tableView.dequeueReusableCellWithIdentifier(CourseReviewsCell.ReuseIdentifier) as? CourseReviewsCell
            if cellReviews == nil {
                tableView.registerNib(UINib(nibName: CourseReviewsCell.NibName, bundle: nil), forCellReuseIdentifier: CourseReviewsCell.ReuseIdentifier)
                cellReviews = tableView.dequeueReusableCellWithIdentifier(CourseReviewsCell.ReuseIdentifier) as? CourseReviewsCell
                cellReviews?.buttonSeeAll.tag = TabButtonSeeAll.Review.rawValue
                cellReviews?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellReviews!
        case 4:
            var cellInstructor = tableView.dequeueReusableCellWithIdentifier(CourseInstructorCell.ReuseIdentifier) as? CourseInstructorCell
            if cellInstructor == nil {
                tableView.registerNib(UINib(nibName: CourseInstructorCell.NibName, bundle: nil), forCellReuseIdentifier: CourseInstructorCell.ReuseIdentifier)
                cellInstructor = tableView.dequeueReusableCellWithIdentifier(CourseInstructorCell.ReuseIdentifier) as? CourseInstructorCell
                cellInstructor?.buttonSeeAll.tag = TabButtonSeeAll.Instructor.rawValue
                cellInstructor?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellInstructor!
        case 5:
            var cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCell.ReuseIdentifier) as? CourseCell
            if cellCourse == nil {
                tableView.registerNib(UINib(nibName: CourseCell.NibName, bundle: nil), forCellReuseIdentifier: CourseCell.ReuseIdentifier)
                cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCell.ReuseIdentifier) as? CourseCell
            }
            return cellCourse!
        default:
            println("Cannot create cell table at section: \(indexPath.section)")
            break
        }

        var cellTable = tableView.dequeueReusableCellWithIdentifier(UDMConfig.HeaderCellID.defaulCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Default, reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
        }
        cellTable!.textLabel?.text = String(indexPath.section)
        
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Click row \(indexPath.section)")
    }
    // MARK: - Event handling
    func actionButtonBuy(sender: UIButton) {
        println("Click button buy!")
    }
    
    func actionButtonSeeAll(sender: UIButton) {
        switch sender.tag {
        case TabButtonSeeAll.Description.rawValue:
            println("show page See all Description!")
            break
        case TabButtonSeeAll.Curriculum.rawValue:
            println("show page See all Curriculum!")
            break
        case TabButtonSeeAll.Review.rawValue:
            println("show page See all Review!")
            break
        case TabButtonSeeAll.Instructor.rawValue:
            println("show page See all Instructor!")
            break
        default:
            println("Click button See all Not Found action!")
            break
        }
    }
}

