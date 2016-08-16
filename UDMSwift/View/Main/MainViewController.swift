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
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.tableFooterView = UIView()
        self.mainTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: "idCellSourses")
        self.mainTableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "idHeaderDefauleCell")
        self.navigationController?.navigationBar.barTintColor = FlatUIColors.emeraldColor()
        }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 2 {
            return 260
        }
        return 150
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return  configTableViewCellCollectionView(indexPath)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier("idHeaderDefauleCell")
        configTableViewCellNormal(viewHeader!, index: section)
        viewHeader?.textLabel?.text = "Demo 1"
        return viewHeader
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row selected \(indexPath)")
    }
        
    //MARK: Config cell
    func configTableViewCellCollectionView(index: NSIndexPath) -> MainTableViewCell {
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!

        switch index.section {
        case 0,2:
            frameUICollection = CGRect(x: 0, y: 0, width: screenSize.width, height: 270)
            sizeItemCollection = CGSize(width: screenSize.width / 3, height: 250)
            break
        case 1:
            frameUICollection = CGRect(x: 0, y: 0, width: screenSize.width, height: 150)
            sizeItemCollection = CGSize(width: screenSize.width / 3, height: 140)
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

        let cellCourses = MainTableViewCell.init(collection: collectionView)
        
        return cellCourses
    }
    
    func configTableViewCellNormal(cellConfig: UITableViewHeaderFooterView, index: Int) {
        let button: UIButton = UIButton.init(frame: CGRect(x: screenSize.width - 100, y: (80/2 - 50/2) , width: 50, height: 50))
        button.backgroundColor = UIColor.brownColor()
        button.tag = index
        button.addTarget(self, action: #selector(MainViewController.pressed(_:)), forControlEvents: .TouchUpInside)
        cellConfig.contentView.addSubview(button)
        
        switch index {
        case 0:
            cellConfig.textLabel?.text = "On Sale1111"
            button.setTitle("vinh button111", forState: UIControlState.Normal)
            break
        case 1:
            cellConfig.textLabel?.text = "On Sale222"
            button.setTitle("vinh button222", forState: UIControlState.Normal)
            break
        case 2:
            cellConfig.textLabel?.text = "On Sale333"
            button.setTitle("vinh button333", forState: UIControlState.Normal)
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
