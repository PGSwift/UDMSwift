//
//  CategoryViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    //MARK: Properties
    private let screenSize = UIScreen.mainScreen().bounds
    private let heightCoursesSection = 260
    @IBOutlet weak var tableCategory: UITableView!
    
    //MARK: Data
    var arrCategory: [String]!
    
    //MARK: View life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        arrCategory = ["v", "c", "d", "e", "f", "g", "v", "c", "d", "e", "f", "g", "x", "u", "l"]

        self.tableCategory.tableFooterView = UIView()
        self.tableCategory.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "idCellSourses")
        self.tableCategory.registerClass(UITableViewCell.self, forCellReuseIdentifier: "idDefauleCell")
    }
}
//MARK: TableView
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return arrCategory.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(heightCoursesSection)
        }
        return 50
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Secction 1"
        }
        return "section 2"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return configTableViewCellCollectionView(at: indexPath)
        }
        
        let cellTable = tableView.dequeueReusableCellWithIdentifier("idDefauleCell", forIndexPath: indexPath)
        cellTable.textLabel?.text = arrCategory[indexPath.row]
        cellTable.accessoryType = .DisclosureIndicator
        return cellTable
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let myCell = cell as? MainTableViewCell else { return }
        myCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected row: \(indexPath.row) in section: \(indexPath.section)")
    }
    //MARK: Config cell
    func configTableViewCellCollectionView(at index: NSIndexPath) -> MainTableViewCell {
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!
        
        frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCoursesSection + 30)
        sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: heightCoursesSection - 10)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10)
        layout.itemSize = sizeItemCollection
        let collectionView = UICollectionView(frame: frameUICollection, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = FlatUIColors.cloudsColor()
        collectionView.clipsToBounds = true
        
        let cellCourses = MainTableViewCell.init()
        
        return cellCourses
    }
}

//MARK: CollectionView
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellCollection = UICollectionViewCell.init()
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCoursesCell", forIndexPath: indexPath)
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CollectionView view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
