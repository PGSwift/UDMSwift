//
//  MyCoursesViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/16/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class MyCoursesViewController: UIViewController {

    //MARK: Properties
    private let screenSize = UIScreen.mainScreen().bounds
    @IBOutlet weak var scoursesTableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scoursesTableView.tableFooterView = UIView()
        scoursesTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "idCellSourses")
        scoursesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "idDefauleCell")
    }
}

extension MyCoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 500
        }
        return 250
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCellWithIdentifier("idDefauleCell", forIndexPath: indexPath)
        cellTable.textLabel?.textColor = UIColor.redColor()
        cellTable.backgroundColor = UIColor.greenColor()
        cellTable.selectionStyle = .None
        
        if indexPath.row == 1 {
            return configTableViewCellCollectionView(indexPath.row)
        }
        
        return cellTable
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row selected \(indexPath)")
    }
    //MARK: Config cell
    func configTableViewCellCollectionView(index: Int) -> MainTableViewCell {
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!
        
        switch index {
        case 1:
            frameUICollection = CGRect(x: 0, y: 0, width: screenSize.width, height: 500)
            sizeItemCollection = CGSize(width: screenSize.width / 3, height: 80)
            break
        default:
            break
        }
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10)
        layout.itemSize = sizeItemCollection
        let collectionView = UICollectionView(frame: frameUICollection, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.scrollEnabled = false
        
        let cellCourses = MainTableViewCell.init(collection: collectionView)
        
        return cellCourses
    }
}

extension MyCoursesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellCollection = UICollectionViewCell.init()

        cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCategoriesCell", forIndexPath: indexPath)
        
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CollectionView view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}


