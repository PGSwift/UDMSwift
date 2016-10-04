//
//  CategoryViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class CategoryViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    private let screenSize = UIScreen.mainScreen().bounds
    private let heightCoursesSection = 260
    @IBOutlet weak var tableCategory: UITableView!
    
    var categoryArr: [RCategory] = []
    var courseArr: [RCourse] = []
    
    // MARK: - Initialzzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("CategoryViewControllerID") as! CategoryViewController
    }
    
    func configItems() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableCategory.contentInset = UIEdgeInsetsZero;
        
        self.tableCategory.tableFooterView = UIView()
        self.tableCategory.registerClass(UITableViewCell.self, forCellReuseIdentifier: "idDefauleCell")
    }

    // MARK: - View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init Screen CategoryViewController")
        
        configItems()
    }
}
// MARK: - TableView
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return categoryArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(heightCoursesSection)
        }
        return 50
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popular Courses"
        }
        return "Browse Subcategories"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
            if cellTable == nil {
                self.tableCategory.registerClass(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.ReuseIdentifier)
                cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
                configTableViewCellCollectionView(with:cellTable!, at: indexPath)
            } else {
                configTableViewCellCollectionView(with:cellTable!, at: indexPath)
            }
            return cellTable!
        }
        
        var cellTable = tableView.dequeueReusableCellWithIdentifier(UDMConfig.HeaderCellID.defaulCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Default, reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
        }
        cellTable!.accessoryType = .DisclosureIndicator
        cellTable!.textLabel?.text = categoryArr[indexPath.row].title
        
        return cellTable!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let myCell = cell as? MainTableViewCell else {
            println("myCell cannot be nil here")
            return
        }
        myCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Selected row: \(indexPath.row) in section: \(indexPath.section)")
        let courseViewController: CouresListViewController = CouresListViewController.createInstance() as! CouresListViewController
        courseViewController.courseArr = self.courseArr
        courseViewController.title = self.categoryArr[indexPath.row].title
        self.navigationController?.pushViewController(courseViewController, animated: true)
    }
    // MARK: - Config cell
    func configTableViewCellCollectionView(with cellConfig:MainTableViewCell ,at index: NSIndexPath) {
        guard let layout = cellConfig.collecttionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            println("cellConfig cannot be nil here")
            fatalError()
        }
        
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!
 
        frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCoursesSection + 20)
        sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: heightCoursesSection)
        cellConfig.collecttionView.frame = frameUICollection
        layout.itemSize = sizeItemCollection
    }}

// MARK: - CollectionView
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.courseArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellCollection: CoursesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(CoursesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath) as! CoursesCollectionViewCell
        cellCollection.course = self.courseArr[indexPath.item]
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Clicked CollectionView view at row \(collectionView.tag) and index path \(indexPath)")
        if collectionView.tag == 0 {
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
        
        if collectionView.tag == 1 {
            
        }
    }
}
