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
        mainTableView.tableFooterView = UIView()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 {
            return 80
        } else if indexPath.row == 3 {
            return 150
        } else if indexPath.row == 1 || indexPath.row == 5 {
            return 260
        }
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellTable = UITableViewCell.init(style: .Default, reuseIdentifier: "idDefauleCell")
        cellTable.textLabel?.textColor = UIColor.redColor()
        cellTable.backgroundColor = UIColor.greenColor()
        
        if indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 {
            let cellCourses = MainTableViewCell.init(collection: UICollectionView.init(frame: CGRect(0, 0, screenSize.width, 260), collectionViewLayout: UICollectionViewLayout(coder: <#T##NSCoder#>))
            return cellCourses
        } else if indexPath.row == 0 {
            cellTable.textLabel?.text = "On Sale1111"
            let button: UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            button.backgroundColor = UIColor.brownColor()
            button.setTitle("vinh button111", forState: UIControlState.Normal)
            cellTable.accessoryView = button
            
        } else if indexPath.row == 2 {
            cellTable.textLabel?.text = "On Sale2222"
            let button: UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            button.backgroundColor = UIColor.brownColor()
            button.setTitle("vinh button2222", forState: UIControlState.Normal)
            cellTable.accessoryView = button
        } else if indexPath.row == 4 {
            cellTable.textLabel?.text = "On Sale3333"
            let button: UIButton = UIButton.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            button.backgroundColor = UIColor.brownColor()
            button.setTitle("vinh button333", forState: UIControlState.Normal)
            cellTable.accessoryView = button
        }
        
        return cellTable
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cellCollection = UICollectionViewCell.init()
        
        if collectionView.tag == 1 {
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCoursesCell", forIndexPath: indexPath)
            
        } else if collectionView.tag == 3 {
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCategoriesCell", forIndexPath: indexPath)
            
        } else if collectionView.tag == 5 {
            cellCollection = collectionView.dequeueReusableCellWithReuseIdentifier("idCategoriesCell", forIndexPath: indexPath)

        }
        
        return cellCollection
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CollectionView view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
