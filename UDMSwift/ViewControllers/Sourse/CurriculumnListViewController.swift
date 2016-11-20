//
//  CurriculumnListViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 10/12/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class CurriculumnListViewController: UIViewController, ViewControllerProtocol {

    // MARK: - Properties
    var curriculumnArr = [RCurruculum]()
    let tabLabel = 100

    @IBOutlet weak var curriculmnTableView: UITableView!
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("CurriculumnListViewControllerID") as! CurriculumnListViewController
    }
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        curriculmnTableView.contentInset = UIEdgeInsetsZero;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Curriculmn List"
    }
}

extension CurriculumnListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return curriculumnArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(UDMConfig.HeaderCellID.defaulCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Subtitle, reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
            cellTable?.imageView?.image = UIImage(named: "imageWhite_1")
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            label.layer.cornerRadius = 12.5
            label.layer.borderWidth = 1.0
            label.layer.borderColor = ChameleonManger.grayTheme().CGColor
            label.text = curriculumnArr[indexPath.row].numbers
            label.textAlignment = .Center
            label.tag = tabLabel
            label.backgroundColor = UIColor.clearColor()
            
            cellTable?.imageView?.addSubview(label)
            cellTable?.detailTextLabel?.textColor = ChameleonManger.grayTheme()
            cellTable?.detailTextLabel?.text = "Video - " + curriculumnArr[indexPath.row].timeVideo
            // goi y : thay image co size phu hop va mau trang
        }
        if let labelNumber = cellTable?.imageView?.viewWithTag(tabLabel) as? UILabel {
            labelNumber.text = String(indexPath.row)
        }
        
        cellTable?.textLabel?.text = curriculumnArr[indexPath.row].title
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let urlStr = UDMConfig.APIService.rootDoman + curriculumnArr[indexPath.row].videoPlay
        print("Clicked row: \(urlStr)")
        
        NSNotificationCenter.defaultCenter().postNotificationName(CourseDetailViewController.Notification.PlayVideo, object: nil, userInfo: ["URLVIDEO" : urlStr])
    }
}