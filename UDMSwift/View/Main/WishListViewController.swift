//
//  WishListViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/17/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController {

    //MARK: Properties
    private let heightHeader: CGFloat = 250
    private let heightSection: CGFloat = 900
    private let screenSize = UIScreen.mainScreen().bounds
    
    //MARK: IBOutlet properties
    @IBOutlet weak var scoursesTableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scoursesTableView.tableFooterView = UIView()
        scoursesTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "idCellSourses")
        scoursesTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "idHeaderDefauleCell")
        
        self.navigationItem.title = "Wishlish"
    }
}
//MARK: TableView
extension WishListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return heightSection
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeader
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return configTableViewCellCollectionView(at: indexPath.row)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier("idHeaderDefauleCell") as UITableViewHeaderFooterView!
        cellHeader.backgroundColor = UIColor.blueColor()
        cellHeader.textLabel?.text = "ho xuan vinh demo"
        return cellHeader
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row selected \(indexPath)")
    }
    //MARK: Config cell
    func configTableViewCellCollectionView(at index: Int) -> MainTableViewCell {
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!
        
        switch index {
        case 0:
            frameUICollection = CGRect(x: 0, y: 0, width: screenSize.width, height: heightSection)
            sizeItemCollection = CGSize(width: screenSize.width/2 - 15, height: 80)
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
        collectionView.backgroundColor = FlatUIColors.cloudsColor()
        collectionView.scrollEnabled = false
        
        let cellCourses = MainTableViewCell.init()
        
        return cellCourses
    }
}
//MARK: CollectionView
extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
