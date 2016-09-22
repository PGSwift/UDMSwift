//
//  MainViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    private let heightHeader0:CGFloat = 300
    private let heightHeader = 40
    private let heightCoursesSection = 250
    private let heightCategoriSection = 200
    private let tabButton = 101
    
    private var categoryArr: [RCategory] = []
    private var courseArr: [RCourse] = []
    
    private var handlerNotificationDisConnetInternet: AnyObject?
    private var handlerNotificationGetDataCourseAndCategory: AnyObject?
    
    var numberSecction = 3

    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("MainViewControllerID") as! MainViewController
    }
    
    func configItems() {
     
        // Init screen Sign
        let signInViewController = SignInViewController.createInstance()
        self.navigationController?.pushViewController(signInViewController, animated: true)
        
        self.mainTableView.tableFooterView = UIView()
        
        self.navigationItem.title = "Featured"
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
                }
                
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                println("ERROR message: \(data["message"]!)")
            }
            
        })
        
        let data1 = UDMInfoDictionaryBuilder.shareInstance.getCourseList(with: UDMConfig.ParentIDRoot, limit: UDMConfig.CourseLimit, offset: UDMConfig.CourseOffset)
        UDMService.shareInstance.getListDataFromServer(with: data1, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                println("dataCache Course--> \(Cdata)")
                
                let changeData = UDMHelpers.changeContentData(with: Cdata)
                
                
                CacheManager.shareInstance.updateList(with: changeData, type: UDMConfig.APIService.ModelName.Course)
                
                if let courseArr = CacheManager.shareInstance.getRCourseList() {
                    self.courseArr = courseArr
                    for course in courseArr {
                        println("Course list: ---> \n \(course)")
                    }
                    self.mainTableView.reloadData()
                }
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                println("ERROR message: \(data["message"]!)")
            }
            
        })
    }
    
    // MARK: Notification
    func registerNotification() {

        handlerNotificationDisConnetInternet = NSNotificationCenter.defaultCenter().addObserverForName(UDMConfig.Notification.DisconnetedInternet, object: nil, queue: nil, usingBlock: { notification in
            
            println("Class: \(NSStringFromClass(self.dynamicType)) recived: \(notification.name)")
            
            let emptyViewController = EmptyViewController.createInstance()
            self.presentViewController(emptyViewController, animated: true, completion: nil)
        })
        
        handlerNotificationGetDataCourseAndCategory = NSNotificationCenter.defaultCenter().addObserverForName(UDMConfig.Notification.GetDataCourseAndCategory, object: nil, queue: nil, usingBlock: { notification in
            
            println("Class: \(NSStringFromClass(self.dynamicType)) recived: \(notification.name)")
            
            self.initData()
        })
    }
    
    func deregisterNotification() {
        
        if let _ = handlerNotificationDisConnetInternet {
            NSNotificationCenter.defaultCenter().removeObserver(handlerNotificationDisConnetInternet!)
        }
        
        if let _ = handlerNotificationGetDataCourseAndCategory {
            NSNotificationCenter.defaultCenter().removeObserver(handlerNotificationGetDataCourseAndCategory!)
        }
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init main screen)")
        
        registerNotification()
        
        configItems()
        
        initData()
    }
    
    deinit {
        deregisterNotification()
    }
}
// MARK: - TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return numberSecction
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 2 {
            return CGFloat(heightCoursesSection)
        }
        return CGFloat(heightCategoriSection)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return heightHeader0
        }
        return CGFloat(heightHeader)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
        if cellTable == nil {
            self.mainTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.ReuseIdentifier)
            cellTable = tableView.dequeueReusableCellWithIdentifier(MainTableViewCell.ReuseIdentifier) as? MainTableViewCell
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        } else {
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else {
            println("MainTableViewCell cannot be nil at MainViewController")
            fatalError()
        }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Custommer header 0
        var viewHeader0 = tableView.dequeueReusableHeaderFooterViewWithIdentifier(UDMConfig.HeaderCellID.defaulCell0)
        if section == 0 {
            if viewHeader0 == nil {
                viewHeader0 = UITableViewHeaderFooterView(reuseIdentifier: UDMConfig.HeaderCellID.defaulCell0)
                
                let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: Int(heightHeader0 - 50)))
                imageView.image = UIImage(named: "x")
                viewHeader0?.contentView .addSubview(imageView)
                
                let button: UIButton = UIButton.init(frame: CGRect(x: UDMConfig.getScreenRect().width - 110, y: heightHeader0 - 40, width: 100, height: CGFloat(heightHeader)))
                button.setTitleColor(ChameleonManger.theme(), forState: .Normal)
                button.layer.borderColor = UIColor.flatGreenColor().CGColor
                button.layer.borderWidth = 1.5
                button.layer.cornerRadius = 3.5
                button.layer.masksToBounds = true
                button.tag = tabButton
                button.addTarget(self, action: #selector(MainViewController.pressed(_:)), forControlEvents: .TouchUpInside)
                
                viewHeader0!.contentView.insertSubview(button, atIndex: 1)
                
                configTableViewCellNormal(with: viewHeader0!, at: section)
                
                return viewHeader0
            } else {
                configTableViewCellNormal(with: viewHeader0!, at: section)
                return viewHeader0
            }
        }
        
        var viewHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(UDMConfig.HeaderCellID.defaulCell)
        if viewHeader == nil {
            viewHeader = UITableViewHeaderFooterView(reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
            
            let button: UIButton = UIButton.init(frame: CGRect(x: CGFloat(UDMConfig.getScreenRect().width) - 110, y: 0, width: 100, height: CGFloat(heightHeader)))
            button.setTitleColor(ChameleonManger.theme(), forState: .Normal)
            button.layer.borderColor = UIColor.flatGreenColor().CGColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = 3.5
            button.layer.masksToBounds = true
            button.tag = 101
            button.addTarget(self, action: #selector(MainViewController.pressed(_:)), forControlEvents: .TouchUpInside)
            
            viewHeader!.contentView.insertSubview(button, atIndex: 1)
            
            configTableViewCellNormal(with: viewHeader!, at: section)
        } else {
            configTableViewCellNormal(with: viewHeader!, at: section)
        }
        return viewHeader
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Row selected \(indexPath)")
    }
    
    // MARK: - Config cell
    func configTableViewCellCollectionView(with cellConfig:MainTableViewCell ,at index: NSIndexPath) {
        guard let layout = cellConfig.collecttionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            println("Layout cellConfig cannot be nil at MainViewController")
            fatalError()
        }
        
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!
        
        switch index.section {
        case 0,2:
            frameUICollection = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: heightCoursesSection + 20)
            sizeItemCollection = CGSize(width: Int(UDMConfig.getScreenRect().width / 3), height: heightCoursesSection)
            break
        case 1:
            frameUICollection = CGRect(x: 0, y: 0, width: Int(UDMConfig.getScreenRect().width), height: heightCategoriSection + 20)
            sizeItemCollection = CGSize(width: Int(UDMConfig.getScreenRect().width / 3), height: heightCategoriSection)
            break
        default:
            break
        }
        
        cellConfig.collecttionView.frame = frameUICollection
        layout.itemSize = sizeItemCollection
    }
    
    func configTableViewCellNormal(with cellConfig: UITableViewHeaderFooterView, at index: Int) {
        guard let buttonDetalt = cellConfig.contentView.viewWithTag(tabButton) as? UIButton else {
            println("CellConfig cannot be nil at MainViewController")
            fatalError()
        }
        
        switch index {
        case 0:
            cellConfig.textLabel?.text = "On Sale1111"
            buttonDetalt.setTitle("button 1", forState: .Normal)
            break
        case 1:
            cellConfig.textLabel?.text = "On Sale222"
            buttonDetalt.setTitle("button 2", forState: .Normal)
            break
        case 2:
            cellConfig.textLabel?.text = "On Sale333"
            buttonDetalt.setTitle("button 3", forState: .Normal)
            break
        default:
            break
        }
    }
    // MARK: - action button
    func pressed(sender: UIButton!) {
        println("Seleted button with tab = \(sender.tag)")
        if sender.titleLabel?.text == "button 1" {
            let courseViewController: CouresListViewController = CouresListViewController.createInstance() as! CouresListViewController
            courseViewController.courseArr = self.courseArr
            self.navigationController?.pushViewController(courseViewController, animated: true)
        } else {
            let categoryViewController: CategoryViewController = CategoryViewController.createInstance() as! CategoryViewController
            categoryViewController.categoryArr = self.categoryArr
            categoryViewController.courseArr = self.courseArr
            self.navigationController?.pushViewController(categoryViewController, animated: true)
        }
    }
}
// MARK: - CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return courseArr.count
        } else {
            return categoryArr.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0 {
            let courceCellCollection: CoursesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(CoursesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath) as! CoursesCollectionViewCell
            courceCellCollection.course = self.courseArr[indexPath.item]
            return courceCellCollection
        } else if collectionView.tag == 1 {
            let categoriCellCollection: CategoriesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(CategoriesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath) as! CategoriesCollectionViewCell
            
            categoriCellCollection.nameCategory.text = categoryArr[indexPath.item].title
            categoriCellCollection.categorie = categoryArr[indexPath.item]
            
            return categoriCellCollection
        } else {
            let cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier(CategoriesCollectionViewCell.ReuseIdentifier, forIndexPath: indexPath)
            return cellCollection
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Click collectionView at row \(collectionView.tag) and index path \(indexPath)")
    }
}
