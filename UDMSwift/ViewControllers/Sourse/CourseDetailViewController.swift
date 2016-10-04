//
//  CourseDetailViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/19/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class CourseDetailViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    @IBOutlet weak var courseDetailTable: UITableView!
    
    var course = RCourse()
    var courseArr: [RCourse] = []
    var teacher = RTeacher()
    var curriculumnArr = [RCurruculum]()
    
    private var handlerNotificationPlayVideo: AnyObject?
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("CourseDetailViewControllerID") as! CourseDetailViewController
    }
    
    func configItems() {
        self.automaticallyAdjustsScrollViewInsets = false
        courseDetailTable.contentInset = UIEdgeInsetsZero;
        courseDetailTable.estimatedRowHeight = 44.0
        courseDetailTable.rowHeight = UITableViewAutomaticDimension
    }
    
    func initData() {
        //Get curriculumns
        let data = UDMInfoDictionaryBuilder.shareInstance.getCourseDetail(with: UDMConfig.CourseIDRoot)
        UDMService.shareInstance.getListDataFromServer(with: data, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                println("CurriculumnArr detail --> \(Cdata)")
                
                CacheManager.shareInstance.updateList(with: Cdata, type: UDMConfig.APIService.ModelName.Curriculums)
                
                if let curriculumnArr = CacheManager.shareInstance.getRCurriculmList() {
                    self.curriculumnArr = curriculumnArr
                    for cur in curriculumnArr {
                        println("curriculumnArr list: ---> \n \(cur)")
                    }
                    self.courseDetailTable.reloadData()
                }
                
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                println("ERROR message: \(data["message"]!)")
            }
        })
        
        // Get Teacher Info
        let dataTeacher = UDMInfoDictionaryBuilder.shareInstance.getTeacherInfo(with: course.authorID)
        UDMService.shareInstance.getListDataFromServer(with: dataTeacher, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [String: AnyObject] else {
                    println("Not found data caches")
                    return
                }
                println("Teacher info --> \(Cdata)")
                var changeData = Cdata
                changeData.changeKey("description", to: "descriptions")
                
                changeData.removeValueNil()
                
                CacheManager.shareInstance.update(with: changeData, type: UDMConfig.APIService.ModelName.Teacher)
                
                if let teacherArr = CacheManager.shareInstance.getRTeacherList() {
                    for tearch in teacherArr {
                        self.teacher = tearch
                        println("Tearch list: ---> \n \(tearch)")
                    }
                    self.courseDetailTable.reloadData()
                }
                
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                println("ERROR message: \(data["message"]!)")
            }
            
        })
        
    }
    
    // MARK: - Notification
    struct Notification {
        static let PlayVideo = "NotificationPlayVideo"
    }
    
    func registerNotification() {
        
        handlerNotificationPlayVideo = NSNotificationCenter.defaultCenter().addObserverForName(CourseDetailViewController.Notification.PlayVideo, object: nil, queue: nil, usingBlock: { notification in
            
            println("Class: \(NSStringFromClass(self.dynamicType)) recived: \(notification.name)")
            
            guard let user = notification.userInfo else {
                println("Not found userInfo")
                return
            }
            
            let url = user["URLVIDEO"] as! String
            
            let videoViewController = VideoViewController.createInstance() as! VideoViewController
            videoViewController.strUrl = url
            self.navigationController?.pushViewController(videoViewController, animated: true)
        })
    }
    
    func deregisterNotification() {
        
        if let _ = handlerNotificationPlayVideo {
            NSNotificationCenter.defaultCenter().removeObserver(handlerNotificationPlayVideo!)
        }
    }
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configItems()
        initData()
        registerNotification()
    }
    
    deinit {
        deregisterNotification()
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 5 {
            return 20.0
        }
        return 1.0
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
            
            cellVideo?.courseName.text = course.title
            cellVideo?.costSourse.text = "$" + course.newPrice
            cellVideo?.labelPesonName.text = course.author
            
            let url = course.thumbnail
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let img = UDMHelpers.getImageByURL(with: url)
                
                dispatch_async(dispatch_get_main_queue(), {
                    cellVideo?.courseVideo.image = img
                })
            }
            
            return cellVideo!
        case 1:
            
            var cellDescription = tableView.dequeueReusableCellWithIdentifier(CourseDescriptionCell.ReuseIdentifier) as? CourseDescriptionCell
            if cellDescription == nil {
                tableView.registerNib(UINib(nibName: CourseDescriptionCell.NibName, bundle: nil), forCellReuseIdentifier: CourseDescriptionCell.ReuseIdentifier)
                cellDescription = tableView.dequeueReusableCellWithIdentifier(CourseDescriptionCell.ReuseIdentifier) as? CourseDescriptionCell
                cellDescription?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Description
                cellDescription?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            cellDescription?.textViewContent.text = course.descriptions
            
            return cellDescription!
        case 2:
            var cellCurriculum = tableView.dequeueReusableCellWithIdentifier(CourseCurriculumCell.ReuseIdentifier) as? CourseCurriculumCell
            if cellCurriculum == nil {
                tableView.registerNib(UINib(nibName: CourseCurriculumCell.NibName, bundle: nil), forCellReuseIdentifier: CourseCurriculumCell.ReuseIdentifier)
                cellCurriculum = tableView.dequeueReusableCellWithIdentifier(CourseCurriculumCell.ReuseIdentifier) as? CourseCurriculumCell
                cellCurriculum?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Curriculum
                cellCurriculum?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            cellCurriculum?.curriculumnArr = curriculumnArr
            cellCurriculum?.reloadData()
            return cellCurriculum!
        case 3:
            var cellReviews = tableView.dequeueReusableCellWithIdentifier(CourseReviewsCell.ReuseIdentifier) as? CourseReviewsCell
            if cellReviews == nil {
                tableView.registerNib(UINib(nibName: CourseReviewsCell.NibName, bundle: nil), forCellReuseIdentifier: CourseReviewsCell.ReuseIdentifier)
                cellReviews = tableView.dequeueReusableCellWithIdentifier(CourseReviewsCell.ReuseIdentifier) as? CourseReviewsCell
                cellReviews?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Review
                cellReviews?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            return cellReviews!
        case 4:
            var cellInstructor = tableView.dequeueReusableCellWithIdentifier(CourseInstructorCell.ReuseIdentifier) as? CourseInstructorCell
            if cellInstructor == nil {
                tableView.registerNib(UINib(nibName: CourseInstructorCell.NibName, bundle: nil), forCellReuseIdentifier: CourseInstructorCell.ReuseIdentifier)
                cellInstructor = tableView.dequeueReusableCellWithIdentifier(CourseInstructorCell.ReuseIdentifier) as? CourseInstructorCell
                cellInstructor?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Instructor
                cellInstructor?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            cellInstructor?.teacher = teacher
            return cellInstructor!
        case 5:
            var cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCellDetail.ReuseIdentifier) as? CourseCellDetail
            if cellCourse == nil {
                tableView.registerNib(UINib(nibName: CourseCellDetail.NibName, bundle: nil), forCellReuseIdentifier: CourseCellDetail.ReuseIdentifier)
                cellCourse = tableView.dequeueReusableCellWithIdentifier(CourseCellDetail.ReuseIdentifier) as? CourseCellDetail
            }
            let course = courseArr[indexPath.row]
            
            cellCourse?.title.text = course.title
            cellCourse?.teacherName.text = course.author
            cellCourse?.moneyTextField.text = course.oldPrice
            cellCourse?.moneyNew.text = course.newPrice
            
            let url = self.courseArr[indexPath.row].thumbnail
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let img = UDMHelpers.getImageByURL(with: url)
                
                dispatch_async(dispatch_get_main_queue(), {
                    cellCourse?.courseImage.image = img
                })
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
        case TabConfig.TabButtonSeeAll.Description:
            println("show page See all Description!")
            break
        case TabConfig.TabButtonSeeAll.Curriculum:
            println("show page See all Curriculum!")
            break
        case TabConfig.TabButtonSeeAll.Review:
            println("show page See all Review!")
            break
        case TabConfig.TabButtonSeeAll.Instructor:
            println("show page See all Instructor!")
            break
        default:
            println("Click button See all Not Found action!")
            break
        }
    }
}

