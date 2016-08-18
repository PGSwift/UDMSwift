//
//  MainViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 8/15/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

let idHeaderDefauleCell0 = "idHeaderDefauleCell0"
let idHeaderDefauleCell = "idHeaderDefauleCell"
let idSoursesCell = "idCellSourses"

let screenSize = UIScreen.mainScreen().bounds

final class MainViewController: UIViewController {
    //MARK: Properties
    private let heightHeader0:CGFloat = 300
    private let heightHeader = 40
    private let heightCoursesSection = 250
    private let heightCategoriSection = 200
    
    //MARK: IBOutlet propertes
    @IBOutlet weak var mainTableView: UITableView!
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainTableView.tableFooterView = UIView()
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
        if section == 0 {
            return heightHeader0
        }
        return CGFloat(heightHeader)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(idSoursesCell) as? MainTableViewCell
        if cellTable == nil {
            self.mainTableView.registerClass(MainTableViewCell.self, forCellReuseIdentifier: idSoursesCell)
            cellTable = tableView.dequeueReusableCellWithIdentifier(idSoursesCell) as? MainTableViewCell
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        } else {
            configTableViewCellCollectionView(with:cellTable!, at: indexPath)
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? MainTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Custommer header 0
        var viewHeader0 = tableView.dequeueReusableHeaderFooterViewWithIdentifier(idHeaderDefauleCell0)
        if section == 0 {
            if viewHeader0 == nil {
                viewHeader0 = UITableViewHeaderFooterView(reuseIdentifier: idHeaderDefauleCell0)
                
                let imageView = UIImageView.init(frame: CGRect(x: 0, y: 0, width: Int(screenSize.width), height: Int(heightHeader0 - 50)))
                imageView.image = UIImage(named: "x")
                viewHeader0?.contentView .addSubview(imageView)
                
                let button: UIButton = UIButton.init(frame: CGRect(x: screenSize.width - 110, y: heightHeader0 - 40, width: 100, height: CGFloat(heightHeader)))
                button.setTitleColor(FlatUIColors.emeraldColor(), forState: .Normal)
                button.layer.borderColor = FlatUIColors.emeraldColor().CGColor
                button.layer.borderWidth = 1.5
                button.layer.cornerRadius = 3.5
                button.layer.masksToBounds = true
                button.tag = 101
                button.addTarget(self, action: #selector(MainViewController.pressed(_:)), forControlEvents: .TouchUpInside)
                viewHeader0!.contentView.insertSubview(button, atIndex: 1)
                configTableViewCellNormal(with: viewHeader0!, at: section)
                return viewHeader0
            } else {
                configTableViewCellNormal(with: viewHeader0!, at: section)
                return viewHeader0
            }
        }
        
        var viewHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(idHeaderDefauleCell)
        if viewHeader == nil {
            viewHeader = UITableViewHeaderFooterView(reuseIdentifier: idHeaderDefauleCell)
            
            let button: UIButton = UIButton.init(frame: CGRect(x: screenSize.width - 110, y: 0, width: 100, height: CGFloat(heightHeader)))
            button.setTitleColor(FlatUIColors.emeraldColor(), forState: .Normal)
            button.layer.borderColor = FlatUIColors.emeraldColor().CGColor
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
        print("row selected \(indexPath)")
    }
    
    //MARK: Config cell
    func configTableViewCellCollectionView(with cellConfig:MainTableViewCell ,at index: NSIndexPath) {
        guard let layout = cellConfig.collecttionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            print("Not yet init collectionViewLayout")
            return
        }
        
        var frameUICollection: CGRect!
        var sizeItemCollection: CGSize!
        
        switch index.section {
        case 0,2:
            frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCoursesSection + 20)
            sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: heightCoursesSection)
            break
        case 1:
            frameUICollection = CGRect(x: 0, y: 0, width: Int(screenSize.width), height: heightCategoriSection + 20)
            sizeItemCollection = CGSize(width: Int(screenSize.width / 3), height: heightCategoriSection)
            break
        default:
            break
        }
        
        cellConfig.collecttionView.frame = frameUICollection
        layout.itemSize = sizeItemCollection
    }
    
    func configTableViewCellNormal(with cellConfig: UITableViewHeaderFooterView, at index: Int) {
        guard let buttonDetalt = cellConfig.contentView.viewWithTag(101) as? UIButton else {
            print("Not yet init button in Header")
            return
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
    //MARK: action button
    func pressed(sender: UIButton!) {
        print("tab = \(sender.tag)")
    }
}
//MARK: CollectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
