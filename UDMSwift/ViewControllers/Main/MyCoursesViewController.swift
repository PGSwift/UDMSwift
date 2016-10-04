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
    private let heightSection: CGFloat = 200
    
    private var categoryArr: [RCategory] = []
    
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
        if !UDMUser.shareManager.isLoginSuccess {
            return
        }
        
        let data = UDMInfoDictionaryBuilder.shareInstance.getCategoryList(with: UDMConfig.ParentIDRoot)
        UDMService.shareInstance.getListDataFromServer(with: data, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                println("dataCache Category--> \(Cdata)")
                
                CacheManager.shareInstance.updateList(with: Cdata, type: UDMConfig.APIService.ModelName.Category)
                
                if let categoryArr = CacheManager.shareInstance.getRCategoryList() {
                    self.categoryArr = categoryArr
                    for category in categoryArr {
                        println("Category list: ---> \n \(category)")
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
        
        println("Init screen MyCoursesViewController")
        
        configItems()
        initData()
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
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        }
        return heightSection
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeader
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellTableDefault = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
            cellTableDefault.backgroundColor = UIColor.flatWhiteColor()
            cellTableDefault.textLabel?.text = "ho xuan vinh demo"
            return cellTableDefault
        }
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
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var cellHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(UDMConfig.HeaderCellID.defaulCell) as UITableViewHeaderFooterView?
//        if cellHeader == nil {
//            cellHeader = UITableViewHeaderFooterView.init(reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
//            cellHeader!.backgroundColor = UIColor.blackColor()
//            cellHeader!.textLabel?.text = "ho xuan vinh demo"
//        }
//        return cellHeader!
//    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else {
            println("MainTableViewCell cannot be nil at MyCoursesViewController")
            return
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
        let frameUICollection = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: Int(100)) // FIXXXXX
        let sizeItemCollection = CGSize(width: Int(UDMConfig.getScreenRect().width / 3) - 30, height: 80)
        
        cellConfig.collecttionView.frame = frameUICollection
        layout.itemSize = sizeItemCollection
    }
}
// MARK: - CollectionView
extension MyCoursesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellCollection: CategoriesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(CategoriesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath) as! CategoriesCollectionViewCell
        cellCollection.categorie = categoryArr[indexPath.row]
        cellCollection.rect = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width / 3) - 30, height: 80)
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Clicked CollectionView at row \(collectionView.tag) and index path \(indexPath)")
    }
}


