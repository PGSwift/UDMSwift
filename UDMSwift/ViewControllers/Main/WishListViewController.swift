//
//  WishListViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class WishListViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    private let heightHeader: CGFloat = 250
    private let heightSection: CGFloat = 650
    
    var courseArr: [RWishList] = []
    
    @IBOutlet weak var scoursesTableView: UITableView!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("WishListViewControllerID") as! SignInViewController
    }
    
    func configItems() {
        
        scoursesTableView.tableFooterView = UIView()
        
        self.navigationItem.title = "Wishlish"
    }
    
    func initData() {
        if !UDMUser.shareManager.isLoginSuccess {
            return
        }
        
        
        let data1 = UDMInfoDictionaryBuilder.shareInstance.getWishList()
        UDMService.shareInstance.getListDataFromServer(with: data1, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                println("dataCache Course--> \(Cdata)")
                
                CacheManager.shareInstance.clean(with: UDMConfig.APIService.ModelName.WishList)
                
                let changeData = UDMHelpers.changeContentData(with: Cdata)
                
                CacheManager.shareInstance.updateList(with: changeData, type: UDMConfig.APIService.ModelName.WishList)
                
                if let courseArr = CacheManager.shareInstance.getRWishList() {
                    self.courseArr = courseArr
                    for course in courseArr {
                        println("Course list: ---> \n \(course)")
                    }
                    self.scoursesTableView.reloadData()
                }
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                println("ERROR message: \(data["message"]!)")
            }
            
        })
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init Screen WishLishViewController")
        
        configItems()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        initData()
        self.scoursesTableView.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0);
    }
}
// MARK: - TableView
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        courseDetailViewController.course = convertToCourses(with: courseArr[indexPath.row])
        courseDetailViewController.isRemoveWishList = true
        
        var courseArrSmall = [RCourse]()
        for (index, course) in courseArr.enumerate() {
            if index > 5 {
                break
            }
            courseArrSmall.append(convertToCourses(with: course))
        }
        courseDetailViewController.courseArr = courseArrSmall
        self.navigationController?.pushViewController(courseDetailViewController, animated: true)
    }
    
    func convertToCourses(with data: RWishList) -> RCourse {
        let result = RCourse()
        result.id = data.id
        result.author = data.author
        result.authorID = data.authorID
        result.descriptions = data.descriptions
        result.newPrice = data.newPrice
        result.oldPrice = data.oldPrice
        result.rank = data.rank
        result.review = data.review
        result.sale = data.sale
        result.student = data.student
        result.thumbnail = data.thumbnail
        result.title = data.title
        
        return result
    }

//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return heightSection
//    }
//    
//    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return heightHeader
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
//        if cellTable == nil {
//            self.scoursesTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.ReuseIdentifier)
//            cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
//            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
//        } else {
//            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
//        }
//        return cellTable!
//    }
//    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var cellHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(UDMConfig.HeaderCellID.defaulCell) as UITableViewHeaderFooterView?
//        if cellHeader == nil {
//            cellHeader = UITableViewHeaderFooterView.init(reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
//            cellHeader!.backgroundColor = UIColor.blueColor()
//            cellHeader!.textLabel?.text = "ho xuan vinh demo"
//        }
//        return cellHeader!
//    }
//    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        guard let tableViewCell = cell as? MainTableViewCell else {
//            println("TableViewCell cannot be nil here")
//            fatalError() }
//        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        println("Row selected \(indexPath)")
//    }
//    // MARK: - Config cell
//    func configTableViewCellCollectionView(with cellConfig:MainTableViewCell ,at index: NSIndexPath) {
//        guard let layout = cellConfig.collecttionView.collectionViewLayout as? UICollectionViewFlowLayout else {
//            println("CellConfig cannot be nil here")
//            fatalError()
//        }
//        
//        let frameUICollection = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: Int(heightSection))
//        let sizeItemCollection = CGSize(width: Int(UDMConfig.getScreenRect().width / 3) - 15, height: 80)
//        
//        cellConfig.collecttionView.frame = frameUICollection
//        cellConfig.collecttionView.scrollEnabled = false
//        
//        layout.itemSize = sizeItemCollection
//    }
}
//// MARK: - CollectionView
//extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 21
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        var cellCollection: CategoriesCollectionViewCell!
//        cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier(CategoriesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath) as! CategoriesCollectionViewCell
//        cellCollection.rect = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width / 3) - 15, height: 80)
//        return cellCollection
//    }
//    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print("Clicked CollectionView at row \(collectionView.tag) and index path \(indexPath)")
//    }
//}
