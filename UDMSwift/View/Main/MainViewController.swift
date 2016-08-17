//
//  MainViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit


final class MainViewController: UIViewController {
    //MARK: Properties
    private let screenSize = UIScreen.mainScreen().bounds
    private let heightHeader = 40
    private let heightCoursesSection = 260
    private let heightCategoriSection = 150
    
    //MARK: IBOutlet propertes
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.tableFooterView = UIView()
        self.mainTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "idCellSourses")
        self.mainTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "idHeaderDefauleCell")
        
        self.navigationItem.title = "Featured"
    }
}
//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
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
        return CGFloat(heightHeader)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return  configTableViewCellCollectionView(at: indexPath)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier("idHeaderDefauleCell")
        configTableViewCellNormal(with: viewHeader!, at: section)
        return viewHeader
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row selected \(indexPath)")
    }
        
    //MARK: Config cell
    func configTableViewCellCollectionView(at index: NSIndexPath) -> MainTableViewCell {
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!

        switch index.section {
        case 0,2:
            frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCoursesSection + 30)
            sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: heightCoursesSection - 10)
            break
        case 1:
            frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCategoriSection + 20)
            sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: heightCategoriSection - 10)
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
        collectionView.clipsToBounds = true

        let cellCourses = MainTableViewCell.init(collection: collectionView)
        
        return cellCourses
    }
    
    func configTableViewCellNormal(with cellConfig: UITableViewHeaderFooterView, at index: Int) {
        if let buttonDetalt = cellConfig.viewWithTag(333) as? UIButton {
            
        }
        
        let button: UIButton = UIButton.init(frame: CGRect(x: screenSize.width - 100, y: CGFloat(heightHeader/2 - (heightHeader - 15)/2) , width: 80, height: CGFloat(heightHeader - 10)))
        button.setTitleColor(FlatUIColors.emeraldColor(), forState: .Normal)
        button.layer.borderColor = FlatUIColors.emeraldColor().CGColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 3.5
        button.layer.masksToBounds = true
        button.tag = 333
        button.addTarget(self, action: #selector(MainViewController.pressed(_:)), forControlEvents: .TouchUpInside)
        cellConfig.contentView.addSubview(button)
        
        switch index {
        case 0:
            cellConfig.textLabel?.text = "On Sale1111"
            button.setTitle("button 1", forState: .Normal)
            break
        case 1:
            cellConfig.textLabel?.text = "On Sale222"
            button.setTitle("button 2", forState: .Normal)
            break
        case 2:
            cellConfig.textLabel?.text = "On Sale333"
            button.setTitle("button 3", forState: .Normal)
            break
        default:
            break
        }
    }
    //MARK: action button
    func pressed(sender: UIButton!) {
        print("tab = \(sender.tag)")
    }
}
//MARK: CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellCollection = UICollectionViewCell.init()
        
        if collectionView.tag == 0 {
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCoursesCell", forIndexPath: indexPath)
            
        } else if collectionView.tag == 1 {
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCategoriesCell", forIndexPath: indexPath)
            
        } else if collectionView.tag == 2 {
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCategoriesCell", forIndexPath: indexPath)

        }
        
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CollectionView view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
