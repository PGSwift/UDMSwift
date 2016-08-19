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
    private let heightSection: CGFloat = 650
    
    //MARK: IBOutlet properties
    @IBOutlet weak var scoursesTableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scoursesTableView.tableFooterView = UIView()
        
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
        var cellTable = tableView.dequeueReusableCellWithIdentifier(idSoursesCell) as? MainTableViewCell
        if cellTable == nil {
            self.scoursesTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: idSoursesCell)
            cellTable = tableView.dequeueReusableCellWithIdentifier(idSoursesCell) as? MainTableViewCell
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        } else {
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var cellHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(idHeaderDefauleCell) as UITableViewHeaderFooterView?
        if cellHeader == nil {
            cellHeader = UITableViewHeaderFooterView.init(reuseIdentifier: idHeaderDefauleCell)
            cellHeader!.backgroundColor = UIColor.blueColor()
            cellHeader!.textLabel?.text = "ho xuan vinh demo"
        }
        
        return cellHeader!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("row selected \(indexPath)")
    }
    //MARK: Config cell
    func configTableViewCellCollectionView(with cellConfig:MainTableViewCell ,at index: NSIndexPath) {
        guard let layout = cellConfig.collecttionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            print("Not yet init collectionViewLayout")
            return
        }
        
        let frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: Int(heightSection))
        let sizeItemCollection = CGSize(width: Int(screenSize.width / 3) - 15, height: 80)
        
        cellConfig.collecttionView.frame = frameUICollection
        cellConfig.collecttionView.scrollEnabled = false
        layout.itemSize = sizeItemCollection
    }
}
//MARK: CollectionView
extension WishListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 21
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
