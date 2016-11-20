//
//  ReviewListViewController.swift
//  UDMSwift
//
//  Created by OSXVN on 10/12/16.
//  Copyright © 2016 XUANVINHTD. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController, ViewControllerProtocol {

    // MARK: - Properties
    var arrayReview = [String]()
    
    // MARK: - Initialzation
    static func createInstance() -> UIViewController {
        return MainStoryboard.instantiateViewControllerWithIdentifier("ReviewListViewControllerID") as! ReviewListViewController
    }
    @IBOutlet weak var tableReviews: UITableView!
    
    // MARK: - Life view cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableReviews.estimatedRowHeight = 44.0
        tableReviews.rowHeight = UITableViewAutomaticDimension
        tableReviews.contentInset = UIEdgeInsetsZero
        arrayReview = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Review List"
    }
}

// MARK: - Table View
extension ReviewListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayReview.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellTable = tableView.dequeueReusableCellWithIdentifier(ReviewsCell.ReuseIdentifier) as? ReviewsCell
        if cellTable == nil {
            tableView.registerNib(UINib(nibName: ReviewsCell.NibName, bundle: nil), forCellReuseIdentifier: ReviewsCell.ReuseIdentifier)
            cellTable = tableView.dequeueReusableCellWithIdentifier(ReviewsCell.ReuseIdentifier) as? ReviewsCell
        }
        return cellTable!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Clicked row: \(indexPath.row)")
    }
}
