//
//  MyCoursesViewController.swift
//  UDMSwift
//
//  Created by Hanbiro on 8/16/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class MyCoursesViewController: UIViewController, ViewControllerProtocol {
    
    // MARK: - Properties
    private let heightHeader: CGFloat = 250
    private let heightSection: CGFloat = 650
    
    @IBOutlet weak var scoursesTableView: UITableView!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("MyCoursesViewControllerID") as! MyCoursesViewController
    }
    
    func configItems() {
        
        scoursesTableView.tableFooterView = UIView()
        //NOTE: Custom navigationBar
        self.navigationItem.title = "My Scourses"
        let rightAddBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(MyCoursesViewController.actionAddBarButtonItem))
        let rightSearchBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(MyCoursesViewController.actionSearchBarButtonItem))
        self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem, rightSearchBarButtonItem], animated: true)
    }
    
    func initData() {
        
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init screen MyCoursesViewController")
        
        configItems()
    }
    
    // MARK: - Event Handling
    func actionAddBarButtonItem(sender: UIButton) {
        println("Click button add bar sender = \(sender)")
    }
    
    func actionSearchBarButtonItem(sender: UIButton) {
       println("Click button add bar sender = \(sender)")
    }
}
// MARK: - TableView
extension MyCoursesViewController: UITableViewDelegate, UITableViewDataSource {
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
        var cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
        if cellTable == nil {
            self.scoursesTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.ReuseIdentifier)
            cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        } else {
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cellHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(UDMConfig.HeaderCellID.defaulCell) as UITableViewHeaderFooterView?
        if cellHeader == nil {
            cellHeader = UITableViewHeaderFooterView.init(reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
            cellHeader!.backgroundColor = UIColor.blueColor()
            cellHeader!.textLabel?.text = "ho xuan vinh demo"
        }
        return cellHeader!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else {
            println("MainTableViewCell cannot be nil at MyCoursesViewController")
            fatalError()
        }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Row \(indexPath) selected")
    }
    // MARK: - Config cell
    func configTableViewCellCollectionView(with cellConfig:MainTableViewCell ,at index: NSIndexPath) {
        guard let layout = cellConfig.collecttionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            println("Layout cellConfig cannot be nil at MyCoursesViewController")
            fatalError()
        }
        let frameUICollection = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: Int(heightSection))
        let sizeItemCollection = CGSize(width: Int(UDMConfig.getScreenRect().width / 3) - 15, height: 80)
        
        cellConfig.collecttionView.frame = frameUICollection
        layout.itemSize = sizeItemCollection
    }
}
// MARK: - CollectionView
extension MyCoursesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellCollection = UICollectionViewCell.init()
        cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier(CategoriesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath)
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Clicked CollectionView at row \(collectionView.tag) and index path \(indexPath)")
    }
}


