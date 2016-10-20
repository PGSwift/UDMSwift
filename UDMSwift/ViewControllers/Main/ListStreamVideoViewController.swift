//
//  ListStreamVideoViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 10/20/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class ListStreamVideoViewController: UIViewController, ViewControllerProtocol {
    // MARK: - Properties
    var streamVideoInfoList: [[String: AnyObject]] = [[String: AnyObject]]()
    
    @IBOutlet weak var tableStream: UITableView!
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("ListStreamVideoViewControllerID") as! ListStreamVideoViewController
    }

    func initData() {
        // Get Teacher Info
        let listStreamData = UDMInfoDictionaryBuilder.shareInstance.getCourseLiveList()
        UDMService.shareInstance.getListDataFromServer(with: listStreamData, Completion: { (data, success) in
            if success {
                
                guard let Cdata = data["data"] as? [[String: AnyObject]] else {
                    println("Not found data caches")
                    return
                }
                println("List Stream Course info --> \(Cdata)")
                self.streamVideoInfoList = Cdata
                self.tableStream.reloadData()
            } else {
                UDMAlert.alert(title: "Error", message: data["message"] as! String, dismissTitle: "Cancel", inViewController: self, withDismissAction: nil)
                println("ERROR message: \(data["message"]!)")
            }
            
        })
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Init main ListStreamVideoViewController")
        
        initData()
    }
}

// MARK: - Table view
extension ListStreamVideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamVideoInfoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(UDMConfig.HeaderCellID.defaulCell)
        if cellTable == nil {
            cellTable = UITableViewCell.init(style: .Subtitle, reuseIdentifier: UDMConfig.HeaderCellID.defaulCell)
            cellTable?.textLabel?.text = ""
            cellTable?.detailTextLabel?.text = ""
            cellTable?.imageView?.image = UIImage(named: "x")
        }
        
        if let url = streamVideoInfoList[indexPath.row]["thumbnail"] as? String {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                
                let img = UDMHelpers.getImageByURL(with: url)
                
                dispatch_async(dispatch_get_main_queue(), {
                    cellTable?.imageView?.image = img
                })
            }
        }
        
        if let title = streamVideoInfoList[indexPath.row]["title"] as? String {
            cellTable?.textLabel?.text = title
        }
        
        if let detailTitle = streamVideoInfoList[indexPath.row]["description"] as? String {
            cellTable?.detailTextLabel?.text = detailTitle
        }
        
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Clicked cell row: \(indexPath.row)")
        let streamVideoViewController = StreamVideoViewController.createInstance()
        self.navigationController?.pushViewController(streamVideoViewController, animated: true)
    }
}
