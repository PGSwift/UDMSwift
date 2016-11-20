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
    var inforDetail:[[String: AnyObject]] = [[:]]
    var courseArr: [RCourse] = []
    var teacher = RTeacher()
    var curriculumnArr = [RCurruculum]()
    var isRemoveWishList = false
    
    var isBuy = false
    var isWishList = false
    var coursesDetail = ""
    
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
        let data = UDMInfoDictionaryBuilder.shareInstance.getCurriculums(with: UDMConfig.CourseIDRoot)
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
        
        // Get detail courses
        let dataDetail = UDMInfoDictionaryBuilder.shareInstance.getCoursesDetail(with: course.id)
        
        UDMService.shareInstance.getListDataFromServer(with: dataDetail, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                self.inforDetail = Cdata
                println("Courses detail --> \(Cdata)")
                
                for value in self.inforDetail {
                    if let _isBuy = value["buy"] as? Int {
                        if _isBuy == 1 {
                            self.isBuy = true
                        }
                    }
                    if let _isWishList = value["wishList"] as? Int {
                        if _isWishList == 1 {
                            self.isWishList = true
                        }
                    }
                    
                    self.coursesDetail = (value["description"] as? String) ?? ""
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.courseDetailTable.reloadData()
                })
                
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
        //initData()
        registerNotification()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initData()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
            return courseArr.count
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
                cellVideo?.selectionStyle = .None
                if isRemoveWishList {
                    cellVideo?.addButton.addTarget(self, action: #selector(CourseDetailViewController.actionButtonRemoveWishList(_:)), forControlEvents: .TouchUpInside)
                    cellVideo?.addButton.selected = true
                } else {
                    cellVideo?.addButton.addTarget(self, action: #selector(CourseDetailViewController.actionButtonAddWishList(_:)), forControlEvents: .TouchUpInside)
                    cellVideo?.addButton.setTitle("", forState: UIControlState.Normal)
                }
                cellVideo?.buttonBuy.addTarget(self, action: #selector(CourseDetailViewController.actionButtonBuy(_:)), forControlEvents: .TouchUpInside)
                cellVideo?.buttonBuy.selected = false
                
                cellVideo?.ratingControl.didFinishTouchingCosmos = { rate in
                    println("number rating == \(rate)")
                    dispatch_async(dispatch_get_main_queue(), {
                        let ratingViewController = RatingViewController.createInstance() as! RatingViewController
                        ratingViewController.idCourses = self.course.id
                        self.navigationController?.pushViewController(ratingViewController, animated: true)
                        //self.presentViewController(ratingViewController, animated: true, completion: nil)
                    })
                }
            }
            
            if isBuy {
                cellVideo?.buttonBuy.selected = true
            }
            
            if isWishList && !isRemoveWishList {
                cellVideo?.addButton.selected = true
                cellVideo?.addButton.addTarget(self, action: #selector(CourseDetailViewController.actionButtonRemoveWishList(_:)), forControlEvents: .TouchUpInside)
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
                cellDescription?.selectionStyle = .None
                cellDescription?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            cellDescription?.textViewContent.text = self.coursesDetail
            
            return cellDescription!
        case 2:
            var cellCurriculum = tableView.dequeueReusableCellWithIdentifier(CourseCurriculumCell.ReuseIdentifier) as? CourseCurriculumCell
            if cellCurriculum == nil {
                tableView.registerNib(UINib(nibName: CourseCurriculumCell.NibName, bundle: nil), forCellReuseIdentifier: CourseCurriculumCell.ReuseIdentifier)
                cellCurriculum = tableView.dequeueReusableCellWithIdentifier(CourseCurriculumCell.ReuseIdentifier) as? CourseCurriculumCell
                cellCurriculum?.selectionStyle = .None
                cellCurriculum?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Curriculum
                cellCurriculum?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            cellCurriculum?.curriculumnArr = curriculumnArr
            cellCurriculum?.reloadData()
            
            if !isBuy {
                cellCurriculum?.userInteractionEnabled = false
            } else {
                cellCurriculum?.userInteractionEnabled = true
            }
            
            return cellCurriculum!
        case 3:
            var cellReviews = tableView.dequeueReusableCellWithIdentifier(CourseReviewsCell.ReuseIdentifier) as? CourseReviewsCell
            if cellReviews == nil {
                tableView.registerNib(UINib(nibName: CourseReviewsCell.NibName, bundle: nil), forCellReuseIdentifier: CourseReviewsCell.ReuseIdentifier)
                cellReviews = tableView.dequeueReusableCellWithIdentifier(CourseReviewsCell.ReuseIdentifier) as? CourseReviewsCell
                cellReviews?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Review
                cellReviews?.selectionStyle = .None
                cellReviews?.buttonSeeAll.addTarget(self, action: #selector(CourseDetailViewController.actionButtonSeeAll(_:)), forControlEvents: .TouchUpInside)
            }
            cellReviews?.idCourses = course.id
            cellReviews?.reloadData()
            return cellReviews!
        case 4:
            var cellInstructor = tableView.dequeueReusableCellWithIdentifier(CourseInstructorCell.ReuseIdentifier) as? CourseInstructorCell
            if cellInstructor == nil {
                tableView.registerNib(UINib(nibName: CourseInstructorCell.NibName, bundle: nil), forCellReuseIdentifier: CourseInstructorCell.ReuseIdentifier)
                cellInstructor = tableView.dequeueReusableCellWithIdentifier(CourseInstructorCell.ReuseIdentifier) as? CourseInstructorCell
                cellInstructor?.buttonSeeAll.tag = TabConfig.TabButtonSeeAll.Instructor
                cellInstructor?.selectionStyle = .None
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
            cellCourse?.ratingControl.rating = Double(course.review) ?? 3.5
            
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
        if indexPath.section < 5 {
            return
        }
        println("Click row \(indexPath.section)")
        
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
    // MARK: - Event handling
    func actionButtonBuy(sender: UIButton) {
        println("Click button buy!")
        
        let userMoney = Int(UDMUser.shareManager.inforUser().money)
        let price = Int(course.newPrice)
        
        if userMoney >= price {
            let data = UDMInfoDictionaryBuilder.shareInstance.buyCourses(withCourseId: course.id)
            UDMService.shareInstance.buyCourses(with: data, Completion: { (data, success) in
                if success {
                    UDMAlert.alert(title: "Buy", message: "Buy courses success!!!!", dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                    dispatch_async(dispatch_get_main_queue(), {
                        sender.selected = true
                        self.isBuy = true
                        self.courseDetailTable.reloadData()
                    })
                    println("Buy courses success!!!!")
                } else {
                    UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                    dispatch_async(dispatch_get_main_queue(), {
                        sender.selected = false
                    })
                    println("ERROR message: \(data["message"]!)")
                }
            })
        } else {
            UDMAlert.alert(title: "Error", message: "You not enough money", dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
            dispatch_async(dispatch_get_main_queue(), {
                sender.selected = false
            })
        }
    }
    
    func actionButtonAddWishList(sender: UIButton) {
        println("Click button Add wishList!")
        
        if sender.selected {
            actionButtonRemoveWishList(sender)
        } else {
            let data = UDMInfoDictionaryBuilder.shareInstance.addWishList(withCourseId: course.id)
            UDMService.shareInstance.commonRequest(with: data, Completion: { (data, success) in
                if success {
                    UDMAlert.alert(title: "Add", message: "Add wishlist success!!!!", dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                    dispatch_async(dispatch_get_main_queue(), {
                        sender.selected = true
                    })
                    println("Add wishlist success!!!!")
                } else {
                    UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                    dispatch_async(dispatch_get_main_queue(), {
                        sender.selected = false
                    })
                    println("ERROR message: \(data["message"]!)")
                }
            })
        }
    }
    
    func actionButtonRemoveWishList(sender: UIButton) {
        
        let data = UDMInfoDictionaryBuilder.shareInstance.removeWishList(withCourseId: course.id)
        UDMService.shareInstance.commonRequest(with: data, Completion: { (data, success) in
            if success {
                UDMAlert.alert(title: "Remove", message: "Remove wishlist success!!!!", dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                
                    dispatch_async(dispatch_get_main_queue(), {
                    sender.selected = false
                    })
                
                println("Remove wishlist success!!!!")
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                
                dispatch_async(dispatch_get_main_queue(), {
                    sender.selected = true
                })
                println("ERROR message: \(data["message"]!)")
            }
        })
    }
    
    func actionButtonSeeAll(sender: UIButton) {
        switch sender.tag {
        case TabConfig.TabButtonSeeAll.Description:
            println("show page See all Description!")
            let courseInfoDetailViewController = CourseInfoDetailViewController.createInstance() as! CourseInfoDetailViewController
            courseInfoDetailViewController.detailString = "1234"
            self.navigationController?.pushViewController(courseInfoDetailViewController, animated: true)
            break
        case TabConfig.TabButtonSeeAll.Curriculum:
            println("show page See all Curriculum!")
            let curriculumnListViewController = CurriculumnListViewController.createInstance() as! CurriculumnListViewController
            curriculumnListViewController.curriculumnArr = curriculumnArr
            self.navigationController?.pushViewController(curriculumnListViewController, animated: true)
            break
        case TabConfig.TabButtonSeeAll.Review:
            println("show page See all Review!")
            let reviewListViewController = ReviewListViewController.createInstance()
            self.navigationController?.pushViewController(reviewListViewController, animated: true)
            break
        case TabConfig.TabButtonSeeAll.Instructor:
            println("show page See all Instructor!")
            let courseInfoDetailViewController = CourseInfoDetailViewController.createInstance() as! CourseInfoDetailViewController
            courseInfoDetailViewController.teacher = teacher
            self.navigationController?.pushViewController(courseInfoDetailViewController, animated: true)
            break
        default:
            println("Click button See all Not Found action!")
            break
        }
    }
}

